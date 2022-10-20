<template>
  <v-app class="pa-5 grey lighten-3">
    <v-card class="pa-4 mt-6 mb-11 mx-12 input-form-card" flat>
      <div class="d-flex justify-center input-form-header-title pt-0">今日の総再生時間</div>
      <div class='d-flex justify-center input-form-header-body ml-1'>
        {{ formattedTotalDuration }}<span class="minute-text ml-1 mt-4">分</span>
      </div>
    </v-card>
    <CardWithHeader headerText="動画を記録する" class="p-5 mb-7">
      <v-form class="mx-11 mt-13"> 
        <div class="d-flex justify-center flex-column">
          <v-text-field
            v-model="movie.url"
            @input="serchMovie"
            label="URL"
            required
            class="mb-2"
          ></v-text-field>
          <div v-if="movie.thumbnail && error === null" class="mb-7 movie-thumbnail-area">
            <img :src="movie.thumbnail" alt="" class="movie-thumbnail">
            <div class="px-2 white--text movie-duration">
              <span v-if="movie.duration >= 3600">
                {{Math.floor(movie.duration/3600)}}:
              </span>
              <span v-if="movie.duration >= 60">
                {{Math.floor(movie.duration/60%60)}}:
              </span>{{movie.duration%60}}
            </div>
            <div class="movie-title">
              {{ movie.title }}
            </div>
          </div>
          <div class="mb-7" v-if="error !== null">
            <p class="red--text mt-5 text-h6">動画が見つかりません</p>
          </div>
          <div class="mb-7" v-if="unsavedError !== null">
            <p class="red--text mt-5 text-h6">動画を保存できませんでした。URLを再度入力してください。</p>
          </div>
          <div class="mb-7 d-flex justify-center">
            <ButtonBase color="#949494" @click.native="movieReset" class="mr-7" >キャンセル</ButtonBase>
            <ButtonBase color="#E8730E" @click.native="submitData">保存</ButtonBase>
          </div>
        </div>
      </v-form>
    </CardWithHeader>
    <v-card class="pa-6 input-form-card" flat>
      <ol class="how-to-use">
        <li class="mb-2">Youtube動画詳細欄の「共有」を選択</li>
        <li class="mb-2">URLをコピーする</li>
        <li class="mb-2">上ボックスに貼り付ける</li>
      </ol>
    </v-card>
  </v-app>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
import CardWithHeader from './modules/CardWithHeader.vue';
import ButtonBase from './modules/ButtonBase.vue';

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
  components: { CardWithHeader, ButtonBase },
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
      /// TODO : このキーも環境変数に設定する
      const Key = 'AIzaSyDmNgXHcyUTEkPFoxXsyVTZms7RIhwguBY';
      let movieId = ""
      let apiUrl = 'https://www.googleapis.com/youtube/v3/videos'; 
      if (this.movie.url.includes("youtu.be")) {
        movieId = this.movie.url.split('/')[3]
      } else if (this.movie.url.includes("short")) {
        movieId = this.movie.url.split('/')[4]
      } else {
        movieId = this.movie.url.split('=')[1]
      }
      apiUrl += '?id=' + movieId;
      apiUrl += '&key=' + Key;
      apiUrl += '&part=snippet,contentDetails'
      return apiUrl;
    },
    totalDuration: function() {
      return this.$store.getters.totalDuration
    },
    formattedTotalDuration: function() {
      return Math.floor(this.totalDuration/60)
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
          if(e.items[0].snippet.thumbnails.medium) {
            this.movie.thumbnail = e.items[0].snippet.thumbnails.medium.url
          } else {
            this.movie.thumbnail = e.items[0].snippet.thumbnails.high.url
          }
          this.movie.title = e.items[0].snippet.title
          this.movie.duration = this.calculateDuration(e.items[0].contentDetails.duration)
          this.movie.date = this.formattedDate
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
.input-form-card {
  border: 0.5px solid #949494 !important;
  border-radius: 2px !important;
}
.input-form-header-title {
  font-size: 15px;
  color: #333333;
}
.input-form-header-body {
  font-size: 30px;
  color: #333333;
}
.minute-text {
  font-size: 15px;
}
.how-to-use {
  font-size: 15px;
}
.movie-thumbnail-area {
  position: relative;
}
.movie-thumbnail {
  width: 100%;
}
.movie-duration {
  position: absolute;
  top: 120px;
  right: 6px;
  font-size: 13px;
  background-color: #333333;
  display: flex;
  justify-content: center;
  align-items: center;
}
.movie-title {
  display: -webkit-box;
  overflow: hidden;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  font-size: 13px;
}
</style>
