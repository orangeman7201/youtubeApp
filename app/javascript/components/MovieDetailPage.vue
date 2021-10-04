<template>
  <v-app>
    <v-container>

        <v-card  width="93%" class="ma-10 px-10 pb-10 pt-7">

          <v-row> 
            <v-col cols="4" class="d-flex justify-center">
              <v-img :src="movie.thumbnail" :aspect-ratio="4/3" max-width="400px">
                <div bottom class="mt-1 mr-2 black white--text text-right">
                  <span v-if="movie.duration >= 3600">
                    {{Math.floor(movie.duration/3600)}}時間
                  </span>
                  <span v-if="movie.duration >= 60">
                    {{Math.floor(movie.duration/60%60)}}分
                  </span>{{movie.duration%60}}秒
                </div>
              </v-img>
            </v-col>

            <v-col cols="8">
              <div class="ma-2">
                <h4 class="text-h5">{{movie.title}}</h4>
              </div>
                <v-divider></v-divider>
              <v-textarea v-model="movie.comment" outlined>
                {{movie.comment}}
              </v-textarea>
            </v-col>
          </v-row>

          <v-row align="center" justify="center" class="mt-5">
            <v-btn type="submit" class="white--text green accent-3" @click="submitData">保存</v-btn>
          <v-col cols="1">
          </v-col>
          <v-col cols="1">
            <v-btn class="white--text green accent-3" @click="deleteData">削除</v-btn>
          </v-col>
        </v-row>

        </v-card>

    </v-container>
  </v-app>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      movie: {},
      error: ""
    }
  },
  mounted () {
    axios
    .get(`/movies/${this.$route.params.id}.json`)
    .then(response => (this.movie = response.data))
  },
  methods: {
    submitData: function() {
      axios
        .patch(`/movies/${this.$route.params.id}.json`, this.movie)
        .then(response => {
          console.log(response);
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          console.log(error)
          this.error = error
        })
    },
    deleteData: function() {
      if(confirm('削除しますか？')){
        axios
          .delete(`/movies/${this.$route.params.id}.json`, this.movie)
          .then(response => {
            this.$router.push({name: 'HomeIndexPage' })
          })
          .catch(error => {
            console.log(error)
            this.error = error
          })
      }
    }
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>