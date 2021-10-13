<template>
  <v-app>
    <v-container>
      Aboutページです
    </v-container>
  </v-app>  
</template>

<script>

export default {
 mounted() {
   if(this.$store.state.user === 'ok') {
     this.$router.push({name: 'HomeIndexPage' })
   }
  },
}
</script>
