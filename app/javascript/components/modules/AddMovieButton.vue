<template>
  <button class="add-movie-button">
    <span class="dli-plus"></span>
  </button>
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

