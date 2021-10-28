<template>
  <v-container id="typography-view" fluid tag="section" class="grey lighten-3">
      <v-card class="ma-5 px-5 py-10">
        <v-row v-if="durationArray === []">
          <v-col>
            <p class="text-h4">再生した動画はありません</p>
          </v-col>
        </v-row>
        <v-row v-else >
          <v-col cols="12" md10>
            <line-chart :chart-data="dataCollection" :height="height" :width="width"/>
          </v-col>
          <v-col cols="12" md2>
            <v-radio-group v-model="number" column >
              <v-radio value="6" label="1週間分を表示" class="mb-5"></v-radio>
              <v-radio value="13" label="2週間分を表示" class="mb-5"></v-radio>
              <v-radio value="29" label="4週間分を表示" class="mb-5"></v-radio>
            </v-radio-group>
          </v-col>
        </v-row>
      </v-card>
  </v-container>

</template>

<script>
import LineChart from "./LineChart.vue";
import axios from 'axios';


export default {
  components: {
    LineChart
  },

  data: function () {
    return {
      loaded: false,
      number: 6,
      height: window.innerHeight *1 /4 ,
      width: window.innerWidth *2 / 3,
      durationCheck: '',
    }
  },
  computed: {
    movies: function() {
      return this.$store.state.movies
    },
    dateArray: function() {
      let dateArray = [];
      for(let num = this.number; num >= 0; num--) {
        const date = new Date;
        date.setDate(date.getDate() - num)
        let year = String(date.getFullYear());
        let month = String(date.getMonth() + 1);
        if(month.length == 1) {
          month = 0 + month;
        }
        let day = String(date.getDate());
        if(day.length == 1) {
          day = 0 + day;
        }
        const fitToday = year + '-' +  month + '-' + day
        dateArray.push(fitToday);
      }
      return dateArray
    },
    durationArray: function() {
      const durationArray = [];
      const stepArray = []
      this.dateArray.forEach(date => {
        const stepObj = {x: date, y: 0}
        stepArray.push(stepObj)
      })
      stepArray.forEach(stepObj => {
        this.movies.forEach(movie => {
          if(stepObj.x === movie.date.slice(0, 10)) {
            stepObj.y += movie.duration
          }
        })
        durationArray.push(stepObj.y)
      })
      return durationArray
    },
    dataCollection: function() {
      const chartdata = {
        labels: this.dateArray,
        datasets: [
          {
            backgroundColor: 'rgba(54, 162, 235, 0.5)',
            borderColor: 'rgb(54, 162, 235)',
            borderWidth: 1,
            data: this.durationArray
          }
        ],
      }
      return chartdata
    },
  },
}
 
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>