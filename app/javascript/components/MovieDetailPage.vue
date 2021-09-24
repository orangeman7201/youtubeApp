<template>
  <v-app>
    <v-container>
      <v-layout>
        <v-flex md>
          <div id="app">
            <table>
              <tr>
                <th>title</th>
                <th>duration</th>
                <th>thumbnail</th>
              </tr>
              <tr v-for="movie in movies" :key="movie.id">
                <td>{{movie.title}}</td>
                <td>
                  <span v-if="movie.duration >= 3600">
                    {{Math.floor(movie.duration/3600)}}時間
                  </span>
                  <span v-if="movie.duration >= 60">
                    {{Math.floor(movie.duration/60%60)}}分
                  </span>{{movie.duration%60}}秒
                </td>
                <td>
                  <img :src="movie.thumbnail">
                </td>
              </tr>
            </table>
          </div>
        </v-flex>
      </v-layout>
    </v-container>
  </v-app>
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
  text-align: center;
}
</style>