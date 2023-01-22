<template>
  <div class="about-background">
    <div class="d-flex justify-center pr-4 ystopper-image">
      <img src="~stopper.svg" art="" width="200px" height="110px">
    </div>
    <div class="about-buttons">
      <router-link to="/signup/limit" class="start-button">さっそく始める</router-link>
      <router-link to="/login" class="login-button">ログイン</router-link>
    </div>
  </div>  
</template>

<script>
import axios from 'axios';
export default {
  
  data () {
    return {
      users: {
        name: '',
        email: '',
        password: '',
        passwordConfirmation: '',
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
    }
  },
  methods: {
    moveSignupPage: function() {
      this.$router.push('/signup')
    },
    submitData: function() {
      if(this.users.name !== '' && this.users.email !== '' && this.users.password !== '' && this.users.passwordConfirmation !== '' ) {
        axios
        .post('/api/v1/sign_up', this.users)
        .then(() => {
          this.$router.push({name: 'Home' })
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.error('通信エラーです');
        })
      } else {
        console.log('失敗です')
      }
    },
    gestlogin: function() {
      axios
        .post('/api/v1/gest/login')
        .then(() => {
          this.$router.push({name: 'Home' })
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.error('通信エラーです');
        })
    }
  }
}
</script>

<style scoped>
.about-background {
  background-color: #f5f5f5;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  flex-direction: column;
  position: relative;
}
.ystopper-image {
  margin-top: -100px;
}
.about-buttons {
  width: 100%;
  text-align: center;
  position: absolute;
  bottom: 100px;
}
.start-button {
  width: 80%;
  height: 44px;
  padding: 12px 2px;
  background-color: #1995ad;
  color: white;
  display: block;
  text-decoration: none;
  text-align: center;
  border-radius: 100px;
  margin: 0 auto 26px;
}
.login-button {
  width: 80%;
  height: 44px;
  color: #5E5E5E;
  text-decoration: none;
  margin: auto;
}
</style>
