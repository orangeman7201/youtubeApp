<template>
  <div class="profile">
    <ProfileCard />
  </div>
</template>

<script>
import ProfileCard from "../modules/ProfileCard.vue"
// import moment from 'moment';
// import axios from 'axios';

export default {
  components: {
    ProfileCard
  },
  data () {
    return {
    }
  },
  computed: {
  },
  methods: {
  }

}
</script>

<style scoped>
.profile {
  height: 100%;
  padding: 20px; 
  background-color: #F1F1F2;
}
</style>
