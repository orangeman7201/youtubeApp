<template>
  <div id="app">
    <table>
        <tr>
          <th>id</th>
          <th>title</th>
          <th>duration</th>
        </tr>
        <tr v-for="movie in movies" :key="movie.id">
          <router-link :to="{ name: 'MovieDetailPage', params: { id: movie.id } }">{{ movie.id }}</router-link>
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
      .get('/movies.json')
      .then(response => (this.movies = response.data))
  }
}
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>