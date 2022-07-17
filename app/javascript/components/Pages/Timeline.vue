<template>
  <div class="timeline">
    <TimelineHeader />
    <div class="timeline_contents">
      <Card>
        <div>
          <img src="~user_default.svg" art="" >
          <div>
            <div>{{ user.name }}</div>
            <div>{{ today }}</div>
          </div>
          <div>
            <div>ID: {{ user.id }}</div>
            <div>目標: {{ user.limit / 60}}分/日 </div>
          </div>
        </div>
        <div>
          {{ tortalduration / 60 }}分/{{ user.limit / 60 }}分 
        </div>
        <v-textarea
          v-model="post.comment"
          label="コメント"
          outlined
        ></v-textarea>
        <div>
          <button>キャンセル</button>
          <button>投稿</button>
        </div>
      </Card>
    </div>
  </div>
</template>

<script>
import TimelineHeader from "../modules/TimelineHeader.vue"
import Card from "../modules/Card.vue"
import 'user_default.svg'

export default {
  components: {
    TimelineHeader,
    Card
  },
  data () {
    return {
      user:  {
        id: 11,
        name: "test1234",
        email: "test003@test.com",
        limit: 60 * 60,
      },
      tortalduration: 90 * 60,
      post: {
        commnet: "",
      },
    }
  },
  computed: {
    today: function() {
      return new Date();
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
</style>
