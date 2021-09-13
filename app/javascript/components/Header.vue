<template>
  <v-app>
    <v-app-bar app color="green accent-3" flat>
      <v-container class="py-0 fill-height">
        <v-avatar class="mr-10" color="black" size="32"></v-avatar>
        <v-btn
          v-for="link in links"
          :key="link"
          color=""
          class="white--text"
        >
          {{ link }}
        </v-btn>
      </v-container>
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
