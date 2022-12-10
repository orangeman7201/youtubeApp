<template>
  <v-app v-if="loaded" id="app">
    <div class="pa-5 home-backgound">
      <v-card class="mt-6 mx-7 mb-8 pt-6 px-8 pb-3" flat>
        <v-card-title class="d-flex justify-center home-header-title">今日の総再生時間</v-card-title>
        <v-card-text class='d-flex justify-center home-header-body'>
          {{ formattedTotalDuration }}<span class="text-minute">分</span>
        </v-card-text>
        <v-card-text v-if="storeUser" class='d-flex justify-end home-header-target-time'>目標 <span class="home-header-target-time-text">{{ storeUser.limit / 60 }}</span>分</v-card-text>
        <div class='home-header-progress'>
          <ProgressBar :total-duration="totalDuration" :limit="storeUser.limit"/>
        </div>
        <div class="d-flex justify-center">
          <div v-if="storeUser.limit > totalDuration" class="lessThanLimit">
            達成中
          </div>
          <div v-else class="overLimit">
            <ExcessText />{{ overLimitTime }}分
          </div>
        </div>
      </v-card>
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
import Chart from '../Chart.js';
import ProgressBar from '../modules/ProgressBar.vue';
import ExcessText from '../modules/ExcessText.vue';
import CardWithHeader from '../modules/CardWithHeader.vue';

export default {
  components: { DurationTable, Chart, ProgressBar, ExcessText, CardWithHeader },
  mounted () {
    this.getWeeklyDurationSum();
    this.$store.dispatch('getTotalDuration');
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
    }  
  },
  computed: {
    chartheight: function() {
      return window.innerHeight / 4
    },
    chartWidth: function() {
      return window.innerWidth * 0.8
    },
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
    overLimitTime: function() {
      return  Math.floor(( this.totalDuration - this.storeUser.limit ) / 60)
    }
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
      .get('/weekly_duration_sum')
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
  .lessThanLimit {
    font-size: 15px;
    color: #1995AD;
    text-align: center;
  }
  .overLimit {
    color: #EB440C;
    font-size: 9px;
  }
  .excessText {
    border: 0.8px solid #EB440C;
    margin-right: 4px;
    padding: 0 7px;
  }
  .chart {
    height: 148px;
  }
</style>