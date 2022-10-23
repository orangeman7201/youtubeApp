<template>
  <Card>
    <div class="card-header">
      <img src="~user_default.svg" art="" class="mr-4" />
      <div class="mr-8">
        <div class="card-user-name">{{ post.user.name }}</div>
        <div class="card-date">{{ today }}</div>
      </div>
      <div class="card-header-user-and-limit">
        <div>ID: {{ post.user.id }}</div>
        <div>目標: {{ post.user.limit / 60}}分/日 </div>
      </div>
    </div>
    <div class="card-limit">
      <span class="card-limit-duration">{{ Math.floor(post.duration) / 60 }}分</span>
      <span class="card-limit-limit">/{{ post.user.limit / 60 }}分 </span>
    </div>
    <v-textarea
      v-model="post.comment"
      label="コメント"
      outlined
      class="mb-4"
      disabled
    ></v-textarea>
  </Card>
</template>

<script>
import Card from "../Card.vue"
import 'user_default.svg'
import moment from 'moment';

export default {
  props: ["post", "index"],
  components: {
    Card
  },
  computed: {
    today: function() {
      moment.locale("ja");
      return moment(this.post.created_at).format('ll');
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
