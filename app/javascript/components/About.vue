<template>
  <v-app>
    <v-app-bar
      app
      dark
      flat
      color="green accent-2"
      height="70"
    >
      <v-avatar
        class="mr-3"
        color="grey lighten-5"
        size="50"
      >
        <v-img
          contain
          max-height="70%"
          src="@/assets/logo.png"
        ></v-img>
      </v-avatar>

      <v-toolbar-title class="font-weight-medium headline">
        YSTOPPER
      </v-toolbar-title>
      <v-spacer></v-spacer>
        <v-btn
          text
          class="mr-3"
        >
          ログイン
        </v-btn>
        <v-btn
          dark
          class="mr-3 orange lighten-1"
        >
          新規登録
        </v-btn>
    </v-app-bar>

      
      <section id="hero">
        <v-row
          fill-height
          align="center"
          class="green accent-2 white--text mx-auto"
          justify="center"
        >
          <v-col
            class="white--text text-center"
            cols="6"
            tag="h1"
          >
            <span
            :class="[$vuetify.breakpoint.smAndDown ? 'display-1' : 'display-2']"
              class="font-weight-light"
            >
              WELCOME TO
            </span>

            <br>

            <span
              :class="[$vuetify.breakpoint.smAndDown ? 'display-3': 'display-4']"
              class="font-weight-black"
            >
              YSTOPPER
            </span>

          </v-col>
          <v-col
            cols="6"
          >
            <v-card class="pa-5 ma-5">
              <v-form @submit.prevent="submitData" class="ma-5"> 
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
                    <v-btn type="submit" class="white--text green accent-2">はじめる</v-btn>
                  </v-col>
                </v-row>
              </v-form>
              <v-divider></v-divider>
              <v-row justify="center" align="center">
                <v-col align="center">
                  <p class="grey--text d-flex justify-center my-7">すでにアカウントをお持ちの場合</p>
                  <v-btn type="submit" class="white--text green accent-2">ログイン</v-btn>
                </v-col>
              </v-row>
            </v-card>

          </v-col>
        </v-row>
      </section>

      <!-- <section id="about-me">
        <div class="py-12"></div>

        <v-container class="text-center grey--text text--darken-3">
          <h2 class="display-2 font-weight-bold mb-3">YSOTPPERとは</h2>
          <v-responsive class="mx-auto mb-8" width="56">
            <v-divider class="mb-1"></v-divider>
            <v-divider></v-divider>
          </v-responsive>

          <v-responsive class="mx-auto title font-weight-light mb-8" max-width="720">
            YSOTPPERとはyoutubeの見過ぎを抑えるアプリです。
          </v-responsive>
        </v-container>

        <v-container class="text-center grey--text text--darken-3">
          <h2 class="display-2 font-weight-bold mb-3">使用例</h2>
          <v-responsive class="mx-auto mb-8" width="56">
            <v-divider class="mb-1"></v-divider>
            <v-divider></v-divider>
          </v-responsive>
        </v-container>

         <v-row>
            <v-col class="green accent-2 pa-10">
            <v-row>
              <v-col cols="4">
                <v-card class="pa-2 grey--text text--darken-3">
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
                <v-card class="pa-2 grey--text text--darken-3">
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
                <v-card class="pa-2 grey--text text--darken-3">
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
              <v-col cols="4" align="center">
                ↓
              </v-col>
              <v-col cols="4" align="center">
                ↓
              </v-col>
              <v-col cols="4" align="center">
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
            </v-col>
          </v-row>
        <div class="py-12"></div>
      </section> -->
<!-- 


      <section id="howtouse">
        <div class="py-12"></div>

        <v-container class="text-center grey--text text--darken-3">
          <h2 class="display-2 font-weight-bold mb-3">使用方法</h2>
          <v-responsive class="mx-auto mb-8" width="56">
            <v-divider class="mb-1"></v-divider>
            <v-divider></v-divider>
          </v-responsive>
        </v-container>
      </section>



      <section id="start">
        <div class="py-12"></div>

        <v-container fill-height class="text-center grey--text text--darken-3 pa-5">
          <v-row align="center">
            <v-col>
              <h2 class="display-2 font-weight-bold mb-3">さっそくはじめよう</h2>
              <v-btn
                dark
                class="ma-5 orange lighten-1"
              >
                新規登録
              </v-btn>
            </v-col>
          </v-row>

        </v-container>
      </section> -->
     

  </v-app>  
</template>

<script>

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
      articles: [
          {
            src: 'https://images.unsplash.com/photo-1423784346385-c1d4dac9893a?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80',
            title: 'Mobile first & Responsive',
            text: 'Phasellus lorem enim, luctus ut velit eget, convallis egestas eros. Sed ornare ligula eget tortor tempor, quis porta tellus dictum.',
          },
          {
            src: 'https://images.unsplash.com/photo-1475938476802-32a7e851dad1?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80',
            title: 'Think outside the box',
            text: 'Nam ut leo ipsum. Maecenas pretium aliquam feugiat. Aenean vel tempor est, vitae tincidunt risus. Sed sodales vestibulum nibh.',
          },
          {
            src: 'https://images.unsplash.com/photo-1416339442236-8ceb164046f8?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1892&q=80',
            title: 'Small changes, big difference',
            text: 'Vestibulum in dictum velit, in rhoncus nibh. Maecenas neque libero, interdum a dignissim in, aliquet vitae lectus. Phasellus lorem enim, luctus ut velit eget.',
          },
        ],
        features: [
          {
            icon: 'mdi-account-group-outline',
            title: 'Vibrant Community',
            text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto cupiditate sint possimus quidem atque harum excepturi nemo velit tempora! Enim inventore fuga, qui ipsum eveniet facilis obcaecati corrupti asperiores nam',
          },
          {
            icon: 'mdi-update',
            title: 'Frequent Updates',
            text: 'Sed ut elementum justo. Suspendisse non justo enim. Vestibulum cursus mauris dui, a luctus ex blandit. Lorem ipsum dolor sit amet consectetur adipisicing elit. qui ipsum eveniet facilis obcaecati corrupti consectetur adipisicing elit.',
          },
          {
            icon: 'mdi-shield-outline',
            title: 'Long-term Support',
            text: 'Lorem ipsum dolor sit amet consectetur adipisicing elit. Iusto cupiditate sint possimus quidem atque harum excepturi nemo velit tempora! Enim inventore fuga, qui ipsum eveniet facilis obcaecati corrupti asperiores nam',
          },
        ],
        stats: [
          ['24k', 'Github Stars'],
          ['330+', 'Releases'],
          ['1m', 'Downloads/mo'],
          ['5m', 'Total Downloads'],
        ],
    }
  },
  computed: {
    toggle () {
      const icon = this.show ? 'mdi-eye' : 'mdi-eye-off'
      const type = this.show ? 'text' : 'password'
      return { icon, type }
    }
  },
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