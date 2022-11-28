<template>
  <div>
    <div class="header">
      <img src="~face.svg" art="" width="70px" height="70px" class="mb-5">
      <h3>ニックネーム</h3>
    </div>
    <div class="input-area">
      <input
        class="input-box"
        type="text"
        maxlength="10"
        autofocus
        placeholder="全角10文字以内"
        :value="name"
        @input="changeParentValueWithPath"
      >
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
    name: {
      type: String,
      default: "",
    },
  },
  methods: {
    changeParentValueWithPath(event) {
      this.$emit('change', event.target.value, this.$route.path)
    },
  }
}
</script>

<style scoped>
.header {
  display: flex;
  align-items: center;
  flex-direction: column;
  margin-bottom: 74px;
}
.input-area {
  margin-bottom: 144px;
  display: flex;
  justify-content: center;
}
.input-box {
  font-size: 16px;
  text-align: center;
  outline: none;
  caret-color: #1995AD;
}
.input-box::placeholder {
  color: #8C8C8C;
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
</style>
