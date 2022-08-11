<template>
  <v-app class="pa-5 grey lighten-3">
    <v-card class="pa-4 mb-4" width="100%">
      <div class="d-flex justify-center input-form-header-title pt-0">今日の総再生時間</div>
      <div class='d-flex justify-center input-form-header-body'>
        <span v-if="totalDuration >= 3600">
          {{Math.floor(totalDuration/3600)}}時間
        </span>
        <span v-if="totalDuration >= 60">
          {{Math.floor(totalDuration/60%60)}}分
        </span>{{totalDuration%60}}秒
      </div>
    </v-card>
    <v-card class="p-5 mb-16" width="100%">
      <v-form @submit.prevent="submitData" class="ma-5"> 
        <v-row>
          <v-col cols="12">
            <v-text-field
              v-model="movie.url"
              @change="serchMovie"
              label="url"
              required
            ></v-text-field>
          </v-col>
          <v-col v-if="movie.thumbnail && error === null">
            <v-img :src="movie.thumbnail" :aspect-ratio="4/3" max-width="400px">
              <div bottom class="mt-1 mr-2 black white--text text-right">
                <span v-if="movie.duration >= 3600">
                  {{Math.floor(movie.duration/3600)}}時間
                </span>
                <span v-if="movie.duration >= 60">
                  {{Math.floor(movie.duration/60%60)}}分
                </span>{{movie.duration%60}}秒
              </div>
            </v-img>
          </v-col>
          <v-col cols="12" v-if="error !== null">
            <p class="red--text mt-5 text-h6">動画が見つかりません</p>
          </v-col>
          <v-col cols="12" v-if="unsavedError !== null">
            <p class="red--text mt-5 text-h6">動画を保存できませんでした。URLを再度入力してください。</p>
          </v-col>
          <v-col cols="12">
            <v-textarea
              v-model="movie.comment"
              label="コメント"
              outlined
              id="movie-input"
            ></v-textarea>
          </v-col>
          <v-col cols="12" class="d-flex justify-center">
            <v-btn @click="movieReset" class="white--text mb-5 mr-5" color="#A7DDEA" width="100px">キャンセル</v-btn>
            <v-btn type="submit" class="white--text mb-5" width="100px" color="#18B1CE">保存</v-btn>
          </v-col>
        </v-row>
      </v-form>
    </v-card>
  </v-app>
</template>

<script>
import axios from 'axios';
import moment from 'moment';

axios.interceptors.request.use((config) => {
  if(['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-Requested-With'] = 'XMLHttpReq'
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});

export default {
  data: function () {
    return {
      movie: {
        url: '',
        duration: '',
        title: '',
        comment: '',
        thumbnail: '',
        date: '',
      },
      error: null,
      unsavedError: null,
    }  
  },
  mounted () {
    this.$store.dispatch('getTotalDuration');
  },
  computed: {
    apiUrl: function() {
      const Key = 'AIzaSyDmNgXHcyUTEkPFoxXsyVTZms7RIhwguBY';
      let Id = this.movie.url.split('=')[1]
      let apiUrl = 'https://www.googleapis.com/youtube/v3/videos'; 
      apiUrl += '?id=' + Id;
      apiUrl += '&key=' + Key;
      apiUrl += '&part=snippet,contentDetails'
      return apiUrl;
    },
    totalDuration: function() {
      return this.$store.getters.totalDuration
    },
    dateStatus: function() {
      return this.$store.getters.dateStatus
    },
    formattedDate: function() {
      return moment().add(this.dateStatus, 'd').toDate()
    },
  },
  methods: {
    calculateDuration: function(duration) {
      // durationは'PT8H2M29S'のような形で送られてくる。なぜかSecondは＋１秒される。
      if(duration.includes('H')) {
        let hour = Number(duration.match(/T(.*)H/)[1]);
        let minute = Number(duration.match(/H(.*)M/)[1]);
        let second = Number(duration.match(/M(.*)S/)[1]);
        return hour*3600 + minute*60 + (second - 1);
      }else if(duration.includes('M')) {
        let minute = Number(duration.match(/T(.*)M/)[1]);
        if (duration.match(/M(.*)S/)) {
          let second = Number(duration.match(/M(.*)S/)[1]);
          return minute*60 + (second - 1);
        }
         return minute*60;
      }else{
        let second = Number(duration.match(/T(.*)S/)[1]);
        return second - 1;
      }
    },
    submitData: function() {
      this.$store.dispatch('requireLogin');
      if(this.error === null) {
        axios
          .post('/movies', this.movie)
          .then(() => {
            this.$router.push({name: 'HomeIndexPage'})
          })
          .catch()
      } else {
        this.error = null
        this.unsavedError = '動画を保存できませんでした。URLを見直してください'
        this.movieReset();
      }
    },
    movieReset: function() {
      this.movie.url = '';
      this.movie.duration = '';
      this.movie.title = '';
      this.movie.comment = '';
      this.movie.thumbnail = '';
      this.movie.date = '';
      this.error = null;
      this.unsavedError = null;
    },
    serchMovie: function() {
      axios
        .get(this.apiUrl)
        .then(response => {
          this.error = null;
          this.unsavedError = null;
          let e = response.data;
          this.movie.thumbnail = e.items[0].snippet.thumbnails.high.url
          this.movie.title = e.items[0].snippet.title
          this.movie.duration = this.calculateDuration(e.items[0].contentDetails.duration)
          this.movie.date = this.formattedDate
          this.$vuetify.goTo("#movie-input")
        })
        .catch(error => {
          console.error(error);
          this.error = error;
        });
    },
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
.input-form-header-title {
  font-size: 20px;
  color: #333333;
}
.input-form-header-body {
  font-size: 40px;
  color: #333333;
}
</style>