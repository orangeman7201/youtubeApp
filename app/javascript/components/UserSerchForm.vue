<template>
  <v-container fill-height class="grey lighten-3">
    <v-row align="center" justify="center">

      <v-card>
        <v-form @submit.prevent="submitData" class="ma-5"> 
            <v-row align="center" justify="center">
              <v-col cols="12" v-if="error !== ''">
                <p class="red--text mt-5 text-h6">ユーザーが見つかりません</p>
              </v-col>
              <v-col cols="12">
                <v-text-field
                  v-model="inputUserName.userName"
                  label="ユーザー名"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="d-flex justify-center">
                <v-btn type="submit" class="white--text green accent-3 mb-5">検索</v-btn>
              </v-col>
            </v-row>
        </v-form>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
axios.interceptors.request.use((config) => {
  if(['post', 'put', 'patch', 'delete'].includes(config.method)) {
    config.headers['X-Requested-With'] = 'XMLHttpReq'
    config.headers['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }
  return config;
}, (error) => {
  return Promise.reject(error);
});

export default {
  data: function () {
    return {
      inputUserName: {
        userName: ''
      },
      error: ''
    }  
  },
  methods: {
    submitData: function() {
      if( this.inputUserName === '' ) {
        this.error = 'error';
      } else {
        this.error = '';
        axios
          .post('/requests', this.inputUserName)
          .then(response => {
            let e = response;
            this.$router.push({name: 'UserDetailPage', params: { id: e.data.id } })
          })
          .catch(this.error = 'error')
      }
    }
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>