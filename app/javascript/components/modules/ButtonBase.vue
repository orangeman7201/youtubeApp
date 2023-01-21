<template>
  <v-btn class="white--text button-base" :color="color" :disabled="disabled" rounded>
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
    disabled: {
      type: Boolean,
      default: false
    },
  }
}
</script>

<style scoped>
.button-base {
  font-size: 15px;
  width: 118px !important;
  height: 35px !important;
}
</style>
