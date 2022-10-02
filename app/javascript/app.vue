<template>
  <v-app class="main-font">
    <AddMovieButton />
    <GlobalHeader v-if="!isTopPage"/>
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
    isTopPage: function() {
      return this.$route.path === '/'
    },
  }
}
</script>

<style scoped>
  .main-font {
    font-family: 'Noto Sans';
  } 
</style>


