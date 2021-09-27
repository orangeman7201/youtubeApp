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
          <th>タイトル</th>
          <th></th>
          <th>再生時間</th>
          <th>視聴日</th>
          <th>コメント</th>
        </tr>
        <tr v-for="movie in storeMovies" :key="movie.id">
          <td><router-link :to="{ name: 'MovieDetailPage', params: { id: movie.id } }">{{movie.title}}</router-link></td>
          <td>
            <router-link :to="{ name: 'MovieDetailPage', params: { id: movie.id } }">
             <img :src="movie.thumbnail">
            </router-link>
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
          <td>{{movie.comment}}</td>
        </tr>
    </table>
    <router-link to="/movies/new" >新しい動画を追加</router-link>
    <button @click="check"></button>
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