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
  beforeCreate() {
    this.$store.dispatch('getSelf')
  },
  components: {
    ProfileEditCard,
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
  },
  methods: {
    changeName: function(name) {
      this.params.name = name
    },
    changeLimit: function(limit) {
      this.params.limit = limit * 60
    },
    cancel() {
      if(confirm('内容は保存されませんが、よろしいでしょうか？')){
        this.$router.push('/profile')
      }
    },
    submit() {
      if(this.params.name === "") {
        this.params.name = this.storeUser.name
      }
      axios
      .patch(`/users/${this.storeUser.id}`, this.params)
      .then(() => {
        this.$store.dispatch('getSelf');
        this.$router.push( { name: 'Profile', params: { editStatus: 'success' } })
      })
      .catch(error => {
        console.log(error.message)
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
