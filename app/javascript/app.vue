<template>
  <v-app>
    <AddMovieButton v-if="isHeaderShow"/>
    <GlobalHeader v-if="isHeaderShow"/>
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>  
</template>

<script>
import AddMovieButton from './components/modules/AddMovieButton.vue';
import GlobalHeader from './components/modules/GlobalHeader.vue';

export default {
  components: { AddMovieButton, GlobalHeader },
  data () {
    return {
      errors: '',
    }
  },
  computed: {
    isHeaderShow: function() {
      return !(this.$route.path === '/login' || this.$route.path === '/' || this.$route.path.includes('/signup'))
    },
  }
}
</script>

<style scoped>
  #app {
    font-family: Inter, 'Noto Sans JP';
  }
</style>


