<template>
  <div>
    <Card v-if="storeUserLoaded">
      <div class="card-header">
        <img :src="imageUrl" art="" class="mr-4 card-image" />
        <div class="card-user-profile">
          <input type="file" id="image" name="image" accept="image/png,image/jpeg" @change="setImage" />
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
  data () {
    return {
      user: null,
      isVisible: false,
      imageFile: null,
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
    imageUrl: function () {
      return this.storeUser?.image_url ? this.storeUser.imageUrl : "/packs/media/images/user_default.svg"
    }
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
</style>
