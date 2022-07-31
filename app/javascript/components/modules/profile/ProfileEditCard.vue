<template>
  <Card v-if="storeUser">
    <div class="card-header">
      <img src="~user_default.svg" art="" class="mr-4 card-image" />
      <div class="card-user-profile">
        <v-text-field
          :value="storeUser.name"
          label="ユーザー名"
          required
          counter ="20"
        ></v-text-field>
        <v-select
          :value="storeUser.limit"
          :items="limitArray"
          label="一日の目標時間(分)"
          required
        ></v-select>
      </div>
    </div>
  </Card>
</template>

<script>
import Card from "../Card.vue"
import 'user_default.svg'
import axios from 'axios';

export default {
  props: ["post", "index"],
  components: {
    Card
  },
  data () {
    return {
      tortalduration: 90 * 60,
      user: null,
      isVisible: false,
    }
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    limitArray: function() {
      return [...Array(20)].map((_, i) => i * 10)
    },
  },
  methods: {
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
