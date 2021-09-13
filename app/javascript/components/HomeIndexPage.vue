<template>
  <div id="app">
    <div>
      <p>合計視聴時間</p>
      <span v-if="totalDuration >= 3600">
        {{Math.floor(totalDuration/3600)}}時間
      </span>
      <span v-if="totalDuration >= 60">
        {{Math.floor(totalDuration/60%60)}}分
      </span>{{totalDuration%60}}秒
    </div>
    <table>
        <tr>
          <th>id</th>
          <th>title</th>
          <th>thumbnail</th>
          <th>duration</th>
        </tr>
        <tr v-for="movie in movies" :key="movie.id">
          <router-link :to="{ name: 'MovieDetailPage', params: { id: movie.id } }">{{ movie.id }}</router-link>
          <td>{{movie.title}}</td>
          <td>
            <img :src="movie.thumbnail">
          </td>
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
    <button @click="check"></button>
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
  },
  computed: {
    totalDuration: function() {
      let sum = 0;
      for(let id = 0; id < this.movies.length; id++) {
        sum += this.movies[id].duration
      }
      return sum;
    }
  },
  methods: {
    check: function() {
      console.log(this.movies)
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