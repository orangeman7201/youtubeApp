<template>
  <v-app id="app">
    <v-container id="typography-view" fluid tag="section" class="grey lighten-3">

      <v-row align="center" justify="center" class="my-5 pa-5">
        <v-card class="pa-5">
          <p class="text-h5">合計視聴時間<v-divider></v-divider></p>
          
          <div class="text-h3">
            <span v-if="totalDuration >= 3600">
              {{Math.floor(totalDuration/3600)}}時間
            </span>
            <span v-if="totalDuration >= 60">
              {{Math.floor(totalDuration/60%60)}}分
            </span>{{totalDuration%60}}秒
          </div>
        </v-card>
      </v-row>
      
      <v-card class="mx-10 pa-5">
        <v-row align="center" justify="end">
          <v-col cols="1" >
            <v-btn fab class="green accent-3 white--text" @click="routerNew">
              <v-icon class="text-h4">mdi-plus</v-icon>
            </v-btn>
          </v-col>
        </v-row>

        <v-card v-for="movie in storeMovies" :key="movie.id" @click="router(movie.id)" width="93%" class="ma-10 px-13 pb-9 pt-5" elevation="7">
          <v-row>
            <v-col class="pa-1 d-flex justify-end">
              <span class="text-body-2">1時間前</span>
            </v-col>
          </v-row>

          <v-row> 
            <v-col cols="4" class="d-flex justify-center">
              <v-img :src="movie.thumbnail" :aspect-ratio="4/3" max-width="400px">
                <div bottom class="mt-1 mr-2 black white--text text-right">
                  <span v-if="movie.duration >= 3600">
                    {{Math.floor(movie.duration/3600)}}時間
                  </span>
                  <span v-if="movie.duration >= 60">
                    {{Math.floor(movie.duration/60%60)}}分
                  </span>{{movie.duration%60}}秒
                </div>
              </v-img>
            </v-col>

            <v-col cols="8">
              <div class="ma-2">
                <h4 class="text-h5">{{movie.title}}</h4>
              </div>
                <v-divider></v-divider>
              <div class="ma-3">
                <p>{{movie.comment}}</p>
              </div>
            </v-col>

          </v-row>
        </v-card>

      </v-card>
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
    },
  },
  methods: {
    check: function() {
      console.log(this.storeMovies)
    },
    router: function(index) {
       this.$router.push(`movies/${index}`)
    },
    routerNew: function() {
       this.$router.push('movies/new')
    }
  }
  
}
</script>
