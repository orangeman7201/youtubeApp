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
  beforeCreate() {
    axios
      .get('/session_check')
      .then(() => {
        this.$store.dispatch('getSelf')
        this.$store.state.today = new Date();
        this.$router.push({name: 'HomeIndexPage' });
      })
      .catch(() => {
        this.$router.push({name: 'LoginForm' })
      })
  },
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


