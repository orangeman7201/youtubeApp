<template>
  <Card v-if="loaded">
    <div class="card-header">
      <img src="~user_default.svg" art="" class="mr-4 card-image" />
      <div class="card-user-profile">
        <input class="card-user-name-content">{{ user.name }}</div>
        <div class="card-header-user-and-limit">
          <div>ID: {{ user.id }}</div>
          <div>目標: {{ user.limit / 60}}分/日 </div>
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
  props: ["post", "index"],
  components: {
    Card
  },
  data () {
    return {
      loaded: false,
      tortalduration: 90 * 60,
      user: null,
      isVisible: false,
    }
  },
  mounted() {
    this.getSelf()
  },
  methods: {
    getSelf() {
      axios
      .get('/self')
      .then(response => {
        this.user = response.data
        this.loaded = true
      })
      .catch(error => {
        console.log(error)
      })
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
