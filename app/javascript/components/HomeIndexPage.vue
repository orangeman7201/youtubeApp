<template>
  <v-app id="app">
    <v-container id="typography-view" fluid tag="section" class="grey lighten-3">

      <v-row align="center" justify="center" class="display-4 my-5 pa-5">
        <v-card class="pa-5">
          <p class="display-1 mb-7">合計視聴時間</p>
          <span v-if="totalDuration >= 3600">
            {{Math.floor(totalDuration/3600)}}時間
          </span>
          <span v-if="totalDuration >= 60">
            {{Math.floor(totalDuration/60%60)}}分
          </span>{{totalDuration%60}}秒
        </v-card>
      </v-row>
      
      <v-card class="mx-10 pa-5">
        <v-row align="center" justify="end">
          <v-col cols="1" >
            <v-btn fab class="green accent-3 white--text">
              <v-icon class="display-3">mdi-plus</v-icon>
            </v-btn>
              <span class="display-2">追加</span>
          </v-col>
        </v-row>
        <!-- <router-link to="/movies/new" >新しい動画を追加</router-link> -->

        <v-card v-for="movie in storeMovies" :key="movie.id" width="97%" class="ma-10 pa-15" elevation="7">
          <v-row> 

            <v-col cols="4" class="d-flex justify-center">
              <v-img :src="movie.thumbnail" :aspect-ratio="4/3">
                <v-row align="end" justify="end">
                  <v-col cols="3" class="black white--text headline d-flex justify-center">
                    <span v-if="movie.duration >= 3600">
                      {{Math.floor(movie.duration/3600)}}時間
                    </span>
                    <span v-if="movie.duration >= 60">
                      {{Math.floor(movie.duration/60%60)}}分
                    </span>{{movie.duration%60}}秒
                  </v-col>
                </v-row>
              </v-img>
            </v-col>

            <v-col cols="8" class="display-2">
              <div class="ma-2">
                <h4>{{movie.title}}
                  <span class="headline" >1時間前</span>
                </h4>
              </div>
                <v-divider></v-divider>
              <div class="ma-3">
                <p>{{movie.comment}}</p>
              </div>
            </v-col>

          </v-row>
        </v-card>

      </v-card>
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
