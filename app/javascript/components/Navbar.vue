<template>
  <nav>
    <v-app-bar
      app
      dark
      flat
      color="green accent-2"
      height="70"
    >
      <v-app-bar-nav-icon @click="drawer = !drawer">
      </v-app-bar-nav-icon>

    </v-app-bar>

    <v-navigation-drawer app temporary v-model="drawer" color="green accent-2">
      <v-list>
        <v-list-item  class="white">
          {{user.name}}
        </v-list-item>

        <v-list-item v-for="list in lists" :key="list.title" router :to="list.route"  class="white--text">
          <v-list-item-action>
            <v-icon class="white--text">{{list.icon}}</v-icon>
          </v-list-item-action>
          <v-list-item-content class="white--text">{{list.title}}</v-list-item-content>
        </v-list-item>

        <v-list-item class="mt-7">
          <v-btn router to="/movies/new">動画を追加</v-btn>
        </v-list-item>

        <v-list-item class="my-7">
          <v-btn @click.prevent="logout">ログアウト</v-btn>
        </v-list-item>

        <v-list-item class="d-flex justify-center white black--text">
          <v-btn @click.prevent="oneDayAgo" fab max-height="40px" max-width="40px" class="mr-5">
            <v-icon class="text-h4">mdi-menu-left</v-icon>
          </v-btn>
          <span>{{ today | moment("M月D日") }}</span>
          <v-btn @click.prevent="oneDayAfter" fab max-height="40px" max-width="40px" class="ml-5">
            <v-icon class="text-h4">mdi-menu-right</v-icon>
          </v-btn>
        </v-list-item>

      </v-list>
    </v-navigation-drawer>
  </nav>
</template>

<script>
import axios from 'axios';

export default {
  data: function() {
    return {
      user: {},
      drawer: false,
      lists: [
        {icon: 'mdi-home', title: 'ホーム', route: '/home'},
        {icon: 'mdi-magnify', title: 'ユーザー検索', route: '/users/serch'},
        {icon: 'mdi-account-multiple', title: '友達一覧', route: '/freinds/index'},
        {icon: 'mdi-chart-line', title: 'グラフ', route: '/movies/chart'},
      ],
    }
  },
  mounted() {
   axios
      .post('/users/self.json')
      .then(response => (this.user = response.data))
    this.$store.dispatch('inputToday');
  },
  computed: {
    userState: function() {
      return this.$store.state.user 
    },
    today: function() {
      return this.$store.state.today
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