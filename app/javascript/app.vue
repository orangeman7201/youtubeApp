<template>
  <v-app>
    <v-app-bar color="green accent-3" dark app>
      <v-btn icon  color="#EEEEEE" :to="'/'"></v-btn>
      <v-toolbar-title @click="$router.push('/')">Home</v-toolbar-title>
      <v-spacer></v-spacer>
       <v-btn @click="$router.push('/friends/ranking')">ランキング</v-btn>
       <v-btn @click="$router.push('/users/serch')">ユーザー検索</v-btn>
       <v-btn @click="$router.push('/freinds/requests')">友達申請</v-btn>
       <v-btn @click="$router.push('/freinds/index')">友達一覧</v-btn>
       <v-btn @click="$router.push('/signup')">ユーザー新規登録</v-btn>
       <v-btn @click="$router.push('/movies/new')">新規作成</v-btn>
       <v-btn @click="$router.push('/movies/chart')">グラフ</v-btn>
       <v-btn @click="logout">ログアウト</v-btn>
    </v-app-bar>
  <v-main>
    <router-view></router-view>
  </v-main>
  </v-app>  
</template>

<script>
import axios from 'axios';

export default {
  methods: {
    logout: function() { 
      if(confirm('ログアウトしますか')) {
        axios
          .post('/sessions/logout')
          .then(response => {
            console.log(response)
            console.log('ログアウトしました')
            this.$router.push({name: 'LoginForm' })
          })
          .catch(error => {
            console.error(error.response.data.errors);
            if (error.response.data && error.response.data.errors) {
              this.errors = error.response.data.errors;
            }
            console.error('通信エラーです');
          })
      }
    },
  }
}
</script>


