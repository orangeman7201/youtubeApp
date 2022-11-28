<template>
  <div>
    <div class="header">
      <img src="~access_time.svg" art="" width="70px" height="70px" class="mb-5">
      <h3>１日あたりの目標時間</h3>
    </div>
    <div class="input-area">
      <div class="input-area2">
        <input
          class="input-box"
          type="number"
          autofocus
          placeholder="0"
          :value="inputValue"
          @input="changeParentValueWithPath"
        >
        <span class="minute-text" :style="minuteTextColor">分</span>
      </div>
    </div>
    <div class="d-flex justify-center">
      <router-link  class="next-button" to="/signup/name">次へ</router-link>
    </div>
  </div>
</template>

<script>
import RoundedButtonBase from '../../../modules/RoundedButtonBase.vue'

export default {
  components: { RoundedButtonBase },
  props: {
    limit: {
      type: Number,
    },
  },
  computed: {
    inputValue() {
      return this.limit === 0 ? null : this.limit / 60
    },
    minuteTextColor() {
      return this.limit === 0 ? 'color: #8C8C8C' : 'color: #000000'
    }
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
.header {
  display: flex;
  align-items: center;
  flex-direction: column;
  margin-bottom: 53px;
}
.input-area {
  margin-bottom: 144px;
  display: flex;
  justify-content: center;
}
.input-area2 {
  width: 60px;
  position: relative;
}
.input-box {
  width: 60px;
  font-size: 37px;
  text-align: center;
  outline: none;
  caret-color: #1995AD;
}
input::placeholder {
  color: #8C8C8C;
}
.minute-text {
  position: absolute;
  bottom: 8px;
  right: -36px;
  font-size: 16px;
}
.next-button {
  width: 80%;
  height: 44px;
  padding: 12px 2px;
  background-color: #1995ad;
  color: white;
  display: block;
  text-decoration: none;
  text-align: center;
  border-radius: 100px;
  margin: 0 auto 26px;
}
input[type="number"]::-webkit-outer-spin-button, 
input[type="number"]::-webkit-inner-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
} 
input[type="number"] { 
  -moz-appearance:textfield; 
}
</style>
