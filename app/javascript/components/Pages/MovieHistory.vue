<template>
  <div>
    <MoviesHeader @get-movies="getMovies"/>
    <MovieHistory :movies="movies" :is-more-data="isMoreData" :is-mounted="isMounted" @get-movies="getMovies"/>
  </div>
</template>

<script>
import MoviesHeader from "../modules/movies/Header.vue"
import MovieHistory from "../modules/MovieHistory.vue"
import axios from 'axios';

export default {
  components: {
    MoviesHeader,
    MovieHistory,
  },
  data () {
    return {
      myMovies: [],
      myPage: 0,
      myTotalCount: 0,
      friendMovies: [],
      friendPage: 0,
      friendTotalCount: 0,
      isMounted: false,
    }
  },
  beforeMount() {
    this.getMovies()
  },
  computed: {
    isMoreData() {
      return this.isFriend ?  this.friendTotalCount <= this.friendMovies.length : this.myTotalCount <= this.myMovies.length
    },
    isFriend() {
      return this.$route.query.friend !== undefined
    },
    movies() {
      return this.isFriend ? this.friendMovies : this.myMovies
    },
  },
  methods: {
    getMovies() {
      axios
      .get('/movies', {
        params: {
          page: this.isFriend ? this.friendPage : this.myPage,
          friend: this.isFriend
        }
      })
      .then(response => {
        if (this.isFriend) {
          this.friendMovies.push(...response.data.movies);
          this.friendPage++
          this.friendTotalCount = response.data.total
        } else {
          this.myMovies.push(...response.data.movies);
          this.myPage++
          this.myTotalCount = response.data.total
        }
        this.isMounted = true
      })
      .catch()
    },
  }
}
</script>
