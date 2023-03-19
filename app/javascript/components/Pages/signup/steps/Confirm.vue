<template>
  <div>
    <div class="header">
      登録内容の確認
    </div>
    <ul v-for="error in errors">
      <li class="error-message">{{ error }}</li>
    </ul>
    <div class="confirm-body px-4">
      <div class="mb-4">
        <div class="confirm-detail-header">
          <img src="~access_time_small.svg" art="" width="24px" height="24px" class="mr-2 mb-2">
          <span>1日あたりの目標時間</span>
        </div>
        {{ limit / 60 }}分
      </div>
      <div class="mb-4">
        <div class="confirm-detail-header">
          <img src="~face_small.svg" art="" width="24px" height="24px" class="mr-2 mb-2">
          <span>ニックネーム</span>
        </div>
        {{ nickname }}
      </div>
      <div class="mb-4">
        <div class="confirm-detail-header">
          <img src="~email_small.svg" art="" width="24px" height="24px" class="mr-2 mb-2">
          <span>メールアドレス</span>
        </div>
        {{ email }}
      </div>
      <div class="mb-4">
        <div class="confirm-detail-header">
          <img src="~disabled_visible_small.svg" art="" width="24px" height="24px" class="mr-2 mb-2">
          <span>パスワード</span>
        </div>
        {{ password }}
      </div>
    </div>
    <button v-if="isValidInput" class="submit-button" @click.prevent="$emit('submit')">登録</button>
    <button v-else class="submit-button disable-button">登録</button>
  </div>
</template>

<script>
import RoundedButtonBase from '../../../modules/RoundedButtonBase.vue'

export default {
  components: { RoundedButtonBase },
  props: {
    limit: {
      type: Number,
      default: undefined,
    },
    nickname: {
      type: String,
      default: "",
    },
    email: {
      type: String,
      default: "",
    },
    password: {
      type: String,
      default: "",
    },
    errors: {
      type: Array,
      default: [],
    }
  },
  computed: {
    isValidInput() {
      if(!this.limit || this.limit / 60 > 999) {
        return false
      }
      if(this.nickname.length <= 0 || this.nickname.length > 10) {
        return false
      }
      if(!this.email.match(/.+@.+\..+/)) {
        return false
      }
      if(this.password.length < 6) {
        return false
      }
      return true
    }
  },
  methods: {
    changeParentValueWithPath(event) {
      this.$emit('change', event.target.value, this.$route.path)
    },
    changeParentPasswordConfirmationValue(event) {
      this.$emit('change', event.target.value, "/signin/passwordConfirmation")
    },
  }
}
</script>

<style scoped>
.header {
  display: flex;
  justify-content: center;
  font-weight: 700;
  font-size: 16px;
  margin-bottom: 33px;
}
.confirm-body {
  font-weight: 400px;
  font-size: 16px;
  margin-bottom: 40px
}
.confirm-detail-header {
  display: flex;
  align-items: center;
  color: #949494;
}
.submit-button {
  width: 80%;
  height: 44px;
  padding: 12px 2px;
  color: white;
  display: block;
  text-decoration: none;
  text-align: center;
  border-radius: 100px;
  margin: 0 auto 26px;
  background-color: #1995ad;
}
li {
  list-style: none
}
.disable-button {
  background-color: #D9D9D9;
}
</style>

