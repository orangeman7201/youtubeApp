<template>
  <v-app>
    <Navbar v-if="userState === 'ok'"></Navbar>
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
    this.$store.dispatch('requireLogin');
  },
  data () {
    return {
      errors: '',
    }
  },
  computed: {
    userState: function() {
      return this.$store.state.user
    },
  },
}
</script>


