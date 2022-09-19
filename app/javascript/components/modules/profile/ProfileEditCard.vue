<template>
  <div>
    <Card v-if="storeUserLoaded">
      <div class="card-header">
        <label for="edit-profile-image" class="file-input-label">
          <v-icon class="white--text profile-image-edit-icon">mdi-camera</v-icon>
          <img v-if="storeUser.image_url" :src="imageUrl" art="" class="mr-4 card-image" />
          <div v-else class="mr-4 card-image grey lighten-3" />
        </label>
        <input type="file" id="edit-profile-image" accept="image/png,image/jpeg" @change="setImage" class="file-input"/>
        <div class="card-user-profile">
          <v-text-field
            :value="storeUser.name"
            label="ユーザー名"
            required
            counter ="20"
            @change="changeParamsName"
          ></v-text-field>
          <v-select
            :value="storeUser.limit / 60"
            :items="limitArray"
            label="一日の目標時間(分)"
            required
            @change="changeParamsLimit"
          ></v-select>
        </div>
      </div>
    </Card>
  </div>
</template>

<script>
import Card from "../Card.vue"
import 'user_default.svg'

export default {
  components: {
    Card
  },
  data() {
    return {
      previewImageUrl: null,
    }
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    storeUserLoaded: function() {
      return this.$store.getters.storeUserLoaded 
    },
    limitArray: function() {
      return [...Array(20)].map((_, i) => i * 10)
    },
    imageUrl: function() {
      return this.previewImageUrl ? this.previewImageUrl : this.storeUser.image_url
    },
  },
  methods: {
    changeParamsName(event) {
      this.$emit('changeName', event);
    },
    changeParamsLimit(event) {
      this.$emit('changeLimit', event);
    },
    setImage(event) {
      this.$emit('setImage', event);
      const file = event.target.files[0];
      this.previewImageUrl = URL.createObjectURL(file)
    },
  }

}
</script>

<style scoped>
.timeline {
  background-color: #F1F1F2;
}
.timeline_contents {
  padding: 20px;
}
.card-image {
  width: 80px;
  height: 80px;
  border-radius: 50%;
}
.card-header {
  display: flex;
  align-items: center;
  margin: 12px 0 12px;
}
.card-user-name {
  display: flex;
  flex-grow: 1;
  flex-flow: column;
}
.card-user-name-content {
  font-size: 32px;
}
.card-header-user-and-limit {
  display: flex;
  justify-content: end;
  flex-flow: column;
  font-size: 18px;
  margin-left: auto;
}
.file-input {
  display: none;
}
.file-input-label {
  cursor : pointer;
  position: relative;
}
.profile-image-edit-icon {
  position: absolute !important;
  /* 29pxが画像の中心に来てていい感じでした */
  top: 29px;
  left: 29px;
}
</style>
