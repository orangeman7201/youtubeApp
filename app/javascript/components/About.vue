<template>
  <v-app>
      

    <section id="hero">
      <v-row
        fill-height
        align="center"
        class="green accent-2 white--text mx-auto"
        justify="center"
      >
        <v-col
          :class="[$vuetify.breakpoint.smAndDown ? 'mt-10' : '']"
          class="white--text text-center"
          lg6
          md12
          tag="h1"
        >
          <span
          :class="[$vuetify.breakpoint.smAndDown ? 'display-1' : 'display-2']"
            class="font-weight-light"
          >
            WELCOME TO
          </span>

          <span
            :class="[$vuetify.breakpoint.smAndDown ? 'display-3': 'display-4']"
            class="font-weight-black "
          >
            YSTOPPER
          </span>

        </v-col>
        <v-col
          lg6
          md12
        >
          <v-card class="pa-5 ma-5">
            <v-form class="ma-5"> 
              <v-row>
                <v-col cols="12">
                  <v-text-field
                    v-model="user.name"
                    label="ユーザー名"
                    required
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    v-model="user.email"
                    :rules="emailRules"
                    label="e-mail"
                    required
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    v-model="user.password"
                    label="パスワード"
                    required
                    :append-icon="toggle.icon"
                    :type="toggle.type"
                    autocomplete="on"
                    @click:append="show = !show"
                  ></v-text-field>
                </v-col>
                <v-col cols="12">
                  <v-text-field
                    v-model="user.passwordConfirmation"
                    label="パスワード確認"
                    required
                    :append-icon="toggle.icon"
                    :type="toggle.type"
                    autocomplete="on"
                    @click:append="show = !show"
                  ></v-text-field>
                </v-col>
                <v-col cols="12" class="d-flex justify-center">
                  <v-btn @click.prevent="submitData" type="submit" class="white--text green accent-2">はじめる</v-btn>
                </v-col>
              </v-row>
            </v-form>
            <v-divider></v-divider>
            <v-row justify="center" align="center">
              <v-col align="center">
                <p class="grey--text d-flex justify-center my-7">すでにアカウントをお持ちの場合</p>
                <v-btn router to="/login" class="white--text green accent-2">ログイン</v-btn>
              </v-col>
            </v-row>
            <v-divider class="mt-5"></v-divider>
            <v-row justify="center" align="center">
              <v-col align="center">
                <p class="grey--text d-flex justify-center my-7">ゲストログインはこちら</p>
                <v-btn class="white--text green accent-2" @click.prevent="gestlogin">ゲストログイン</v-btn>
              </v-col>
            </v-row>
          </v-card>

        </v-col>
      </v-row>
    </section>

  </v-app>  
</template>

<script>
import axios from 'axios';
export default {
  
  data () {
    return {
      user: {
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
      if(this.user.name !== '' && this.user.email !== '' && this.user.password !== '' && this.user.passwordConfirmation !== '' ) {
        axios
        .post('/sign_up', this.users)
        .then(() => {
          this.$router.push({name: 'HomeIndexPage' })
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
        .post('/gest/login', 'gest@example.com')
        .then(() => {
          this.$store.dispatch('getData')
          this.$router.push({name: 'HomeIndexPage' })
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