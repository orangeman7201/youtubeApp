<template>
  <v-btn class="white--text button-base" :color="color">
    <slot />
  </v-btn>
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

<style scoped>
.button-base {
  font-size: 15px;
  width: 106px !important;
  height: 48px !important;
  border-radius: 2px;
}
</style>
