<template>
  <div>
    <TimelineFirstPost v-if="isNotTodaysPost"/>
    <TimelineFirstPost v-if="isTodaysPost" :post="post"/>
    <TimelinePost v-else :post="post"/>
  </div>
</template>

<script>
import TimelinePost from "./Post.vue"
import TimelineFirstPost from "./FirstPost.vue"
import moment from 'moment';

export default {
  props: ["post", "index"],
  components: {
    TimelinePost,
    TimelineFirstPost
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
