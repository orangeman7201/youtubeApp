<template>
  <header class="header">
    <div>
      <button @click="drawer =!drawer" v-if="!isLoginPage" class="humbarger-button">
        <img src="~menu.svg" art="" width="24px" height="24px">
      </button>
      <h4 class="d-flex justify-center header-title">{{$route.meta.title}}</h4>
    </div>
  </header>
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
.header {
  background-color: #1995AD;
  height: 86px;
  width: 100%;
  padding: 40px 0 10px ;
}
.humbarger-button {
  position: absolute;
  top: 34px;
  left: 26px;
}
.header-title {
  color: white;
  font-size: 16px;
  font-weight: 400;
  line-height: 16px;
}
</style>