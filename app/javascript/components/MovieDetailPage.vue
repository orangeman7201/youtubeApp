<template>
  <!-- <v-app>
    <v-container>
      <v-layout>
        <v-flex md> -->
          <div id="app">
            <div v-if="this.error !== ''">{{this.error}}</div>
            <table>
              <tr>
                <th>タイトル</th>
                <th>サムネ</th>
                <th>再生時間</th>
                <th>視聴日時</th>
                <th>コメント</th>
              </tr>
              <tr>
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
                <td>{{movie.created_at}}</td>
                <td><input type="text" v-model="movie.comment"></td>
              </tr>
              <button @click="submitData">保存</button>
              <button @click="deleteData">削除</button>
            </table>
          </div>
        <!-- </v-flex>
      </v-layout>
    </v-container>
  </v-app> -->
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      movie: {},
      error: ""
    }
  },
  mounted () {
    axios
    .get(`/movies/${this.$route.params.id}.json`)
    .then(response => (this.movie = response.data))
  },
  methods: {
    submitData: function() {
      if(confirm('保存しますか？')){
        axios
          .patch(`/movies/${this.$route.params.id}.json`, this.movie)
          .then(response => {
            console.log(response);
            this.$router.push({name: 'HomeIndexPage' })
          })
          .catch(error => {
            console.log(error)
            this.error = error
          })
      }
    },
    deleteData: function() {
      if(confirm('削除しますか？')){
        axios
          .delete(`/movies/${this.$route.params.id}.json`, this.movie)
          .then(response => {
            console.log(response);
            this.$router.push({name: 'HomeIndexPage' })
          })
          .catch(error => {
            console.log(error)
            this.error = error
          })
      }
    }
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>