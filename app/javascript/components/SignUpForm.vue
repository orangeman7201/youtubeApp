<template>
  <v-container fluid class="grey lighten-3">
    <v-card >
      <v-form @submit.prevent="submitData" class="ma-5"> 
          <v-row>
            <v-col cols="12">
              <v-text-field
                v-model="users.name"
                label="ユーザー名"
                required
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="users.email"
                :rules="emailRules"
                label="e-mail"
                required
              ></v-text-field>
            </v-col>
            <v-col cols="12">
              <v-text-field
                v-model="users.password"
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
                v-model="users.passwordConfirmation"
                label="パスワード確認"
                required
                :append-icon="toggle.icon"
                :type="toggle.type"
                autocomplete="on"
                @click:append="show = !show"
              ></v-text-field>
            </v-col>
            <v-col cols="12" class="d-flex justify-center">
              <v-btn type="submit" class="white--text green accent-3">作成</v-btn>
            </v-col>
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
    submitData: function() { 
      axios
        .post('/users', this.users)
        .then(response => {
          // let e = response.data
          console.log(response)
          console.log('成功です')
          this.$router.push({name: 'HomeIndexPage' })
          // this.$router.push({name: 'HomeIndexPage', params: { id: e.id } })
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