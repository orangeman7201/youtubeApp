<template>
  <div>
    <input
      type="number"
      placeholder="分"
      autofocus
      :value="limit / 60"
      @input="changeParentValueWithPath"
    >
  </div>
</template>

<script>
export default {
  props: {
    limit: {
      type: Number,
    },
  },
  methods: {
    changeParentValueWithPath(event) {
      const threeDigitsLimit = this.sliceMaxLength(event, 3)
      this.$emit('change', threeDigitsLimit, this.$route.path)
    },
    sliceMaxLength(event, maxLength) {  
      const threeDigitsLimit = event.target.value = event.target.value.slice(0, maxLength)
      return this.changeMinuteToSecond(threeDigitsLimit);  
    }, 
    changeMinuteToSecond(minute) {
      return Number(minute) * 60
    },
  }
}
</script>

<style scoped>
</style>
