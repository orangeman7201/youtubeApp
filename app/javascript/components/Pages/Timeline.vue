<template>
  <div class="timeline">
    <TimelineHeader />
    <TimelinePosts class="timeline_contents" v-if="loaded" :posts="posts"/>
  </div>
</template>

<script>
import TimelineHeader from "../modules/timeline/Header.vue"
import TimelinePosts from "../modules/timeline/Posts.vue"
import 'user_default.svg'
import moment from 'moment';
import axios from 'axios';

export default {
  components: {
    TimelineHeader,
    TimelinePosts,
  },
  mounted() {
    this.getPosts()
  },
  data () {
    return {
      loaded: false,
      posts: [],
      user: null,
      tortalduration: 90 * 60,
    }
  },
  computed: {
    today: function() {
      moment.locale("ja");
      return moment(new Date()).format('ll');
    }
  },
  methods: {
    getPosts() {
      axios
      .get('/posts')
      .then(response => {
        this.posts = response.data
        this.loaded = true
      })
      .catch(error => {
        console.log(error)
      })
    },
  }

}
</script>

<style scoped>
.timeline {
  background-color: #F1F1F2;
}
.timeline_contents {
  padding: 20px;
}
.card-header {
  display: flex;
  align-items: center;
  margin: 12px 0 20px; 
}
.card-user-name {
  font-size: 24px;
}
.card-date {
  font-size: 12px;
  color: #BCBABE;
}
.card-header-user-and-limit {
  font-size: 14px;
  color: #BCBABE;
  margin-right: auto;
}
.card-limit {
  display: flex;
  justify-content: center;
  align-content: center;
  margin-bottom: 10px;
}
.card-limit-duration {
  display: flex;
  align-items: center;
  font-size: 36px;
}
.card-limit-limit {
  display: flex;
  align-items: center;
  font-size: 24px;
} 
.card-buttons {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
}
.card-button-cancel{
  color: #FFFFFF !important;
  font-size: 16px !important;
  margin-right: 20px;
}
.card-button-post{
  color: #FFFFFF !important;
  font-size: 20px !important;
  margin-left: 20px;
}
</style>
