<template>
  <v-app v-if="userState === 'ok'" id="app">
    <v-row class="grey lighten-3">

      <v-row align="center" justify="center" class="my-5 pa-5">
        <v-card class="pa-5">

          <v-col cols="12" class="mb-5">
            <v-btn @click="oneDayAgo" fab dark max-height="40px" max-width="40px" class="mr-5" color="green accent-2">
              <v-icon class="text-h4">mdi-menu-left</v-icon>
            </v-btn>
            <span class="text-h5">{{ this.$store.getters.storeToday | moment("M月D日") }}</span>
            <v-btn @click="oneDayAfter" fab dark max-height="40px" max-width="40px" class="ml-5" color="green accent-2">
              <v-icon class="text-h4">mdi-menu-right</v-icon>
            </v-btn>
          </v-col>

          <p :class="[$vuetify.breakpoint.smAndDown ? 'text-h6' : 'text-h5']">合計視聴時間<v-divider></v-divider></p>
          
          <v-col cols="12" :class="[$vuetify.breakpoint.smAndDown ? 'text-h4 d-flex justify-center' : 'text-h3']">
            <span v-if="totalDuration >= 3600">
              {{Math.floor(totalDuration/3600)}}時間
            </span>
            <span v-if="totalDuration >= 60">
              {{Math.floor(totalDuration/60%60)}}分
            </span>{{totalDuration%60}}秒
          </v-col>
        </v-card>
      </v-row>
      
      <v-row>
        <v-row class="hidden-sm-and-down" align="center" justify="end">
          <v-col cols="1" >
            <v-btn fab class="green accent-3 white--text" >
              <v-icon :class="[$vuetify.breakpoint.smAndDown ? 'text-h5' : 'text-h4']">mdi-plus</v-icon>
            </v-btn>
          </v-col>
        </v-row>

        <v-row v-if="this.todayMovies.length === 0">
          <v-col class="pt-2 pb-1 d-flex justify-center">
            <p class="text-h4 mb-10">動画を視聴していません</p>
          </v-col>
        </v-row>

        <v-card v-for="movie in todayMovies" :key="movie.id" @click="router(movie.id)" :class="[$vuetify.breakpoint.smAndDown ? 'pa-5' : 'ma-10 px-15 pb-10 pt-7']" outlined tile>

          <v-row align="center" justify="center"> 
            <v-col cols="5" md="4" :class="[$vuetify.breakpoint.smAndDown ? 'pa-0' : '']">
              <v-img :src="movie.thumbnail" max-width="150px"  :class="[$vuetify.breakpoint.smAndDown ? 'ml-3 my-3' : '']">
                <div bottom class="black white--text text-right hidden-sm-and-down" :class="[$vuetify.breakpoint.smAndDown ? 'text-caption' : 'mt-1 mr-2']">
                  <span v-if="movie.duration >= 3600">
                    {{Math.floor(movie.duration/3600)}}時間
                  </span>
                  <span v-if="movie.duration >= 60">
                    {{Math.floor(movie.duration/60%60)}}分
                  </span>{{movie.duration%60}}秒
                </div>
              </v-img>
            </v-col>

            <v-col cols="7" md="8" :class="[$vuetify.breakpoint.smAndDown ? 'pa-0' : '']">
              <div class="ma-2">
                <body :class="[$vuetify.breakpoint.smAndDown ? 'caption' : 'text-h5']">{{movie.title}}</body>
              </div>
                <v-divider></v-divider>
              <div class="ma-3" :class="[$vuetify.breakpoint.smAndDown ? 'body-2' : 'text-h5']">
                <p>{{movie.comment}}</p>
              </div>
            </v-col>

          </v-row>
        </v-card>

      </v-row>
    </v-row>
  </v-app>
</template>

<script>

export default {
  mounted () {
    this.$store.dispatch('getData')
  },
  computed: {
    userState: function() {
      return this.$store.state.user 
    },
    totalDuration: function() {
      let sum = 0;
      for(let id = 0; id < this.todayMovies.length; id++) {
        sum += this.todayMovies[id].duration
      }
        return sum;
    },  
    storeMovies: function() {
      return this.$store.getters.storeMovies;
    },
    todayMovies: function() {
      const todayMovies = this.$store.getters.storeMovies.filter(element => {
        const movieDate = String(new Date(element.date)).slice(0, 15)
        const today = String(this.$store.getters.storeToday).slice(0, 15)
        if(movieDate === today) {
          return element
        }
      })
      return todayMovies
    }
  },
  methods: {
    router: function(index) {
       this.$router.push(`movies/${index}`)
    },
    routerNew: function() {
       this.$router.push('movies/new')
    },
    oneDayAgo: function() {
      this.$store.dispatch('oneDayAgo');
    },
    oneDayAfter: function() {
      this.$store.dispatch('oneDayAfter');
    },
  }
  
}
</script>
