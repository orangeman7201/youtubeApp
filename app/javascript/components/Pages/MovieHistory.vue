<template>
  <div>
    <MovieHistory :movies="movies" :is-more-data="isMoreData" :is-mounted="isMounted" @get-movie="getMovie"/>
  </div>
</template>

<script>
import MovieHistory from "../modules/MovieHistory.vue"
import axios from 'axios';

export default {
  components: {
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
    this.getMovie()
  },
  methods: {
    getMovie() {
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
