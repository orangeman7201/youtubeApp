<template>
  <div id="app">
    <div v-if="this.friends.length === 0">まだ友達はいません</div>
    <table v-else>
      <tr>
        <th>友達一覧</th>
        <th>今日の視聴時間</th>
      </tr>
      <tr v-for="friend in friends" :key="friend.id">
        <td>{{friend.name}}</td>
        <td>
          <span v-if="friend.total_duration >= 3600">
            {{Math.floor(friend.total_duration/3600)}}時間
          </span>
          <span v-if="friend.total_duration >= 60">
            {{Math.floor(friend.total_duration/60%60)}}分
          </span>{{friend.total_duration%60}}秒
        </td>
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
      console.log(this.friends)
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