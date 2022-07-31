<template>
  <div class="profile">
    <ProfileCard class="mb-2"/>
    <v-card class="px-5 py-4 profile-edit-button" width="100%" flat color="#A7DDEA" @click="moveEditPage">
      プロフィールの編集
    </v-card>
  </div>
</template>

<script>
import ProfileCard from "../modules/ProfileCard.vue"

export default {
  components: {
    ProfileCard,
  },
  methods: {
    moveEditPage: function() {
      this.$router.push('/home')
    }
  }

}
</script>

<style scoped>
.profile {
  height: 100%;
  padding: 20px; 
  background-color: #F1F1F2;
}
.profile-edit-button {
  display: flex;
  justify-content: center;
  background-color: #A7DDEA;
  cursor: pointer;
  font-size: 16px;
}
</style>
