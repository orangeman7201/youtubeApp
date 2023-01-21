<template>
  <v-app v-if="loaded" id="app">
    <div class="pa-5 home-backgound">
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

export default {
  components: { DurationTable, Chart, CardWithHeader },
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
  .home-backgound {
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
</style>