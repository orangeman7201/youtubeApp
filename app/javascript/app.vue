<template>
  <v-app>
    <v-navigation-drawer permanent app color="green accent-3">
      <v-list>

        <v-list-item  class="white">
          {{user.name}}
        </v-list-item>

        <v-list-item  v-for="list in lists" :key="list.title" router :to="list.route"  class="white--text">
          <v-list-item-action>
            <v-icon class="white--text">{{list.icon}}</v-icon>
          </v-list-item-action>
          <v-list-item-content class="white--text">{{list.title}}</v-list-item-content>
        </v-list-item>

        <v-list-item>
          <v-btn router to="/movies/new">動画を追加</v-btn>
        </v-list-item>

        <v-list-item>
          <v-btn @click="logout">ログアウト</v-btn>
        </v-list-item>

      </v-list>
    </v-navigation-drawer>
  <v-main>
    <router-view></router-view>
  </v-main>
  </v-app>  
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      user: {name: 'akita'},
      lists: [
        {icon: 'mdi-home', title: 'ホーム', route: '/'},
        {icon: 'mdi-magnify', title: 'ユーザー検索', route: '/users/serch'},
        {icon: 'mdi-account-multiple', title: '友達一覧', route: '/freinds/index'},
        {icon: 'mdi-clipboard-account', title: 'ユーザー新規登録', route: '/signup'},
        {icon: 'mdi-chart-line', title: 'グラフ', route: '/movies/chart'},
      ]
    }
  },
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


