<template>
  <v-container fluid class="grey lighten-3">
    <v-card >
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
                :append-icon="toggle.icon"
                :type="toggle.type"
                autocomplete="on"
                @click:append="show = !show"
              ></v-text-field>
            </v-col>
            <v-col cols="12" class="d-flex justify-center">
              <v-btn type="submit" class="white--text green accent-3">ログイン</v-btn>
            </v-col>
          </v-row>
      </v-form>
    </v-card>
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

  beforeMount() {
    axios
      .get('/session_check')
      .then(response => {
        console.log(response);
        this.$store.state.user = 'ok';
        this.$store.state.today = new Date();
        this.$router.push({name: 'HomeIndexPage' });
      })
      .catch(error => {
        router.push({name: 'LoginForm' })
        console.log(error)
      })
  },

  computed: {
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    }
  },
  methods: {
    submitData: function() { 
      axios
        .post('/sessions', this.loginInfo)
        .then(response => {
          // let e = response.data
          console.log(response)
          console.log('成功です')
          
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
