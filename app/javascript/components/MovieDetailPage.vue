<template>
  <div id="app">
    <table>
      <tr>
        <th>id</th>
        <th>title</th>
        <th>duration</th>
      </tr>
      <tr v-for="movie in movies" :key="movie.id">
        <td>{{movie.id}}</td>
        <td>{{movie.title}}</td>
        <td>{{movie.duration}}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      movies: []
    }
  },
  mounted () {
      axios
      .get(`/movies/${this.$route.params.id}.json`)
      .then(response => (this.movies.push(response.data)))
    },
}
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>