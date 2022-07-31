<template>
  <v-card class="px-5 py-5" width="100%" flat :color="color">
    <slot />
  </v-card>
</template>

<script>
export default {
  props: {
    color: {
      type: String,
      default: "#fff"
    },
  }
}
</script>

