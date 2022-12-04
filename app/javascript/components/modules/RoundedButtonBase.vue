<template>
  <v-btn 
    class="white--text button-base"
    rounded
    :color="color"
    :disabled="disabled"
    :width="width"
    :height="height">
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
    width: {
      type: String,
      default: "106px"
    },
    height: {
      type: String,
      default: "48px"
    },
  }
}
</script>

<style scoped>
.button-base {
  font-size: 15px;
}
</style>
