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
          <td>
            <span v-if="movie.duration >= 3600">
              {{Math.floor(movie.duration/3600)}}時間
            </span>
            <span v-if="movie.duration >= 60">
              {{Math.floor(movie.duration/60%60)}}分
            </span>{{movie.duration%60}}秒
          </td>
        </tr>
    </table>
    <router-link to="/movies/new" >新しい動画を追加</router-link>
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