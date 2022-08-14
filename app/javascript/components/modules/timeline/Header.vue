<template>
  <div class="header">
    <div class="button-group">
      <button class="mr-2" :class="friendPostsButtonClass" @click="showFriendPosts">
        友達の投稿
      </button>
      <button class="ml-2" :class="myPostsButtonClass" @click="showMyPosts">
        自分の投稿
      </button>
    </div>
  </div>
</template>

<script>

export default {
  data: function() {
    return {
      user: {},
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
    myPostsButtonClass: function() {
      return this.selected === 'me' ? 'showed-posts v-btn--outlined' : 'unshowed-posts'
    },
    friendPostsButtonClass: function() {
      return this.selected === 'friend' ? 'showed-posts v-btn--outlined' : 'unshowed-posts'
    },
  },
  methods: {
    showFriendPosts: function() {
      this.selected = 'friend'
      this.$router.push({ name: "Timeline", query: { friend: true } }, () => {})
      this.$emit('get-posts')
    },
    showMyPosts: function() {
      this.selected = 'me'
      this.$router.push({ name: "Timeline" }, () => {})
      this.$emit('get-posts')
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
  justify-content: center;
}
.unshowed-posts {
  padding: 8px 32px;
  border-radius: 28px;
  border: solid 2.5px #FFFFFF;
  color: #FFFFFF;
}
.showed-posts {
  padding: 8px 32px;
  border-radius: 28px;
  background-color: #FFFFFF;
  color: #18B1CE;
  border: none;
}
</style>
