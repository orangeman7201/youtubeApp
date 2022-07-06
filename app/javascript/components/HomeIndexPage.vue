<template>
  <v-app v-if="userState === 'ok'" id="app">
    <v-row class="pa-5 grey lighten-3">
      <v-row class="pa-5">
        <v-card class="py-9 px-5" width="100%" height="274px">
          <v-card-title class="d-flex justify-center home-header-title">今日の総再生時間</v-card-title>
          <v-card-text class='d-flex justify-center home-header-body' :class="overHourClass">
            {{ formattedTotalDuration}}
          </v-card-text>
          <div class='d-flex justify-center home-header-progress'>
            <v-progress-linear></v-progress-linear>
          </div>
          <!-- 目標はuser.timeみたいな感じで取得する -->
          <v-card-text class='d-flex justify-center home-header-target-time'>目標 60分/日</v-card-text>
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
    this.getWeeklyDurationSum();
    this.$store.dispatch('getTotalDuration');
  },
  data: function () {
    return {
      movies: [],
    }  
  },
  watch: {
    dateStatus: function() {
      this.getMovie();
      this.$store.dispatch('getTotalDuration');
    },
  },
  computed: {
    userState: function() {
      return this.$store.state.user;
    },
    totalDuration: function() {
      return this.$store.getters.totalDuration
    },
    dateStatus: function() {
      return this.$store.getters.dateStatus
    },
    overHourClass: function() {
      const hour = Math.floor(this.totalDuration/3600)
      if (hour > 0) {
        return 'font-size-small'
      }
      return 'font-size-big'
    },
    formattedTotalDuration: function() {
      const hour = Math.floor(this.totalDuration/3600)
      const minute = Math.floor(this.totalDuration/60%60)
      const second = this.totalDuration%60
      if (hour > 0) {
        return `${hour}時間${minute}分${second}秒`
      }
      if (minute > 0) {
         return `${minute}分${second}秒`
      }
      return `${second}秒`
    },
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
      .get('/movies', {
        params: {
          dateStatus: this.dateStatus
        }
      })
      .then(response => {
        console.log(response.data)
        this.movies = response.data;
        this.$store.dispatch('updateStatus');
      })
      .catch(error => {
        // this.$router.push({name: 'LoginForm' })
        console.log(error)
      })
    },
    getWeeklyDurationSum() {
      axios
      .get('/weekly_duration_sum', {
        params: {
          dateStatus: this.dateStatus
        }
      })
      .then(response => {
        console.log(111, response.data);
      })
      .catch(error => {
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
  .font-size-small {
    font-size:min(9.5vw, 50px);
  }
  .font-size-big {
    font-size:min(14vw, 50px);
  }
  .home-header-title {
    font-size: 20px;
    padding: 0;
    margin-bottom: 20px;
  }
  .home-header-body {
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