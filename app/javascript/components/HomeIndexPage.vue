<template>
  <v-app v-if="userState === 'ok'" id="app">
    <v-row class="pa-5 grey lighten-3">
      <v-row class="pa-5">

        <v-card class="py-9 px-5" width="100%" height="274px">
          <v-card-title class="d-flex justify-center home-header-title">今日の総再生時間</v-card-title>
          <v-card-text class='d-flex justify-center home-header-body'>
            <span v-if="totalDuration >= 3600">
              {{Math.floor(totalDuration/3600)}}時間
            </span>
            <span v-if="totalDuration >= 60">
              {{Math.floor(totalDuration/60%60)}}分
            </span>{{totalDuration%60}}秒
          </v-card-text>
          <div class='d-flex justify-center home-header-progress'>
            <v-progress-linear></v-progress-linear>
          </div>
          <!-- 目標はuser.timeみたいな感じで取得する -->
          <v-card-text class='d-flex justify-center home-header-target-time'>目標 60分/日</v-card-text>
        </v-card>
      </v-row>
      
      <v-row>
        <v-row class="hidden-sm-and-down" align="center" justify="end">
          <v-col cols="1" >
            <v-btn fab class="green accent-3 white--text" >
              <v-icon :class="[$vuetify.breakpoint.smAndDown ? 'text-h5' : 'text-h4']">mdi-plus</v-icon>
            </v-btn>
          </v-col>
        </v-row>

        <v-row v-if="this.todayMovies.length === 0">
          <v-col class="pt-2 pb-1 d-flex justify-center">
            <p class="text-h4 mb-10">動画を視聴していません</p>
          </v-col>
        </v-row>

        <v-card v-for="movie in todayMovies" :key="movie.id" @click="router(movie.id)" :class="[$vuetify.breakpoint.smAndDown ? 'pa-5 flex-grow' : 'ma-10 px-15 pb-10 pt-7']" outlined tile>

          <v-row align="center" justify="center"> 
            <v-col cols="5" md="4" :class="[$vuetify.breakpoint.smAndDown ? 'pa-0' : '']">
              <v-img :src="movie.thumbnail" max-width="150px"  :class="[$vuetify.breakpoint.smAndDown ? 'ml-3 my-3' : '']">
                <div bottom class="black white--text text-right hidden-sm-and-down" :class="[$vuetify.breakpoint.smAndDown ? 'text-caption' : 'mt-1 mr-2']">
                  <span v-if="movie.duration >= 3600">
                    {{Math.floor(movie.duration/3600)}}時間
                  </span>
                  <span v-if="movie.duration >= 60">
                    {{Math.floor(movie.duration/60%60)}}分
                  </span>{{movie.duration%60}}秒
                </div>
              </v-img>
            </v-col>

            <v-col cols="7" md="8" :class="[$vuetify.breakpoint.smAndDown ? 'pa-0' : '']">
              <div class="ma-2">
                <body :class="[$vuetify.breakpoint.smAndDown ? 'caption' : 'text-h5']">{{movie.title}}</body>
              </div>
                <v-divider></v-divider>
              <div class="ma-3" :class="[$vuetify.breakpoint.smAndDown ? 'body-2' : 'text-h5']">
                <p>{{movie.comment}}</p>
              </div>
            </v-col>

          </v-row>
        </v-card>
      </v-row>
    </v-row>
  </v-app>
</template>

<script>
import axios from 'axios';
export default {
  mounted () {
    this.getMovie();
  },
  data: function () {
    return {
      movies: [],
    }  
  },
  computed: {
    userState: function() {
      return this.$store.state.user;
    },
    totalDuration: function() {
      let sum = 0;
      for(let id = 0; id < this.todayMovies.length; id++) {
        sum += this.todayMovies[id].duration;
      };
        return sum;
    },  
    todayMovies: function() {
      const todayMovies = this.movies.filter(element => {
        const movieDate = String(new Date(element.date)).slice(0, 15);
        const today = String(this.$store.getters.storeToday).slice(0, 15);
        if(movieDate === today) {
          return element;
        }
      })
      return todayMovies;
    }
  },
  methods: {
    router: function(index) {
       this.$router.push(`movies/${index}`)
    },
    routerNew: function() {
       this.$router.push('movies/new')
    },
    oneDayAgo: function() {
      this.$store.dispatch('oneDayAgo');
    },
    oneDayAfter: function() {
      this.$store.dispatch('oneDayAfter');
    },
    getMovie() {
      axios
      .get('/movies')
      .then(response => {
        this.movies = response.data;
        this.$store.dispatch('updateStatus');
      })
      .catch(error => {
        this.$router.push({name: 'LoginForm' })
        console.log(error)
      })
    },
  }
  
}
</script>

<style scoped>
  .flex-grow {
    flex-grow: 1;
  }
  .home-header-title {
    font-size: 20px;
    padding: 0;
    margin-bottom: 20px;
  }
  .home-header-body {
    font-size: 64px;
    padding: 0;
    margin-bottom: 32px;
    height: 64px;
    align-items: center;
  }
  .home-header-progress {
    padding: 0;
    margin-bottom: 12px;
  }
  .home-header-target-time {
    font-size: 20px;
    padding: 0;
  }
</style>