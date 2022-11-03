<template>
  <div> 
    <div  v-for="request in requests" :key="request.id">
      <div>name : {{ request.name }}</div>
      <div>uuid : {{ request.uuid }}</div> 
      <div>image_url : {{ request.image_url }}</div>
      <div>date : {{ request.created_at }}</div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
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
