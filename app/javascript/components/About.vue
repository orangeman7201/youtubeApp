<template>
  <v-app>
    <v-container>

      <v-row>
        <v-col>
          <v-img src="@/assets/foreignWoman.jpg">
            <v-row align="center" justify="center">
              <v-col align="center">
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
          </v-img>
        </v-col>
      </v-row>

      <v-row>
        <v-col>

          <v-card class="green accent-3 pa-3">
            <v-row>
              <v-col cols="4">
                <v-card class="pa-2">
                  <h5>ケース1</h5>
                  <v-row align="center" justify="center">
                    <v-col align="center">
                      <v-img height="30%" width="30%" src="@/assets/daradara.png"></v-img>
                    </v-col>
                  </v-row>
                  <h4>休日ごろごろパターン</h4>
                  <h5 class="pt-2">
                    休日何もやることがないとき、youtubeを見て過ごす。ふとした瞬間に時計を見るともうすでに夕方。
                  </h5>
                </v-card>
              </v-col>
              <v-col cols="4">
                <v-card class="pa-2">
                  <h5>ケース2</h5>
                  <v-row align="center" justify="center">
                    <v-col align="center">
                      <v-img height="30%" width="30%" src="@/assets/densha.png"></v-img>
                    </v-col>
                  </v-row>
                  <h4>隙間時間パターン</h4>
                  <h5 class="pt-2">
                    鞄にビジネス本を入れて早3か月。最初の3日以外の通勤時間はずっとyoutubeを見ている。
                  </h5>
                </v-card>
              </v-col>
              <v-col cols="4">
                <v-card class="pa-2">
                  <h5>ケース3</h5>
                  <v-row align="center" justify="center">
                    <v-col align="center">
                      <v-img height="30%" width="30%" src="@/assets/study.png"></v-img>
                    </v-col>
                  </v-row>
                  <h4>勉強中パターン</h4>
                  <h5 class="pt-2">
                    勉強の合間にyoutubeを見る。気が付けば2時間くらい平気で過ぎている。
                  </h5>
                </v-card>
              </v-col>
            </v-row>


            <v-row align="center">
              <v-col align="center">
                ↓
              </v-col>
            </v-row>


            <v-row>
              <v-col cols="4">
                <v-card class="pa-2">
                  <v-row align="center" justify="center">
                    <v-col align="center">
                      <v-img height="30%" width="30%" src="@/assets/tennis.png"></v-img>
                    </v-col>
                  </v-row>
                  <h5 class="pt-2">
                    長年時間がないと遠ざけていた趣味を再開する余裕ができるようになります。
                  </h5>
                </v-card>
              </v-col>
              <v-col cols="4">
                <v-card class="pa-2">
                  <v-row align="center" justify="center">
                    <v-col align="center">
                      <v-img height="30%" width="30%" src="@/assets/reading.png"></v-img>
                    </v-col>
                  </v-row>
                  <h5 class="pt-2">
                    無駄にしていた隙間時間を人生を前進させるために使えるようになります。
                  </h5>
                </v-card>
              </v-col>
              <v-col cols="4">
                <v-card class="pa-2">
                  <v-row align="center" justify="center">
                    <v-col align="center">
                      <v-img height="30%" width="30%" src="@/assets/studyhard.png"></v-img>
                    </v-col>
                  </v-row>
                  <h5 class="pt-2">
                    集中力が上がる！！
                  </h5>
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