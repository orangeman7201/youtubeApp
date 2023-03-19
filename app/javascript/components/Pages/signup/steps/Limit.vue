<template>
  <div>
    <div class="header">
      <img src="~access_time.svg" art="" width="70px" height="70px" class="mb-5">
      <h3>１日あたりの目標時間</h3>
    </div>
    <div class="input-area">
      <div class="input-area2">
        <!-- v-modelでscopedLimitを管理したいところだったが3桁までにしたかったので:と@inputで管理 -->
        <input
          class="input-box"
          type="number"
          autofocus
          placeholder="0"
          :value="scopedLimit"
          @input="inputScopedLimit"
        >
        <span class="minute-text" :style="minuteTextColor">分</span>
      </div>
      <div class="error-message">{{ errorMessage }}</div>
    </div>
    <div class="d-flex justify-center">
      <div  v-if="!scopedLimit || scopedLimit > 999" class="next-button disable-button" @click="showErrorMessage">次へ</div>
      <div  v-else class="next-button active-button" @click="checkLimitAndMoveToNextPage">次へ</div>
    </div>
  </div>
</template>

<script>
import RoundedButtonBase from '../../../modules/RoundedButtonBase.vue'

export default {
  components: { RoundedButtonBase },
  // limitの単位(second)
  props: {
    limit: {
      type: Number,
    },
  },
  // limitの単位をminuteに戻すためにscopedLimitを60で割って初期化
  data() {
    return {
      scopedLimit: this.limit === 0 ? null : this.limit / 60,
      errorMessage: ''
    }
  },
  computed: {
    minuteTextColor() {
      return this.scopedLimit === 0 ? 'color: #8C8C8C' : 'color: #000000'
    },
  },
  methods: {
    // 3桁までしか目標時間を入力させたくない。
    inputScopedLimit(event) {
      this.errorMessage = ''
      const target = event.target.value
      // nullを代入しないと正常に動作しない
      // 例えば1234と入力されたとき scopedLimitは元々123が入っていており、
      // 123を代入しなくても同じ値になるためサボる。結果inputが更新されない。
      this.scopedLimit = null
      this.scopedLimit = target.slice(0, 3)
      if(String(target).length > 3) {
        this.showErrorMessage()
      }
    },

    checkLimitAndMoveToNextPage() {
      if(!this.scopedLimit || this.scopedLimit > 999) {
        return
      }
      this.$emit('change', this.scopedLimit * 60, this.$route.path)
      this.$router.push({name: 'SignUpName' })
    },

    showErrorMessage() {
      this.errorMessage = '目標時間を999分以内で入力してください。'
    }
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
  align-items: center;
  flex-flow: column;
}
.input-area2 {
  width: 70px;
  position: relative;
}
.input-box {
  width: 70px;
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
input[type="number"]::-webkit-outer-spin-button, 
input[type="number"]::-webkit-inner-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
} 
input[type="number"] { 
  -moz-appearance:textfield; 
}
</style>
