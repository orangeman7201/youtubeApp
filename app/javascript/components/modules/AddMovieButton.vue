<template>
  <router-link class="add-movie-button" to="/movies/new">
    <span class="dli-plus"></span>
  </router-link>
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
.add-movie-button {
  position: fixed;
  top: 36px;
  right: 24px;
  width: 75px;
  height: 75px;
  border-radius: 50%;
  z-index: 1;
  background-color: #E8730E;
  border: solid 2px #FFFFFF;
}
.dli-plus {
  display: inline-block;
  vertical-align: middle;
  color: #FFFFFF;
  width: 30px;
  height: 3px;
  background: currentColor;
  position: relative;
  top: 22px;
  left: 20px
}
.dli-plus::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: inherit;
  transform: rotate(90deg);
}
</style>

