<template>
  <div>
    <MovieHistory />
  </div>
</template>

<script>
import MovieHistory from "../modules/MovieHistory.vue"

export default {
  components: {
    MovieHistory,
  },
  data () {
    return {
      isVisible: false,
    }
  },
  methods: {
    moveEditPage: function() {
      this.$router.push('/profile/edit')
    },
  }
}
</script>
