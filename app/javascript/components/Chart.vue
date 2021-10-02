<template>
  <v-container>
    <line-chart/>
    <v-btn></v-btn>
  </v-container>

</template>

<script>
import LineChart from "./LineChart.vue";


export default {
  components: {
    LineChart
  },
  data: function () {
    return {
      loaded: false,
      duration: {},
      movies: [],
      datacollection: []
    }
  },
  methods: {
    getData: async function() {
      await axios
        .get('/movies.json')
        .then(response => {
          response.data.forEach(element => {
            this.movies.push(element)
          })
        })
        .catch(error => {
          router.push({name: 'LoginForm' })
          console.log(error)
      })
    },
    check: function() {
      console.log(this.chartData)
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