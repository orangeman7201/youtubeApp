<template>
  <div class="profile">
    <ProfileEditCard />
  </div>
</template>

<script>
import ProfileEditCard from "../modules/profile/ProfileEditCard.vue"

export default {
  components: {
    ProfileEditCard,
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
