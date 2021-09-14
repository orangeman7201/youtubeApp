<template>
  <div id="app">
    <button @click="check">Check!</button>
  </div>
</template>

<script>
export default {
  mounted () {
    this.$store.dispatch('getData')
  },
  computed: {
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
    totalDuration: function() {
      let sum = 0;
      for(let id = 0; id < this.storeMovies.length; id++) {
        sum += this.storeMovies[id].duration
      }
      return sum;
    },
    storeMovies: function() {
      return this.$store.getters.storeMovies;
    }
  },
  methods: {
    check: function() {
      const result = this.storeMovies.filter(function(value) {
          return value.date === this.dateArray
      });
      console.log(result);
    },
    Today: function() {
      if(fitToday == this.storeMovies[9].date.slice(0, 10)) {
        console.log('成功')
      }else{
        console.log('失敗')
      }
    },
  }
  
}
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>