<template>
  <v-app>
    <GlobalHeader v-if="isHeaderShow"/>
    <v-main>
      <router-view></router-view>
    </v-main>
  </v-app>  
</template>

<script>
import GlobalHeader from './components/modules/GlobalHeader.vue';

export default {
  components: { GlobalHeader },
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

<style>
#app {
  font-family: Inter, 'Noto Sans JP';
}

.loading-animation{
  position: absolute;
  background-color: gray;
  width: 100%;
  z-index: 999;
  opacity: 0.5;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
}

.error-message {
  font-size: 12px;
  color: #EB440C;
}
</style>


