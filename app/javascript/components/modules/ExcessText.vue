<template>
  <span class="excessText" :style="{ fontSize: excessTextFontSize }">過剰</span>
</template>

<script>
export default {
  fontSize: { type:[Number], default: 15 },
  computed: {
    excessTextFontSize() {
      return `${this.fontSize}px`
    }
  }
}
</script>


<style scoped>
  .excessText {
    border: 0.8px solid #EB440C;
    margin-right: 4px;
    padding: 0 7px;
    font-size: 9px;
  }
</style>

