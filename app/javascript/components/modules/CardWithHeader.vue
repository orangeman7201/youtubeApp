<template>
  <v-card width="100%" flat :color="color">
    <div class="header">{{ headerText }}</div>
    <div class="">
      <slot /> 
    </div>
  </v-card>
</template>

<script>
export default {
  props: {
    headerText: {
      type: String,
      default: ""
    },
  },
}
</script>

<style scoped>
.header {
  color: #FFFFFF;
  background-color: #48A6BC;
  font-size: 15px;
  height: 45px;
  display: flex;
  justify-content: center;
  align-items: center;
}
.content {
  padding: 15px;
}
</style>

