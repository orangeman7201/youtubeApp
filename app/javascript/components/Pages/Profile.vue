<template>
  <div class="profile">
    <ProfileCard class="mb-2" :isVisible="isVisible"/>
    <v-card class="px-5 py-4 profile-edit-button" width="100%" flat color="#A7DDEA" @click="moveEditPage">
      プロフィールの編集
    </v-card>
  </div>
</template>

<script>
import ProfileCard from "../modules/profile/ProfileCard.vue"

export default {
  components: {
    ProfileCard,
  },
  data () {
    return {
      isVisible: false,
    }
  },
  mounted() {
    this.successState()
  },
  methods: {
    moveEditPage: function() {
      this.$router.push('/profile/edit')
    },
    successState: function() {
      if(this.$route.params.editStatus) {
        this.isVisible = true
        setTimeout(() => {
          this.isVisible = false
        }, 4000)
      }
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
