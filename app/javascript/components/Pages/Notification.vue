<template>
  <div class="pa-5 home-backgound">
    <div v-if="requests.length === 0">通知がありません</div>
    <Card v-else>
      <div  v-for="request in requests" :key="request.id">
        <FriendRequest :request="request" @getRequests="getRequests"/>
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
      isRequestProcessSuccess: false
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