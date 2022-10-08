<template>
  <v-app v-if="loaded" id="app">
    <div class="pa-5 home-backgound">
      <v-card class="mt-6 mx-7 mb-8 pt-6 px-8 pb-3" flat>
        <v-card-title class="d-flex justify-center home-header-title">今日の総再生時間</v-card-title>
        <v-card-text class='d-flex justify-center home-header-body'>
          {{ formattedTotalDuration}}<span class="text-minute">分</span>
        </v-card-text>
        <v-card-text v-if="storeUser" class='d-flex justify-end home-header-target-time'>目標 <span class="home-header-target-time-text">{{ storeUser.limit / 60 }}</span>分</v-card-text>
        <div class='home-header-progress'>
          <ProgressBar :total-duration="totalDuration" :limit="storeUser.limit"/>
        </div>
      </v-card>
      <v-row class="pa-5">
        <v-card v-if="loaded" class="py-9 px-5" width="100%">
          <h3 class="d-flex justify-center">週間サマリー</h3>
          <Chart class="pt-5 pb-7" :chartData="chartItems" :options="chartOptions" :height="height" :width="width" />
          <DurationTable :items="weeklyDurationSum" />
        </v-card>
      </v-row>
    </div>
  </v-app>
</template>

<script>
import axios from 'axios';
import moment from 'moment';
import DurationTable from './DurationTable.vue';
import Chart from './Chart.js'
import ProgressBar from './modules/ProgressBar.vue'

export default {
  components: { DurationTable, Chart, ProgressBar },
  mounted () {
    this.getWeeklyDurationSum();
    this.$store.dispatch('getTotalDuration');
  },
  data: function () {
    return {
      weeklyDurationSum: {},
      loaded: false,
      chartOptions: {
        maintainAspectRatio: false,
        legend: {
          display: false
        },
        responsive: false,
        scales: {
          xAxes: [{
            display: true,
            gridLines: {
              display:false
            }
          }],
          yAxes: [{
            display: true,
            position: 'right',
            ticks: {
              maxTicksLimit: 3,
            }
          }]
        },
      },
    }  
  },
  watch: {
    dateStatus: function() {
      this.getMovie();
      this.$store.dispatch('getTotalDuration');
    },
  },
  computed: {
    height: function() {
      return window.innerHeight / 4
    },
    width: function() {
      return window.innerWidth * 0.85
    },
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    totalDuration: function() {
      return this.$store.getters.totalDuration
    },
    dateStatus: function() {
      return this.$store.getters.dateStatus
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
      .get('/weekly_duration_sum', {
        params: {
          dateStatus: this.dateStatus
        }
      })
      .then(response => {
        this.weeklyDurationSum = response.data
        this.loaded = true
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
  .home-header-title {
    font-size: 15px;
    line-height: 18px;
    color: #333333;
    padding: 0;
    margin-bottom: 4px;
  }
  .home-header-body {
    padding: 0 0 0 20px;
    font-size: 45px;
    line-height: 54px;
    max-height: 54px;
    color: #333333;
    align-items: center;
    vertical-align: middle;
  }
  .home-header-progress {
    padding: 0;
    margin-bottom: 12px;
  }
  .home-header-target-time {
    font-size: 9px;
    padding: 0;
    color: #1995AD !important;
    align-items: flex-end;
  }
  .home-header-target-time-text {
    font-size: 15px;
    margin: 0 3px;
    padding-bottom: 1px;
  }
  .home-backgound {
    display: block;
    background-color: #F1F1F1;
  } 
  .text-minute {
    font-size: 15px;
    margin-left: 4px;
    padding-top: 14px;
  }
</style>