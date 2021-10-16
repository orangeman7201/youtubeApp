<template>
  <v-app>
    <v-app-bar
      app
      color="white"
      height="100"
    >
      <v-avatar
        class="mr-3"
        color="grey lighten-5"
        size="70"
      >
        <v-img
          contain
          max-height="70%"
          src="https://cdn.vuetifyjs.com/images/logos/vuetify-logo-dark.png"
        ></v-img>
      </v-avatar>

      <v-toolbar-title class="font-weight-black headline">
        YSTOPPER
      </v-toolbar-title>
    </v-app-bar>

      
      <section id="hero">
        <v-row no-gutters>
          <v-img
            src="https://images.unsplash.com/photo-1487017159836-4e23ece2e4cf?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1951&q=80"
          >
            <v-theme-provider dark>
              <v-container fill-height>
                <v-row
                  align="center"
                  class="white--text mx-auto"
                  justify="center"
                >
                  <v-col
                    class="white--text text-center"
                    cols="12"
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

                  <v-btn
                    class="align-self-end"
                    fab
                    outlined
                    @click="$vuetify.goTo('#about-me')"
                  >
                    <v-icon>mdi-chevron-double-down</v-icon>
                  </v-btn>
                </v-row>
              </v-container>
            </v-theme-provider>
          </v-img>
        </v-row>
      </section>

      <section id="about-me">
        <div class="py-12"></div>

        <v-container class="text-center">
          <h2 class="display-2 font-weight-bold mb-3">ABOUT ME</h2>
          <v-responsive class="mx-auto mb-8" width="56">
            <v-divider class="mb-1"></v-divider>
            <v-divider></v-divider>
          </v-responsive>

          <v-responsive class="mx-auto title font-weight-light mb-8" max-width="720">
            Vuetify is the #1 component library for Vue.js and has been in active development since 2016. The goal of the project is to provide users with everything that is needed to build rich and engaging web applications using the Material Design specification. It accomplishes that with a consistent update cycle, Long-term Support (LTS) for previous versions, responsive community engagement, a vast ecosystem of resources and a dedication to quality components.     
          </v-responsive>

          <v-avatar
            class="elevation-12 mb-12"
            size="128"
          >
            <v-img src="https://cdn.vuetifyjs.com/images/john.png"></v-img>
          </v-avatar>

          <div></div>

          <v-btn
            color="grey"
            href="https://vuetifyjs.com"  
            outlined
            large        
          >
            <span class="grey--text text--darken-1 font-weight-bold">
              Vuetify Documentation
            </span>
          </v-btn>
        </v-container>

        <div class="py-12"></div>
      </section>

      <section
        id="features"
        class="grey lighten-3"
      >
        <div class="py-12"></div>

        <v-container class="text-center">
          <h2 class="display-2 font-weight-bold mb-3">YSOTPPER FEATURES</h2>

          <v-responsive
            class="mx-auto mb-12"
            width="56"
          >
            <v-divider class="mb-1"></v-divider>

            <v-divider></v-divider>
          </v-responsive>

          <v-row>
            <v-col
              v-for="({ icon, title, text }, i) in features"
              :key="i"
              cols="12"
              md="4"
            >
              <v-card
                class="py-12 px-4"
                color="grey lighten-5"
                flat
              >
                <v-theme-provider dark>
                  <div>
                    <v-avatar
                      color="primary"
                      size="88"
                    >
                      <v-icon
                        large
                        v-text="icon"
                      ></v-icon>
                    </v-avatar>
                  </div>
                </v-theme-provider>

                 <v-card-title
                  class="justify-center font-weight-black text-uppercase"
                  v-text="title"
                 ></v-card-title>

                <v-card-text
                  class="subtitle-1"
                  v-text="text"
                ></v-card-text>
              </v-card>
            </v-col>
          </v-row>
        </v-container>

        <div class="py-12"></div>
      </section>

      <section id="stats">
        <v-parallax
          :height="$vuetify.breakpoint.smAndDown ? 700 : 500"
           src="https://images.unsplash.com/photo-1510915228340-29c85a43dcfe?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1950&q=80"
        >
        
          <v-container fill-height>
            <v-row class="mx-auto">
              <v-col
                v-for="[value, title] of stats"
                :key="title"
                cols="12"
                md="3"
              >
                <div class="text-center">
                  <div
                    class="display-3 font-weight-black mb-4"
                    v-text="value"
                  ></div>

                  <div
                    class="title font-weight-regular text-uppercase"
                    v-text="title"
                  ></div>
                </div>
              </v-col>
            </v-row>
          </v-container>
        </v-parallax>

        <div class="py-12"></div>
      </section>

      <section id="blog">
        <v-container>
          <h2 class="display-2 font-weight-black mb-3 text-uppercase text-center">Blog</h2>

          <v-responsive
            class="mx-auto mb-12"
            width="56"
          >
            <v-divider class="mb-1"></v-divider>
            <v-divider></v-divider>
          </v-responsive>
          <v-row>
            <v-col
              v-for="({src, title, text}, i) in articles"
              :key="i"
              cols="12"
              md="4"
            >
              <v-img
                :src="src"
                class="mb-4"
                height="275"
                max-width="100%"
              ></v-img>

              <h3
                class="font-weight-black text-uppercase mb-3"
                v-text="title"
              ></h3>

              <h3
                class="title font-weight-light mb-5"
                v-text="text"
              ></h3>

              <v-btn
                class="ml-n4 font-weight-black"
                text
              >
                continue reading
              </v-btn>
            </v-col>
          </v-row>
        </v-container>
      </section>






        <v-responsive class="mx-auto title font-weight-light mb-8" max-width="720">
        <h1>
          ystopperはyoutubeを辞くても辞められない人向けのアプリです。
        </h1>
        </v-responsive>
        <v-responsive class="mx-auto title font-weight-light mb-8" max-width="720">
          <v-btn @click="moveSignupPage">
            新規ユーザー登録
          </v-btn>
        </v-responsive>
        <v-responsive class="mx-auto title font-weight-light mb-8" max-width="720">
          <p router to="/login">
            ログインはこちら
          </p>
        </v-responsive>

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

      <v-row>
        <v-col class="green accent-3 pa-10">
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


        </v-col>
      </v-row>

  </v-app>  
</template>

<script>

export default {
  data () {
    return {
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