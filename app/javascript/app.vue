<template>
  <v-app class="main-font">
    <AddMovieButton v-if="isHeaderShow"/>
    <GlobalHeader v-if="isHeaderShow"/>
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>  
</template>

<script>
import AddMovieButton from './components/modules/AddMovieButton.vue';
import GlobalHeader from './components/GlobalHeader.vue';

export default {
  components: { AddMovieButton, GlobalHeader },
  data () {
    return {
      errors: '',
    }
  },
  computed: {
    isHeaderShow: function() {
      return !(this.$route.path === '/login' || this.$route.path === '/')
    },
  }
}
</script>

<style scoped>
  .main-font {
    font-family: 'Noto Sans';
  } 
</style>


