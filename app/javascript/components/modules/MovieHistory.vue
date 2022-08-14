<template>
  <v-app>
    <v-row class="pa-5 grey lighten-3">
      <v-row v-if="movies.length === 0">
        <v-col class="pt-2 pb-1 d-flex justify-center">
          <p class="text-h4 mb-10">動画を視聴していません</p>
        </v-col>
      </v-row>
      <v-card v-for="movie in movies" :key="movie.id" @click="router(movie.id)" :class="[$vuetify.breakpoint.smAndDown ? 'pa-5 flex-grow' : 'ma-10 px-15 pb-10 pt-7']" outlined tile>
        <v-row align="center" justify="center"> 
          <v-col cols="5" md="4" :class="[$vuetify.breakpoint.smAndDown ? 'pa-0' : '']">
            <v-img :src="movie.thumbnail" max-width="150px"  :class="[$vuetify.breakpoint.smAndDown ? 'ml-3 my-3' : '']" />
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
  </v-app>
</template>

<script>
export default {
  props: ['movies'],
}
</script>
