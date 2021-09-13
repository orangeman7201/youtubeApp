<template>
  <v-app>
    <v-app-bar color="green accent-3" app>
      <v-btn icon  color="#EEEEEE" :to="'/'"></v-btn>
      <v-toolbar-title @click="$router.push('/')">Home</v-toolbar-title>
      <v-spacer></v-spacer>
       <v-btn @click="$router.push('/movies/new')">新規作成</v-btn>
    </v-app-bar>
  </v-app>
</template>

<script>
  export default {
    data: () => ({
      links: [
        'Dashboard',
        'Messages',
        'Profile',
        'Updates',
      ],
    }),
  }
</script>
