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
      isVisible: false,
      movies: [],
      totalCount: 0,
      isMounted: false,
      page: 0,
    }
  },
  computed: {
    isMoreData() {
      return this.totalCount <= this.movies.length
    }
  },
  beforeMount() {
    this.getMovies()
  },
  methods: {
    getMovies() {
      axios
      .get('/movies', {
        params: {
          page: this.page
        }
      })
      .then(response => {
        this.movies.push(...response.data.movies);
        this.totalCount = response.data.total
        this.isMounted = true
        this.page++
      })
      .catch()
    },
  }
}
</script>
