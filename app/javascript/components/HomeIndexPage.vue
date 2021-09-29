<template>
  <v-app id="app">
    <v-container id="typography-view" fluid tag="section">

      <v-row align="center" justify="center" class="display-4 my-5 pa-5">
        <v-card class="pa-5">
          <p class="display-2 mb-1">合計視聴時間</p>
          <span v-if="totalDuration >= 3600">
            {{Math.floor(totalDuration/3600)}}時間
          </span>
          <span v-if="totalDuration >= 60">
            {{Math.floor(totalDuration/60%60)}}分
          </span>{{totalDuration%60}}秒
        </v-card>
      </v-row>

      <v-row v-for="movie in storeMovies" :key="movie.id"  class="my-5">
        <v-card class="mx-auto">
          <v-col cols="4">
            <router-link :to="{ name: 'MovieDetailPage', params: { id: movie.id } }">
            <img :src="movie.thumbnail" width="480" height="360">
            <p class="headline">
              <span v-if="movie.duration >= 3600">
                {{Math.floor(movie.duration/3600)}}時間
              </span>
              <span v-if="movie.duration >= 60">
                {{Math.floor(movie.duration/60%60)}}分
              </span>{{movie.duration%60}}秒
            </p>
            </router-link>
          </v-col>
          <v-col cols="8" class="display-2">
              <router-link :to="{ name: 'MovieDetailPage', params: { id: movie.id } }">{{movie.title}}</router-link>
              <span class="headline">1時間前</span>
              <v-devider></v-devider>
              <!-- <span class="headline">{{movie.created_at}}</span> -->
              <p>{{movie.comment}}</p>
          </v-col>
        </v-card>
      </v-row>
    <router-link to="/movies/new" >新しい動画を追加</router-link>
    <button @click="check"></button>

    </v-container>
  </v-app>
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
