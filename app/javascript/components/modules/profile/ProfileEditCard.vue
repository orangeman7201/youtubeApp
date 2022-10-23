<template>
  <div>
    <Card v-if="storeUserLoaded">
      <div class="card-contents">
        <v-alert
          v-model="isUpdateSuccess"
          close-text="Close Alert"
          dismissible
          dense
          outlined
          type="success"
          text
          transition="scale-transition"
          class="card-alert"
        >更新しました</v-alert>
        <v-alert
          v-model="isUpdateFail"
          close-text="Close Alert"
          dismissible
          dense
          outlined
          type="error"
          text
          transition="scale-transition"
          class="card-alert"
        >更新が失敗しました</v-alert>
        <label for="edit-profile-image" class="file-input-label">
          <img v-if="storeUser.image_url" :src="imageUrl" art="" class="card-image" />
          <div v-else class="mr-4 card-image grey lighten-3" />
        </label>
        <input type="file" id="edit-profile-image" accept="image/png,image/jpeg" @change="setImage" class="file-input"/>
        <div class="card-user-profile">
          <v-text-field
            :value="storeUser.name"
            label="ユーザーネーム"
            required
            counter ="8"
            @change="changeParamsName"
          ></v-text-field>
          <v-text-field
            :value="storeUser.uuid"
            label="ユーザーID"
            required
            @change="changeParamsUuid"
          ></v-text-field>
          <v-select
            :value="storeUser.limit / 60"
            :items="limitArray"
            label="一日の目標時間(分)"
            required
            @change="changeParamsLimit"
          ></v-select>
        </div>
        <ButtonBase color="#E8730E" @click.native="submit">保存</ButtonBase>
      </div>
    </Card>
  </div>
</template>

<script>
import Card from "../Card.vue"
import 'user_default.svg'
import ButtonBase from "../../modules/ButtonBase.vue"

export default {
  components: { Card, ButtonBase },
  props: ["isUpdateSuccess", "isUpdateFail"],
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
    changeParamsUuid(event) {
      this.$emit('changeUuid', event);
    },
    changeParamsLimit(event) {
      this.$emit('changeLimit', event);
    },
    setImage(event) {
      this.$emit('setImage', event);
      const file = event.target.files[0];
      this.previewImageUrl = URL.createObjectURL(file)
    },
    submit() {
      this.$emit('submit');
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
.card-contents {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-flow: column;
}
.card-image {
  width: 75px;
  height: 75px;
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
</style>
