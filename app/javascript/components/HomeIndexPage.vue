<template>
  <v-app id="app">
    <v-container id="typography-view" fluid tag="section" class="grey lighten-3">

      <v-row align="center" justify="center" class="display-4 my-5 pa-5">
        <v-card class="pa-5">
          <p class="display-1 mb-7">合計視聴時間</p>
          <span v-if="totalDuration >= 3600">
            {{Math.floor(totalDuration/3600)}}時間
          </span>
          <span v-if="totalDuration >= 60">
            {{Math.floor(totalDuration/60%60)}}分
          </span>{{totalDuration%60}}秒
        </v-card>
      </v-row>
      
      <v-card class="mx-10 pa-5">
        <v-row align="center" justify="end">
          <v-col cols="1" >
            <v-btn fab class="green accent-3 white--text">
              <v-icon class="display-3">mdi-plus</v-icon>
            </v-btn>
              <span class="display-2">追加</span>
          </v-col>
        </v-row>
        <!-- <router-link to="/movies/new" >新しい動画を追加</router-link> -->

        <v-card v-for="movie in storeMovies" :key="movie.id" width="97%" class="ma-10 pa-15" elevation="7">
          <v-row> 

            <v-col cols="4" class="d-flex justify-center">
              <v-img :src="movie.thumbnail" :aspect-ratio="4/3">
                <v-row align="end" justify="end">
                  <v-col cols="3" class="black white--text headline d-flex justify-center">
                    <span v-if="movie.duration >= 3600">
                      {{Math.floor(movie.duration/3600)}}時間
                    </span>
                    <span v-if="movie.duration >= 60">
                      {{Math.floor(movie.duration/60%60)}}分
                    </span>{{movie.duration%60}}秒
                  </v-col>
                </v-row>
              </v-img>
            </v-col>

            <v-col cols="8" class="display-2">
              <div class="ma-2">
                <h4>{{movie.title}}
                  <span class="headline" >1時間前</span>
                </h4>
              </div>
                <v-divider></v-divider>
              <div class="ma-3">
                <p>{{movie.comment}}</p>
              </div>
            </v-col>

          </v-row>
        </v-card>

      </v-card>
      <button @click="check"></button>
    </v-container>
  </v-app>
</template>

<script>
  // import { mdiPlusCircle } from '@mdi/js';

export default {
  data: function () {
    return {
      storeMovies: [
    {
        "id": 9,
        "url": "https://www.youtube.com/watch?v=2F1c3colJ7k",
        "duration": 528,
        "title": "新入生歓迎会に無関係の人間がガチで潜入してみた",
        "comment": "おもしろかった4",
        "date": null,
        "thumbnail": "https://i.ytimg.com/vi/2F1c3colJ7k/sddefault.jpg",
        "created_at": "2021-09-27T17:02:49.948Z",
        "updated_at": "2021-09-27T17:02:49.948Z",
        "user_id": 3
    },
    {
        "id": 12,
        "url": "https://www.youtube.com/watch?v=PN0ohcyn5sA",
        "duration": 28948,
        "title": "4K 焚き火のパチパチ音と湧き水のちょろちょろ音８時間 “ Bonfire and spring water”",
        "comment": "おもしろかった4",
        "date": null,
        "thumbnail": "https://i.ytimg.com/vi/PN0ohcyn5sA/sddefault.jpg",
        "created_at": "2021-09-29T04:20:04.298Z",
        "updated_at": "2021-09-29T04:20:04.298Z",
        "user_id": 3
    },
    {
        "id": 13,
        "url": "https://www.youtube.com/watch?v=2F1c3colJ7k",
        "duration": 528,
        "title": "新入生歓迎会に無関係の人間がガチで潜入してみた",
        "comment": "おもしろかったおもしろかったおもしろかったおもしろかったおもしろかったおもしろかったおもしろかったおもしろかったおもしろかったおもしろかった",
        "date": null,
        "thumbnail": "https://i.ytimg.com/vi/2F1c3colJ7k/sddefault.jpg",
        "created_at": "2021-09-29T07:09:00.158Z",
        "updated_at": "2021-09-29T07:09:20.182Z",
        "user_id": 3
    }
]
    }
  },
  computed: {
    totalDuration: function() {
      let sum = 72010;
      return sum;
    },
  },
  methods: {
    check: function() {
      console.log(this.storeMovies)
    }
  }
  
}
</script>
