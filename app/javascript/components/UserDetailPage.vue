<template>
  <v-app>
    <v-container>
      <v-layout>
        <v-flex md>
          <div id="app">
            <form @submit.prevent="submitData">
              <table>
                <tr>
                  <th>ユーザー名</th>
                </tr>
                <tr>
                  <td>{{user.name}}</td>
                  <td><button type="submit">申請</button></td>
                </tr>
              </table>
            </form>
          </div>
        </v-flex>
      </v-layout>
    </v-container>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      user: {}
    }
  },
  mounted () {
    axios
      .get(`/users/${this.$route.params.id}.json`)
      // .then(response => console.log(response.dat)
      .then(response => (this.user = response.data))
    },
  methods: {
    submitData: function() {
      axios
        .post('/requests/create', this.user)
        .then(response => {
          let e = response.data
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          console.error(error);
          console.error('Rubyの方の通信エラーです');
        })
    }
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>