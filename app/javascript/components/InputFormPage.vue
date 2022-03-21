<template>
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
          <p class="red--text mt-5 text-h6">動画を保存できませんでした。URLを見直してください</p>
        </v-col>
        <v-col cols="12">
          <v-textarea
            v-model="movie.comment"
            label="コメント"
            outlined
          ></v-textarea>
        </v-col>
        <v-col cols="12" class="d-flex justify-center">
          <v-btn @click="movieReset" class="white--text grey lighten-1 mb-5 mr-5">キャンセル</v-btn>
          <v-btn type="submit" class="white--text green accent-2 mb-5">保存</v-btn>
        </v-col>
      </v-row>
  </v-form>
</template>

<script>
import axios from 'axios';
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
    axios
      .get('/movies.json')
      .then(res => {
        console.log(res)
      })
      .catch(error => {
        this.$router.push({name: 'LoginForm' })
        console.log(error)
      })
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
        let second = Number(duration.match(/M(.*)S/)[1]);
        return minute*60 + (second - 1);
      }else{
        let second = Number(duration.match(/T(.*)S/)[1]);
        return second - 1;
      }
    },
    submitData: function() {
      if(this.error === null) {
        axios
          .post('/movies', this.movie)
          .then(response => {
            let e = response.data
            this.$router.push({name: 'HomeIndexPage'})
          })
          .catch(error => {
            console.error(error);
            this.error = error;
          })
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
          this.movie.thumbnail = e.items[0].snippet.thumbnails.standard.url
          this.movie.title = e.items[0].snippet.title
          this.movie.duration = this.calculateDuration(e.items[0].contentDetails.duration)
          this.movie.date = this.$store.getters.storeToday
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
</style>