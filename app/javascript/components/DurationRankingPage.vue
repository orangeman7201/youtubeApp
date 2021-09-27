<template>
  <div id="app">
    <table>
      <tr>
        <th>視聴時間ランキング</th>
      </tr>
      <tr v-for="(friend, index) in filteredFriends" :key="friend.id">
        <td>{{index + 1}}位</td>
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
      friends: []
    }  
  },
  mounted () {
    this.getFriends();
    this.getMyData();
  },
  computed: {
    filteredFriends: function() {
      const filteredFriends = this.friends.sort((a, b) => {
        return b.total_duration - a.total_duration
      })
      return filteredFriends
    }
  },
  methods: {
    getFriends: function() {
      axios
        .get(`/friends.json`)
        .then(response => {
          response.data.forEach(element => {
            this.friends.push(element)
          });
        });
    },
    getMyData: function() {
      axios
        .post(`/users/self.json`)
        .then(response => (this.friends.push(response.data)));
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