<template>
  <div>
    <TimelineCreatePost v-if="isNotTodaysPost" class="mb-10"/>
    <TimelineEditPost v-if="isTodaysPost" :post="post"/>
    <TimelinePost v-else :post="post"/>
  </div>
</template>

<script>
import TimelinePost from "./Post.vue"
import TimelineCreatePost from "./CreatePost.vue"
import TimelineEditPost from "./EditPost.vue"
import moment from 'moment';

export default {
  props: ["post", "index"],
  components: {
    TimelinePost,
    TimelineCreatePost,
    TimelineEditPost,
  },
  computed: {
    isTodaysPost: function() {
      return this.index === 0 && moment().isSame(this.post.created_at, 'day');
    },
    isNotTodaysPost: function() {
      return this.index === 0 && !moment().isSame(this.post.created_at, 'day');
    }
  }
}
</script>
