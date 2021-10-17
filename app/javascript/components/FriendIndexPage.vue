<template>
  <v-container  id="typography-view" fluid tag="section" class="grey lighten-3">

    <v-card class="ma-5">
      <v-row>
        <v-col v-if="this.requests.length === 0" col="12" class="text-h4 d-flex justify-center">友達申請はありません</v-col>
        <v-col v-else col="12" class="text-h4 d-flex justify-center">
          <p class="text-h4">友達申請
            <table class="ma-5">
              <tr v-for="request in requests" :key="request.id">
                <td class="text-h6">{{request.name}}</td>
                <td><v-btn @click="accept(request)" class="ml-10 mr-5 white--text green accent-3">承認する</v-btn></td>
                <td><v-btn @click="accept(request)" class="mr-5 white--text green accent-3">承認しない</v-btn></td>
              </tr>
            </table>
          </p>
        </v-col>
      </v-row>
    </v-card>

    <v-card class="ma-5">
      <v-row>
        <v-col v-if="this.friends.length === 0" col="12" class="text-h4 d-flex justify-center">まだ友達はいません</v-col>
        <v-col v-else col="12" class="text-h4 d-flex justify-center">
          <p>友達一覧
            <v-list>
              <v-list-item v-for="friend in friends" :key="friend.id" class="text-h6 mt-5">
                  {{friend.name}}
              </v-list-item>
            </v-list>
          </p>
        </v-col>
      </v-row>
    </v-card>
  
    <v-card class="ma-5">
      <v-row>
        <v-col col="12" class="text-h4 d-flex justify-center">
          <p>視聴時間ランキング</p>
        </v-col>
      </v-row>

      <v-row align="center" justify="center">
        <v-col class="d-flex justify-center">
          <v-simple-table  class="text-h5">
            <template>
              <table>
                <tr v-for="(friend, index) in filteredFriends" :key="friend.id">
                  <td class="pr-7">{{index + 1}}位</td>
                  <td class="pr-7">{{friend.name}}</td>
                  <td class="pr-7">
                    <span v-if="friend.total_duration >= 3600">
                      {{Math.floor(friend.total_duration/3600)}}時間
                    </span>
                    <span v-if="friend.total_duration >= 60">
                      {{Math.floor(friend.total_duration/60%60)}}分
                    </span>{{friend.total_duration%60}}秒
                  </td>
                </tr>
              </table>
            </template>
          </v-simple-table>
        </v-col>
      </v-row>
    </v-card>
  </v-container>
</template>

<script>
import axios from 'axios';
export default {
  data: function () {
    return {
      requests: {},
      friends: [],
      rankingFriends: []
    }  
  },
  mounted () {
    this.getRequests();
    this.getFriends();
    this.getMyData();
  },
  computed: {
    filteredFriends: function() {
      const filteredFriends = this.rankingFriends.sort((a, b) => {
        return b.total_duration - a.total_duration
      })
      return filteredFriends
    }
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
        .then(response => {
          response.data.forEach(element => {
            this.friends.push(element)
            this.rankingFriends.push(element)
          });
        })
    },
    getMyData: function() {
      axios
        .post('/users/self.json')
        .then(response => (this.rankingFriends.push(response.data)));
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