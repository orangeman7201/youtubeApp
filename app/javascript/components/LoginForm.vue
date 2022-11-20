<template>
  <div class="login-background">
    <div class="header">
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
      <h3 class="login-text">ログイン</h3>
    </div>
    <v-form @submit.prevent="submitData" class="login-form">
      <v-text-field
        v-model="loginInfo.email"
        :rules="emailRules"
        placeholder="メールアドレス"
        required
        autofocus
        class="text-field"
      ></v-text-field>
      <v-text-field
        v-model="loginInfo.password"
        placeholder="パスワード"
        required
        autocomplete="on"
        type="password"
        class="mb-2"
      ></v-text-field>
      <div class="d-flex justify-center">
        <v-btn type="submit" class="white--text login-button" rounded width="80%" height="44px">ログイン</v-btn>
      </div>
    </v-form>
  </div>
</template>

<script>
import axios from "axios";
import "stopper.svg";
import Card from "./modules/Card.vue";

axios.interceptors.request.use(
  (config) => {
    if (["post", "put", "patch", "delete"].includes(config.method)) {
      config.headers["X-Requested-With"] = "XMLHttpReq";
      config.headers["X-CSRF-Token"] = document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

export default {
  components: { Card },
  data: function() {
    return {
      loginInfo: {
        email: "",
        password: "",
      },
      errors: "",
      emailRules: [
        (v) => !!v || "E-mail is required",
        (v) => /.+@.+/.test(v) || "E-mail must be valid",
      ],
      show: false,
    };
  },
  computed: {
    toggle() {
      const icon = this.show ? "mdi-eye" : "mdi-eye-off";
      const type = this.show ? "text" : "password";
      return { icon, type };
    },
    storeUser: function() {
      return this.$store.getters.storeUser;
    },
  },
  methods: {
    submitData: function() {
      axios
        .post("/sessions", this.loginInfo)
        .then(() => {
          this.$store.dispatch("getSelf");
          this.$router.push({ name: "HomeIndexPage" });
        })
        .catch((error) => {
          console.error(error.response.data.errors);
          if (error.response.data && error.response.data.errors) {
            this.errors = "メールアドレスかパスワードに誤りがあります";
          }
          console.error("通信エラーです");
        });
    },
  },
};
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
.login-text {
  display: flex;
  justify-content: center;
  line-height: 24px;
}
.text-field {
  font-size: 16px;
}
.login-background {
  background-color: #ffffff;
  padding: 20px;
  height: 100%;
}
.login-button {
  background-color: #1995ad !important;
  max-width: 280px;
  font-size: 16px
}
</style>
