  <div id="app">
    <button @click="check"></button>
  </div>

<script>
import {Bar} from 'vue-chartjs';

export default {
  extends: Bar,
  mounted () {
    // this.$store.dispatch('getData')
    this.renderChart(this.storeMovies)
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
    }
  },
  methods: {
    check: function() {
      console.log(this.storeMovies)
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