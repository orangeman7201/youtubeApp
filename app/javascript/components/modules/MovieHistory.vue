<template>
  <v-app>
    <v-row class="pa-5 grey lighten-3 max-height">
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
      <div v-if="isMounted">
        <v-progress-circular v-if="isLoading" indeterminate />
        <div v-else-if="!isMoreData" v-intersect="onIntersect"></div>
      </div>
    </v-row>
  </v-app>
</template>

<script>
export default {
  data () {
    return {
      isLoading: false,
    }
  },
  props: ['movies', 'isMoreData', 'isMounted'],
  methods: {
    onIntersect: function(entries, observer, isIntersecting) {
      if (!isIntersecting) {
        return;
      } else {
        this.isLoading = true;
        this.$emit('get-movies');
        this.isLoading = false;
      }
    }
  }
}
</script>

<style scoped>
.flex-grow {
  flex-grow: 1;
}
.max-height {
  height: 100%;
}
</style>
