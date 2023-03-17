<template>
  <div>
    <div class="header">
      <img src="~disabled_visible.svg" art="" width="70px" height="70px" class="mb-5">
      <h3>パスワード</h3>
    </div>
    <div class="input-area1">
      <input
        class="input-box"
        type="password"
        autofocus
        placeholder="半角英数字6文字以上"
        :value="password"
        @input="changeParentValueWithPath"
      >
    </div>
    <div class="input-area2">
      <input
        class="input-box"
        type="password"
        placeholder="確認用パスワード"
        :value="passwordConfirmation"
        @input="changeParentPasswordConfirmationValue"
      >
      <div class="error-message">{{ errorMessage }}</div>
    </div>
    <div class="d-flex justify-center">
      <div  v-if="invalidPassword" class="next-button disable-button" @click="showErrorMessage">次へ</div>
      <div  v-else class="next-button active-button" @click="moveToNextPage">次へ</div>
    </div>
  </div>
</template>

<script>
import RoundedButtonBase from '../../../modules/RoundedButtonBase.vue'

export default {
  components: { RoundedButtonBase },
  props: {
    password: {
      type: String,
      default: "",
    },
    passwordConfirmation: {
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
    invalidPassword() {
      return this.password.length < 6 || this.password !== this.passwordConfirmation
    }
  },
  methods: {
    changeParentValueWithPath(event) {
      this.$emit('change', event.target.value, this.$route.path)
    },
    changeParentPasswordConfirmationValue(event) {
      this.$emit('change', event.target.value, "/signin/passwordConfirmation")
    },
    showErrorMessage() {
      if(this.password.length < 6) {
        this.errorMessage = 'パスワードを6文字以上で入力してください。'
        return
      }
      this.errorMessage = '入力されたパスワードと確認用パスワードが一致しません。'
    },
    moveToNextPage() {
      this.$router.push({name: 'SignUpConfirm' })
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
.input-area1 {
  margin-bottom: 50px;
  display: flex;
  justify-content: center;
}
.input-area2 {
  margin-bottom: 76px;
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
