<template>
  <v-app class="signin-background">
    <div class="header">
      <!-- 遷移先はそれぞれcomputedで変えてコンポーネントごとに遷移先を宣言的に変えたい -->
      <router-link to="/">
        <v-btn
          icon
          color="gray"
          width="24px"
          height="24px"
          class="back-button"
        >
          <v-icon size="24px">mdi-chevron-left</v-icon>
        </v-btn>
      </router-link>
    </div>
    <router-view
      :limit="user.limit"
      @change="handleChange"
    ></router-view>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      user: {
        name: '',
        email: '',
        limit: 0,
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
    isAbleSignin() {
      return Object.values(this.user).includes('')
    },
  },
  methods: {
    handleChange(event, path) {
      const element = path.split('/')[2]
      this.user[element] = event
    },
    submitData: function() { 
      axios
        .post('/sign_up', this.user)
        .then(() => {
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        })
    },
  }
}
</script>

<style scoped>
.header {
  position: relative;
  height: 24px;
  margin-bottom: 48px
}
.back-button {
  position: absolute;
  top: 0;
  left: 0;
}
.signin-text {
  display: flex;
  justify-content: center;
  line-height: 24px;
}
.text-field {
  font-size: 16px;
}
.signin-background {
  background-color: #ffffff;
  padding: 20px;
  height: 100%;
}
.signin-button {
  background-color: #1995ad !important;
  max-width: 280px;
  font-size: 16px
}
.error-message {
  font-size: 12px;
  color: #EB440C;
}
</style>
