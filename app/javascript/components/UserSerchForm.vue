<template>
  <div id="app">
    <div v-if="error === ''"></div>
    <div v-else>ユーザーが見つかりません</div>
    <form @submit.prevent="submitData">
      <label for="comment">ユーザー名を入力してください</label>
      <input id="comment" type="text" v-model="inputUserName">
      <button type="submit">検索</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
axios.interceptors.request.use((config) => {
  if(['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-Requested-With'] = 'XMLHttpReq'
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});

export default {
  data: function () {
    return {
      inputUseName: '',
      error: ''
    }  
  },
  methods: {
    submitData: function() {
      if( this.inputUseName === '' ) {
        this.error = 'error';
      } else {
        this.error = '';
        axios
          .post('/request', this.inputUserName)
          .then(response => {
            let e = response.data
            this.$router.push({name: 'UserDetailPage', params: { id: e.id } })
          })
          .catch(error => {
            console.error(error);
            console.error('Rubyの方の通信エラーです');
            this.error = 'error';
          })
      }
    }
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>