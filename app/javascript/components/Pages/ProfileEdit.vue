<template>
  <div class="profile">
    <ProfileEditCard @changeName="changeName" @changeLimit="changeLimit"/>
    <div class="card-buttons">
      <v-btn color="#A7DDEA" width="120px" height="56px" class="card-button-cancel" @click="cancel">キャンセル</v-btn>
      <v-btn color="#18B1CE" width="120px" height="56px" class="card-button-post" @click.prevent="submit">保存</v-btn>
    </div>
  </div>
</template>

<script>
import ProfileEditCard from "../modules/profile/ProfileEditCard.vue"
import axios from 'axios';

export default {
  data () {
    return {
      params: {
        name: "",
        limit: 0,
      }
    }
  },
  components: {
    ProfileEditCard,
  },
  methods: {
    moveEditPage: function() {
      this.$router.push('/home')
    },
    changeName: function(name) {
      this.params.name = name
    },
    changeLimit: function(limit) {
      this.params.limit = limit
    },
    cancel() {
      if(confirm('内容は保存されませんが、よろしいでしょうか？')){
        this.$router.push('/profile')
      }
    },
    submit() {
      axios
      .patch(`/posts/${this.post.id}`, {
        comment: this.post.comment
      })
      .then(() => {
        this.isVisible = true
        setTimeout(() => {
          this.isVisible = false
        }, 4000)
      })
      .catch(error => {
        console.log(error)
      })
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
.card-buttons {
  display: flex;
  justify-content: center;
  margin-top: 20px;
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
