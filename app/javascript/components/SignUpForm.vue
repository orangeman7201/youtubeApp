<template>
  <div id="app">
    <form @submit.prevent="submitData">
      <label for="name">ユーザー名</label>
      <input id="name" type="text" v-model="userInfo.name">

      <label for="email">メールアドレス</label>
      <input id="email" type="text" v-model="userInfo.email">

      <label for="password">パスワード</label>
      <input id="password" type="text" v-model="userInfo.password">

      <label for="confirmationPassword">パスワード確認</label>
      <input id="confirmationPassword" type="text" v-model="userInfo.confirmationPassword">

      <button type="submit">新規ユーザー作成</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      userInfo: {
        name: '',
        email: '',
        password: '',
        confirmationPassword: '',
      },
    }  
  },
  methods: {
    submitData: function() {
      if( this.url === '' ) {
        alert('urlを入力してください')
      } else {  
        axios
          .post('/movies', this.movie)
          .then(response => {
            let e = response.data
            this.$router.push({name: 'MovieDetailPage', params: { id: e.id } })
          })
          .catch(error => {
            console.error(error);
            console.error('通信エラーです');
            console.error(this.movie);
          })
      }
    },
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>