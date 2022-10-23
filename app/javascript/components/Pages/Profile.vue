<template>
  <div class="profile">
    <ProfileEditCard
      @changeName="changeName"
      @changeUuid="changeUuid"
      @changeLimit="changeLimit"
      @setImage="setImage"
      @submit="submit"
      :isUpdateSuccess="isUpdateSuccess"
      :isUpdateFail="isUpdateFail"
      :isReadyToSubmit="isReadyToSubmit"
      :errorMessage="errorMessage"
    />
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
        uuid: "",
        limit: null,
        image: null,
      },
      isUpdateSuccess: false,
      isUpdateFail: false,
      isUuidDuplicated: false,
      errorMessage: "",
    }
  },
  components: {
    ProfileEditCard,
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    storeUserLoaded: function() {
      return this.$store.getters.storeUserLoaded 
    },
    isReadyToSubmit: function() {
      const params = this.params
      if(params.name === "" && params.uuid === "" && params.limit === null && params.image === null) {
        return false
      }
      if(params.name.length > 16 || this.isUuidDuplicated) {
        return false
      }
      return true
    }
  },
  methods: {
    changeName: function(name) {
      this.params.name = name
    },
    changeUuid: function(uuid) {
      this.params.uuid = uuid
    },
    changeLimit: function(limit) {
      this.params.limit = limit * 60
    },
    setImage: function(image) {
      this.params.image = image.target.files[0]
    },
    async submit() {
      if(this.params.name === "") {
        this.params.name = this.storeUser.name
      }
      if(this.params.uuid === "") {
        this.params.uuid = this.storeUser.uuid
      }
      if(this.params.limit === null) {
        this.params.limit = this.storeUser.limit
      }
      if (this.params.image) {
        const formData = new FormData();
        formData.append("title", "title");
        formData.append("image", this.params.image);
        await axios
        .put(`/users/${this.storeUser.id}/update_image`, formData)
        .catch(error => {
          console.log(error.message)
        })
      }
      axios
      .patch(`/users/${this.storeUser.id}`, {
        name: this.params.name,
        limit: this.params.limit,
        uuid: this.params.uuid
      })
      .then(response => {
        this.$store.dispatch('updateUserStatus', response.data)
        this.isUpdateSuccess = true
        this.paramsReset()
        setTimeout(() => {
          this.isUpdateSuccess = false
        }, 2000)
      })
      .catch(error => {
        this.errorMessage = error.response.data.errors[0]
        this.isUpdateFail = true
        setTimeout(() => {
          this.isUpdateFail = false
        }, 2000)
      })
    },
    paramsReset() {
      this.params = {
        name: "",
        uuid: "",
        limit: null,
        image: null,
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
