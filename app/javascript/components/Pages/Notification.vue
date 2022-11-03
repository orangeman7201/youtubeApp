<template>
  <div class="pa-5 home-backgound">
    <Card>
      <div  v-for="request in requests" :key="request.id">
        <FriendRequest :request="request" />
      </div>
    </Card>
  </div>
</template>

<script>
import FriendRequest from '../modules/FriendRequest.vue';
import axios from 'axios';
import Card from '../modules/Card.vue'

export default {
  components: {
    FriendRequest,
    Card
  },
  data () {
    return {
      requests: [],
    }
  },
  mounted() {
    this.getRequests();
  },
  computed: {
  },
  methods: {
    getRequests: function() {
      axios
        .get(`/requests.json`)
        .then(response => (this.requests = response.data))
    },
    accept: function(request) {
      axios
        .post('/friends', request)
        .then(response => {
          this.$router.push({name: 'HomeIndexPage' })
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
          console.error('通信エラーです');
        })
    },
  }
}
</script>

<style scoped>
  .home-backgound {
    display: block;
    background-color: #F1F1F1;
    height: 100%;
  }
</style>