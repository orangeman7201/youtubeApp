<template>
  <v-app v-if="loaded" id="app">
    <div class="pa-5 home-background">
      <div class="circle-progressbar-area mt-5 mb-10">
        <div class="circle-background">
          <v-progress-circular
            :rotate="-90"
            :size="250"
            :width="8"
            :value="normalDurationParLimit"
            :color="normalCircleColor"
          >
            <v-progress-circular
            :rotate="-90"
            :size="250"
            :width="8"
            :value="excessDurationParLimit"
            color="#EB440C"
            >
              <div>
                <div class="d-flex justify-center home-header-title">今日の総再生時間</div>
                  <div class='d-flex justify-center home-header-body'>
                    {{ formattedTotalDuration }}<span class="text-minute">分</span>
                  </div>
              </div>
            </v-progress-circular>
          </v-progress-circular>
        </div>
      </div>
      <CardWithHeader headerText="動画を記録する" class="p-5 mb-7">
        <v-form class="mx-11 mt-6"> 
          <div class="d-flex justify-center flex-column">
            <v-text-field
              v-model="movie.url"
              @input="searchMovie"
              label="URL"
              required
              class="mb-5"
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
              <ButtonBase color="#D9D9D9" @click.native="movieReset" class="mr-7" >キャンセル</ButtonBase>
              <ButtonBase color="#1995AD" @click.native="submitData">保存</ButtonBase>
            </div>
          </div>
        </v-form>
      </CardWithHeader>
      <CardWithHeader headerText="週間サマリー">
        <Chart class="mt-5 mb-14 mx-4 chart" :chartData="chartItems" :options="chartOptions" />
        <DurationTable :items="weeklyDurationSum" :limit="storeUser.limit" />
      </CardWithHeader>
    </div>
  </v-app>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
import DurationTable from '../modules/DurationTable.vue';
import Chart from '../modules/Chart.js';
import CardWithHeader from '../modules/CardWithHeader.vue';
import ButtonBase from '../modules/ButtonBase.vue';

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
  components: { DurationTable, Chart, CardWithHeader, ButtonBase },
  mounted () {
    this.getWeeklyDurationSum();
    this.$store.dispatch('getTotalDuration');
    // 円グラフを２つ重ねたため色が汚くなるのだが、その対策のため２つ目円の背景(グレー)を消す
    // もっといい方法ありそう $nextTickを使ったがうまくいかなかった。
    setTimeout(() => {
      const vuetifyCircle = document.getElementsByClassName('v-progress-circular__underlay')
      vuetifyCircle[1].classList.remove('v-progress-circular__underlay')
    }, 600)
  },
  data: function () {
    return {
      weeklyDurationSum: {},
      loaded: false,
      chartOptions: {
        responsive: true,
        maintainAspectRatio: false,
        legend: {
          display: false
        },
        scales: {
          xAxes: [{
            display: true,
            gridLines: {
              display:false
            },
            ticks: {
              fontSize: 9,
            }
          }],
          yAxes: [{
            display: true,
            position: 'right',
            ticks: {
              maxTicksLimit: 3,
              fontSize: 9,
            }
          }]
        },
      },
      movie: {
        url: '',
        duration: '',
        title: '',
        comment: '',
        thumbnail: '',
      },
      error: null,
      unsavedError: null,
    }  
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    totalDuration: function() {
      return this.$store.getters.totalDuration
    },
    formattedTotalDuration: function() {
      return Math.floor(this.totalDuration/60)
    },
    dateArray: function() {
      return this.weeklyDurationSum.map(item => {
        return moment(new Date(item.date)).format("MM/DD")
      }).reverse()
    },
    durationArray: function() {
      return this.weeklyDurationSum.map(item => {
        return item.duration / 60
      })
    },
    chartItems: function() {
      return {
        labels: this.dateArray,
        datasets: [{
          data: this.durationArray.reverse(),
          backgroundColor: 'lightblue'
        }]
      }
    },
    isTotalDurationOverLimit: function() {
      return this.totalDuration > this.storeUser.limit
    },
    normalDurationParLimit: function() {
      return Math.floor(( this.totalDuration / this.storeUser.limit ) * 100)
    },
    normalCircleColor: function() {
      return this.isTotalDurationOverLimit ? '#F59744' : '#1995AD'
    },
    excessDurationParLimit: function() {
      if(!this.isTotalDurationOverLimit) {
        return 0
      }
      return Math.floor(( (this.totalDuration - this.storeUser.limit) / this.storeUser.limit ) * 100)
    },
    apiUrl: function() {
      const Key = 'AIzaSyDmNgXHcyUTEkPFoxXsyVTZms7RIhwguBY';
      let movieId = ""
      let apiUrl = 'https://www.googleapis.com/youtube/v3/videos'; 
      if (this.movie.url.includes("youtu.be")) {
        movieId = this.movie.url.split('/')[3]
      } else if (this.movie.url.includes("shorts")) {
        movieId = this.movie.url.split('?')[0].split('/')[4]
      } else {
        movieId = this.movie.url.split('=')[1]
      }
      apiUrl += '?id=' + movieId;
      apiUrl += '&key=' + Key;
      apiUrl += '&part=snippet,contentDetails'
      return apiUrl;
    },
  },
  methods: {
    oneDayAgo: function() {
      this.$store.dispatch('oneDayAgo');
    },
    oneDayAfter: function() {
      this.$store.dispatch('oneDayAfter');
    },
    getWeeklyDurationSum() {
      axios
      .get('/api/v1/weekly_duration_sum')
      .then(response => {
        this.weeklyDurationSum = response.data
        this.loaded = true
      })
      .catch(error => {
        console.log(error)
      })
    },
    submitData: function() {
      this.$store.dispatch('requireLogin');
      if(this.error === null) {
        axios
          .post('/api/v1/movies', this.movie)
          .then(() => {
            this.$router.go({path: this.$router.currentRoute.path, force: true})
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
      this.error = null;
      this.unsavedError = null;
    },
    searchMovie: function() {
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
        })
        .catch(error => {
          console.error(error);
          this.error = error;
        });
    },
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
  }
  
}
</script>

<style scoped>
  .flex-grow {
    flex-grow: 1;
  }
  .circle-progressbar-area {
    display: flex;
    justify-content: center;
  }
  .circle-background {
    background-color: #FFFFFF;
    border-radius: 100%;
  }
  .home-header-title {
    font-size: 16px;
    line-height: 18px;
    color: #333333;
    padding: 0;
    margin-bottom: 4px;
  }
  .home-header-body {
    padding: 0 0 0 20px;
    font-size: 32px;
    line-height: 39px;
    max-height: 39px;
    color: #333333;
    align-items: center;
    vertical-align: middle;
  }
  .home-background {
    display: block;
    background-color: #F1F1F1;
  } 
  .text-minute {
    font-size: 15px;
    margin-left: 4px;
    padding-top: 14px;
  }
  .excessText {
    border: 0.8px solid #EB440C;
    margin-right: 4px;
    padding: 0 7px;
  }
  .chart {
    height: 148px;
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
