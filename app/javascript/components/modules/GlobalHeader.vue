<template>
  <header class="header">
    <button @click.prevent="drawer =!drawer" v-if="!isLoginPage" class="humbarger-button">
      <img src="~menu.svg" art="" width="24px" height="24px">
    </button>
    <h4 class="d-flex justify-center header-title">{{$route.meta.title}}</h4>
    <v-navigation-drawer app temporary v-model="drawer" color="#858585">
      <v-list class="mt-15">
        <v-list-item v-for="list in lists" :key="list.title" router :to="list.route"  class="list-item">
          <v-list-item-action>
            <v-icon class="white--text">{{list.icon}}</v-icon>
          </v-list-item-action>
          <v-list-item-content class="white--text">{{list.title}}</v-list-item-content>
        </v-list-item>
        <v-list-item class="list-item" @click.prevent="logout">
          <v-list-item-action>
            <v-icon class="white--text">mdi-logout</v-icon>
          </v-list-item-action>
          <v-list-item-content class="white--text">ログアウト</v-list-item-content>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </header>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      drawer: false,
      lists: [
        {icon: 'mdi-home', title: 'ホーム', route: '/home'},
        {icon: 'mdi-account-group ', title: 'フレンド', route: '/users/search'},
        {icon: 'mdi-account', title: 'マイページ', route: '/profile'},
        {icon: 'mdi-bell', title: '通知', route: '/notification'},
      ],
    }
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    isLoginPage: function() {
      return this.$route.path === '/login'
    },
  },
  methods: {
    logout: function() { 
      if(confirm('ログアウトしますか')) {
        axios
          .post('/api/v1/sessions/logout')
          .then(() => {
            this.$store.dispatch('lostUser')
            this.$router.push({name: 'Login' })
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
    oneDayAgo: function() {
      this.$store.dispatch('oneDayAgo')
    },
    oneDayAfter: function() {
      this.$store.dispatch('oneDayAfter')
    },
  },
}
</script>

<style scoped>
.header {
  background-color: #1995AD;
  height: 40px;
  width: 100%;
  position: relative;
}
.humbarger-button {
  position: absolute;
  top: 8px;
  left: 16px;
}
.header-title {
  color: white;
  font-size: 16px;
  font-weight: 400;
  line-height: 16px;
  align-items: center;
  height: 100%;
}
</style>