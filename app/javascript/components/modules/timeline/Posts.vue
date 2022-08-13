<template>
  <div>
    <div v-if="posts.length === 0">
      <TimelineCreatePost class="mb-10"/>
    </div>
    <div v-else v-for="(post, index) in posts" :key="post.id">
      <TimelineCreatePost v-if="isNotTodaysPost(post, index)" class="mb-10"/>
      <TimelineEditPost v-if="isTodaysPost(post, index)" :post="post" class="mb-10"/>
      <TimelinePost v-else :post="post" class="mb-10"/>
    </div>
  </div>
</template>

<script>
import TimelinePost from "./Post.vue"
import TimelineCreatePost from "./CreatePost.vue"
import TimelineEditPost from "./EditPost.vue"
import moment from 'moment';

export default {
  props: ["posts"],
  components: {
    TimelinePost,
    TimelineCreatePost,
    TimelineEditPost,
  },
  methods: {
    isTodaysPost: function(post, index) {
      return index === 0 && moment().isSame(post.created_at, 'day');
    },
    isNotTodaysPost: function(post, index) {
      return index === 0 && !moment().isSame(post.created_at, 'day');
    }
  },
}
</script>
