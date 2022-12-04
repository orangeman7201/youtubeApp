<template>
  <v-app>
    <AddMovieButton v-if="isHeaderShow"/>
    <GlobalHeader v-if="isHeaderShow"/>
    <v-main>
      <router-view></router-view>
    </v-main>
    <!-- <GlobalFoooter v-if="isHeaderShow"/> -->
  </v-app>  
</template>

<script>
import AddMovieButton from './components/modules/AddMovieButton.vue';
import GlobalHeader from './components/GlobalHeader.vue';
import GlobalFoooter from './components/GlobalFooter.vue';

export default {
  components: { AddMovieButton, GlobalHeader, GlobalFoooter },
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


