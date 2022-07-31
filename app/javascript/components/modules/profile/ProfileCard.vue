<template>
  <Card v-if="storeUser">
    <v-alert
      v-model="isVisible"
      close-text="Close Alert"
      dismissible
      dense
      outlined
      type="success"
      text
      transition="scale-transition"
      class="card-alert"
    >保存しました</v-alert>
    <div class="card-header">
      <img src="~user_default.svg" art="" class="mr-4 card-image" />
      <div class="card-user-name">
        <div class="card-user-name-content">{{ storeUser.name }}</div>
        <div class="card-header-user-and-limit">
          <div>ID: {{ storeUser.id }}</div>
          <div>目標: {{ storeUser.limit / 60}}分/日 </div>
        </div>
      </div>
    </div>
  </Card>
</template>

<script>
import Card from "../Card.vue"
import 'user_default.svg'
import axios from 'axios';

export default {
  props: ["post", "index", "isVisible"],
  components: {
    Card
  },
  beforeCreate() {
    this.$store.dispatch('getSelf')
  },
  data () {
    return {
      tortalduration: 90 * 60,
      user: null,
    }
  },
  computed: {
    storeUser: function() {
      return this.$store.getters.storeUser 
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
