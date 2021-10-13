<template>
  <v-app>
    <v-container>

      <v-row>
        <v-col>
          <v-img>

          </v-img>
          <h1>
            ystopperはyoutubeを辞くても辞められない人向けのアプリです。
          </h1>
          <v-btn @click="moveSignupPage">
            新規ユーザー登録
          </v-btn>
          <p router to="/login">
            ログインはこちら
          </p>
        </v-col>
      </v-row>

      <v-row>
        <v-col>

          <v-card>
            <v-row>
              <v-col cols="4">
                <v-card>
                  <h5>ケース1</h5>
                  <h4>休日ごろごろパターン</h4>
                </v-card>
              </v-col>
              <v-col cols="4">
                <v-card>
                  <h5>ケース2</h5>
                  <h4>隙間時間パターン</h4>
                </v-card>
              </v-col>
              <v-col cols="4">
                <v-card>
                  <h5>ケース3</h5>
                  <h4>勉強中パターン</h4>
                </v-card>
              </v-col>
            </v-row>
          </v-card>

        </v-col>
      </v-row>

    </v-container>
  </v-app>  
</template>

<script>

export default {
 mounted() {
   if(this.$store.state.user === 'ok') {
     this.$router.push({name: 'HomeIndexPage' })
   }
  },
  methods: {
    moveSignupPage: function() {
      this.$router.push('/signup')
    }
  }
}
</script>
