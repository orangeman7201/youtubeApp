<template>
  <v-app>
    <v-app-bar color="green accent-3" dark app>
      <v-btn icon  color="#EEEEEE" :to="'/'"></v-btn>
      <v-toolbar-title @click="$router.push('/')">Home</v-toolbar-title>
      <v-spacer></v-spacer>
       <v-btn @click="$router.push('/movies/new')">新規作成</v-btn>
    </v-app-bar>
  <v-main>
    <router-view></router-view>
  </v-main>
  </v-app>  
</template>

<script>
import Header from './components/Header.vue'

export default {
  components: {
    Header,
  }
}
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>
