<template>
  <div class="login-background">
    <v-row>
      <v-col cols="12" class="d-flex justify-center pr-10">
        <img src="~stopper.svg" art="" width="200px" height="110px">
      </v-col>
      <v-col cols="12">
        <v-card>
          <v-form @submit.prevent="submitData" class="ma-5"> 
            <v-row>
              <v-col cols="12">
                <p v-if="errors !== ''" class="d-flex justify-center red--text">{{errors}}</p>
                <v-text-field
                  v-model="loginInfo.email"
                  :rules="emailRules"
                  label="e-mail"
                  required
                ></v-text-field>
              </v-col>
              <v-col cols="12">
                <v-text-field
                  v-model="loginInfo.password"
                  label="パスワード"
                  required
                  autocomplete="on"
                  type="password"
                ></v-text-field>
              </v-col>
              <v-col cols="12" class="d-flex justify-center">
                <v-btn type="submit" class="white--text button-color">ログイン</v-btn>
              </v-col>
            </v-row>
          </v-form>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios';
import 'stopper.svg'

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
      loginInfo: {
        email: '',
        password: '',
      },
      errors: '',
      emailRules: [
        v => !!v || 'E-mail is required',
        v => /.+@.+/.test(v) || 'E-mail must be valid',
      ],
      show: false,
    }  
  },
  computed: {
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    },
    storeUser: function() {
      return this.$store.getters.storeUser
    }
  },
  methods: {
    submitData: function() { 
      axios
        .post('/sessions', this.loginInfo)
        .then(() => {
          this.$store.dispatch('getSelf');
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = 'メールアドレスかパスワードに誤りがあります';
          }
          console.error('通信エラーです');
        })
    },
  }
}
</script>

<style scoped>
.stopper_icon {
  width: 30px;
}
.login-background {
  background-color: #F1F1F2;
  padding: 30px;
  height: 100%;
}
.button-color {
  background-color: #1995AD !important;
}
</style>
