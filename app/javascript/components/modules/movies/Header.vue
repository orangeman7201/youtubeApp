<template>
  <div class="header">
    <div class="button-group">
      <button class="mr-2" :class="friendMoviesButtonClass" @click="showFriendMovies">
        友達の視聴履歴
      </button>
      <button class="ml-2" :class="myMoviesButtonClass" @click="showMyMovies">
        自分の視聴履歴
      </button>
    </div>
  </div>
</template>

<script>

export default {
  data: function() {
    return {
      selected: 'me'
    }
  },
  mounted() {
    if (this.$route.query.friend) {
      this.selected = 'friend'
    }
  },
  watch: {
    $route(to) {
      if (to.query.friend) {
        this.selected = 'friend'
      }
    }
  },
  computed: {
    myMoviesButtonClass: function() {
      return this.selected === 'me' ? 'showed-movies v-btn--outlined' : 'unshowed-movies'
    },
    friendMoviesButtonClass: function() {
      return this.selected === 'friend' ? 'showed-movies v-btn--outlined' : 'unshowed-movies'
    },
  },
  methods: {
    showFriendMovies: function() {
      this.selected = 'friend'
      this.$router.push({ name: "MovieHistory", query: { friend: true } }, () => {})
      this.$emit('get-movies')
    },
    showMyMovies: function() {
      this.selected = 'me'
      this.$router.push({ name: "MovieHistory" }, () => {})
      this.$emit('get-movies')
    },
  }
}
</script>

<style scoped>
.header {
  width: 100%;
  padding: 16px 0;
  background-color: #A7DDEA;
  font-size: 14px;
  font-weight: 400px;
}
.button-group {
  display: flex;
  margin-bottom: 16px;
  justify-content: center;
}
.unshowed-movies {
  padding: 8px 32px;
  border-radius: 28px;
  border: solid 2.5px #FFFFFF;
  color: #FFFFFF;
}
.showed-movies {
  padding: 8px 32px;
  border-radius: 28px;
  background-color: #FFFFFF;
  color: #18B1CE;
  border: none;
}
</style>
