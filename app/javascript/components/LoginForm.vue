<template>
  <div id="app">
    <form @submit.prevent="submitData">
      <div v-if="errors.length != 0">
        <ul v-for="e in errors" :key="e">
          <li><font color="red">{{ e }}</font></li>
        </ul>
    </div>
      <label for="email">メールアドレス</label>
      <input id="email" type="text" v-model="loginInfo.email">

      <label for="password">パスワード</label>
      <input id="password" type="text" v-model="loginInfo.password">

      <button type="submit">ログイン</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  data: function () {
    return {
      loginInfo: {
        email: '',
        password: '',
      },
      errors: '',
    }  
  },
  methods: {
    submitData: function() { 
      axios
        .post('/sessions', this.loginInfo)
        .then(response => {
          // let e = response.data
          console.log(response)
          console.log('成功です')
          this.$router.push({name: 'HomeIndexPage' })
          // this.$router.push({name: 'HomeIndexPage', params: { id: e.id } })
        })
        .catch(error => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.error('通信エラーです');
        })
    },
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>