<template>
  <Card v-if="isShowCreatedCard">
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
    >投稿完了しました</v-alert>
    <div class="card-header">
      <img src="~user_default.svg" art="" class="mr-4" />
      <div class="mr-8">
        <div class="card-user-name">{{ storeUser.name }}</div>
        <div class="card-date">{{ today }}</div>
      </div>
      <div class="card-header-user-and-limit">
        <div>ID: {{ storeUser.id }}</div>
        <div>目標: {{ storeUser.limit / 60}}分/日 </div>
      </div>
    </div>
    <div class="card-limit">
      <span class="card-limit-duration">{{  Math.floor(totalDuration) / 60 }}分</span>
      <span class="card-limit-limit">/{{ storeUser.limit / 60 }}分 </span>
    </div>
    <v-textarea
      v-model="comment"
      label="コメント"
      outlined
      class="mb-4"
    ></v-textarea>
    <div class="card-buttons">
      <v-btn color="#A7DDEA" width="120px" height="56px" class="card-button-cancel" @click="cancel">キャンセル</v-btn>
      <v-btn color="#18B1CE" width="120px" height="56px" class="card-button-post" @click.prevent="submit">投稿</v-btn>
    </div>
  </Card>
</template>

<script>
import Card from "../Card.vue"
import 'user_default.svg'
import moment from 'moment';
import axios from 'axios';

export default {
  components: {
    Card
  },
  data () {
    return {
      loaded: false,
      comment: "",
      isVisible: false,
    }
  },
  computed: {
    today: function() {
      moment.locale("ja");
      return moment(new Date()).format('ll');
    },
    storeUser: function() {
      return this.$store.getters.storeUser 
    },
    totalDuration: function() {
      return this.$store.getters.totalDuration
    },
    isShowCreatedCard: function() {
      return !(this.$route.query.friend)
    }
  },
  methods: {
    submit() {
      axios
      .post('/api/v1/posts', { comment: this.comment})
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
    cancel() {
      console.log(111)
    }
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
.card-header {
  display: flex;
  align-items: center;
  margin: 12px 0 20px; 
}
.card-user-name {
  font-size: 24px;
}
.card-date {
  font-size: 12px;
  color: #BCBABE;
}
.card-header-user-and-limit {
  font-size: 14px;
  color: #BCBABE;
  margin-left: auto;
}
.card-limit {
  display: flex;
  justify-content: center;
  align-content: center;
  margin-bottom: 10px;
}
.card-limit-duration {
  display: flex;
  align-items: center;
  font-size: 36px;
}
.card-limit-limit {
  display: flex;
  align-items: center;
  font-size: 24px;
} 
.card-buttons {
  display: flex;
  justify-content: center;
  margin-bottom: 20px;
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
