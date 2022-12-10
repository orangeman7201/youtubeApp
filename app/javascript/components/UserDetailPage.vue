<template>
  <v-container fill-height class="grey lighten-3">
    <v-card >
      <v-form @submit.prevent="submitData" class="ma-5"> 
          <v-row>
            <v-col cols="12">
              <p>{{user.name}}</p>
            </v-col>
            <v-col cols="12" class="d-flex justify-center">
              <p>申請しますか？</p>
            </v-col>

              <v-row align="center" justify="center" class="mb-5">
                  <v-btn type="submit" class="white--text green accent-3">申請</v-btn>
                <v-col cols="1">
                </v-col>
                <v-col cols="1">
                  <v-btn router to="/users/serch" class="white--text green accent-3">戻る</v-btn>
                </v-col>
              </v-row>

          </v-row>
      </v-form>
    </v-card>
  </v-container>
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
      .then(response => (this.user = response.data))
    },
  methods: {
    submitData: function() {
      axios
        .post('/requests/create', this.user)
        .then(response => {
          let e = response.data
          this.$router.push({name: 'Home' })
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