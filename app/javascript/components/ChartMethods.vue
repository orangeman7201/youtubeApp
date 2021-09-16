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
    totalDuration: function() {
      let sum = 0;
      for(let id = 0; id < this.storeMovies.length; id++) {
        sum += this.storeMovies[id].duration
      }
      return sum;
    },
    storeMovies: function() {
      return this.$store.getters.storeMovies;
    },
    
  },
  methods: {
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