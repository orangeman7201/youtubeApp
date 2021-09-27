<template>
  <div id="app">
    <div v-if="this.requests.length === 0">友達申請はありません</div>
    <table v-else>
      <tr>
        <th>フレンド申請</th>
      </tr>
      <tr v-for="request in requests" :key="request.id">
        <td>{{request.name}}</td>
        <td>
          <button @click="accept(request)">承認する</button>
          <button @click="reject(request)">承認しない</button>
        </td>
      </tr>
    </table>
    <div v-if="this.friends.length === 0">まだ友達はいません</div>
    <table v-else>
      <tr>
        <th>友達一覧</th>
        <th>今日の視聴時間</th>
      </tr>
      <tr v-for="friend in friends" :key="friend.id">
        <td>{{friend.name}}</td>
        <td>{{friend.total_duration}}</td>
      </tr>
    </table>
    <button @click="check"></button>
  </div>
</template>

<script>
import axios from 'axios';
export default {
  data: function () {
    return {
      requests: {},
      friends: {}
    }  
  },
  mounted () {
    this.getRequests();
    this.getFriends();
  },

  methods: {
    getRequests: function() {
      axios
        .get(`/requests.json`)
        .then(response => (this.requests = response.data))
    },
    getFriends: function() {
      axios
        .get(`/friends.json`)
        .then(response => (this.friends = response.data))
    },
    check: function() {
      console.log(this.requests)
    },
    accept: function(request) {
      axios
        .post('/friends', request)
        .then(response => {
          // let e = response.data
          console.log(response)
          console.log('成功です')
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.error('通信エラーです');
        })
    },
    reject: function(request) {
      axios
        .post('/requests/destroy', request)
        .then(response => {
          // let e = response.data
          console.log(response)
          console.log('成功です')
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          console.error(error);
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
  font-size: 2em;
  text-align: center;
}
</style>