<template>
  <nav>
    <v-app-bar
      app
      flat
      color="#1995AD"
      height="70"
      width="100%"
      class="d-flex justify-center"
    >
        <v-app-bar-nav-icon @click="drawer =!drawer" v-if="!isLoginPage">
        </v-app-bar-nav-icon>
        <h4 class="mx-auto header_title">Y stopper</h4>
        <v-btn icon to="/movies/new" v-if="!isLoginPage">
          <v-icon>mdi-movie-open-plus-outline</v-icon>
        </v-btn>
    </v-app-bar>

    <v-navigation-drawer app temporary v-model="drawer" color="#1995AD">
      <v-list class="mt-4">
        <v-list-item v-for="list in lists" :key="list.title" router :to="list.route"  class="white--text">
          <v-list-item-action>
            <v-icon class="white--text">{{list.icon}}</v-icon>
          </v-list-item-action>
          <v-list-item-content class="white--text">{{list.title}}</v-list-item-content>
        </v-list-item>
        <v-list-item class="my-7">
          <v-btn @click.prevent="logout">ログアウト</v-btn>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
  </nav>
</template>

<script>
import axios from 'axios';
import moment from 'moment'

export default {
  data: function() {
    return {
      drawer: false,
      lists: [
        {icon: 'mdi-home', title: 'ホーム', route: '/home'},
        {icon: 'mdi-magnify', title: 'ユーザー検索', route: '/users/serch'},
        {icon: 'mdi-account-multiple', title: '友達一覧', route: '/freinds/index'},
        {icon: 'mdi-presentation', title: 'タイムライン', route: '/timeline'},
        {icon: 'mdi-book', title: '視聴履歴', route: '/movies'},
        {icon: 'mdi-cog', title: 'プロフィール', route: '/profile'},
      ],
    }
  },
  beforeMount() {
    if(this.storeUser) {
      this.$store.dispatch("getSelg")
    }
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    dateStatus: function() {
      return this.$store.getters.dateStatus
    },
    formattedDate: function() {
      return moment().add(this.dateStatus, 'd').format('MM月DD日')
    },
    isLoginPage: function() {
      return this.$route.path === '/login'
    },
  },
  methods: {
    logout: function() { 
      if(confirm('ログアウトしますか')) {
        axios
          .post('/sessions/logout')
          .then(response => {
            console.log(response)
            console.log('ログアウトしました')
            this.$store.dispatch('lostUser')
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
.header_title {
  color: white;
  font-family: 'Noto Sans';
}
</style>