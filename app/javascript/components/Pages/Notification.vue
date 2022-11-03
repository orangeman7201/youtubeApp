<template>
  <div>
    <v-card class="ma-5">
      <v-row>
        <v-col v-if="this.requests.length === 0" col="12" :class="[$vuetify.breakpoint.smAndDown ? 'text-h6' : 'text-h4 d-flex justify-center']">友達申請はありません</v-col>
        <v-col v-else col="12">
          <p :class="[$vuetify.breakpoint.smAndDown ? 'text-h6' : 'text-h4 d-flex justify-center']">友達申請</p>
          <p>
            <v-responsive class="mx-auto mb-3" width="90">
              <v-divider class="mb-1"></v-divider>
              <v-divider></v-divider>
            </v-responsive>
          </p>
          <p class="mx-auto">
            <table :class="[$vuetify.breakpoint.smAndDown ? 'ma-3' : 'ma-5']">
              <tr v-for="request in requests" :key="request.id">
                <td :class="[$vuetify.breakpoint.smAndDown ? 'text-caption': 'text-h6']">{{request.name}}</td>
                <td><v-btn @click="accept(request)" class="white--text green accent-3" :class="[$vuetify.breakpoint.smAndDown ? 'text-caption ml-5 mr-5 mb-3' : 'ml-10 mr-5']">承認する</v-btn></td>
                <td><v-btn @click="accept(request)" class="white--text green accent-3" :class="[$vuetify.breakpoint.smAndDown ? 'text-caption mb-3' : 'mr-5 ']">承認しない</v-btn></td>
              </tr>
            </table>
          </p>
        </v-col>
      </v-row>
    </v-card>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return {
      requests: null,
    }
  },
  mounted() {
    this.getRequests();
  },
  computed: {
  },
  methods: {
    getRequests: function() {
      axios
        .get(`/requests.json`)
        .then(response => (this.requests = response.data))
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
  }
}
</script>
