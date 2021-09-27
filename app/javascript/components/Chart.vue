<template>
  <line-chart v-if="loaded" :dateArray="dateArray" :durationArray="durationArray"/>
</template>

<script>
import LineChart from "./LineChart.vue";

export default {
  components: {
    LineChart
  },
  async mounted () {
    this.$store.commit('getData')
    await this.fillData();
    this.loaded = true
  },
  data: function () {
    return {
      loaded: false,
      duration: {},
    }
  },
  computed: {
    storeMovies: function() {
      return this.$store.getters.storeMovies;
    },
    dateArray: function() {
      let dateArray = [];
      for(let num = 89; num >= 0; num--) {
        const date = new Date;
        date.setDate(date.getDate() - num)
        let year = String(date.getFullYear());
        let month = String(date.getMonth() + 1);
        if(month.length == 1) {
          month = 0 + month
        };
        let day = String(date.getDate());
        if(day.length == 1) {
          day = 0 + day
        };
        const fitToday = year + '-' +  month + '-' + day
        dateArray.push(fitToday);
      }
      return dateArray
    },
    durationArray: function() {
      let filteredStoreMovies = [];
      this.storeMovies.forEach(element => {
        const obj = {};
        if(element.date != null) {
          obj.date = element.date.slice(0, 10)
        }else{
          obj.date = element.date
        }
        obj.duration = element.duration
        filteredStoreMovies.push(obj);
      })
      let filteredDateArray = [];
      this.dateArray.forEach(element => {
        let obj = {};
        obj.date = element;
        obj.duration = 0;
        filteredDateArray.push(obj)
      })
      filteredStoreMovies.forEach(store => {
        filteredDateArray.forEach(date => {
          if(date.date == store.date) {
            date.duration += store.duration
          }
        })
      })
      let durationArray = [];
      filteredDateArray.forEach(date => {
        durationArray.push(date.duration)
      })
      return durationArray;
    },
  },
  methods: {
    fillData: function() {
      return new Promise(resolve => {
        setTimeout(() => {
            resolve('a');
        }, 2000);
    })
    }
  }
}
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>