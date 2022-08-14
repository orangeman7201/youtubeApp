<template>
  <v-app class="main-font">
    <Navbar v-if="!isTopPage"/>
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>  
</template>

<script>
import Navbar from './components/Navbar';

export default {
  components: {Navbar},
  data () {
    return {
      errors: '',
    }
  },
  beforeCreate() {
    this.$store.dispatch('requireLogin');
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


