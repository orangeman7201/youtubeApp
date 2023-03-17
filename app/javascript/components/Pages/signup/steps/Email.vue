<template>
  <div>
    <div class="header">
      <img src="~email.svg" art="" width="70px" height="70px" class="mb-5">
      <h3>メールアドレス</h3>
    </div>
    <div class="input-area">
      <input
        class="input-box"
        type="text"
        autofocus
        placeholder="xxxxxxx@xxx.com"
        :value="email"
        @input="changeParentValueWithPath"
      >
      <div class="error-message">{{ errorMessage }}</div>
    </div>
    <div class="d-flex justify-center">
      <div  v-if="invalidEmail" class="next-button disable-button" @click="showErrorMessage">次へ</div>
      <div  v-else class="next-button active-button" @click="moveToNextPage">次へ</div>
    </div>
  </div>
</template>

<script>
import RoundedButtonBase from '../../../modules/RoundedButtonBase.vue'

export default {
  components: { RoundedButtonBase },
  props: {
    email: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      errorMessage: ''
    }
  },
  computed: {
    invalidEmail() {
      return !this.email.match(/.+@.+\..+/)
    }
  },
  methods: {
    changeParentValueWithPath(event) {
      this.$emit('change', event.target.value, this.$route.path)
    },

    showErrorMessage() {
      this.errorMessage = 'メールアドレスを正しい形式で入力してください(メール認証等はありません)'
    },

    moveToNextPage() {
      this.$router.push({name: 'SignUpPassword' })
    }
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
  align-items: center;
  flex-flow: column;
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
  color: white;
  display: block;
  text-decoration: none;
  text-align: center;
  border-radius: 100px;
  margin: 0 auto 26px;
}
.active-button {
  background-color: #1995ad;
}
.disable-button {
  background-color: #D9D9D9;
}
.error-message {
  color: #EB440C;
}
</style>
