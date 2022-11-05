<template>
  <div>
    <v-alert
      v-model="isAcceptSuccess"
      close-text="Close Alert"
      dismissible
      dense
      outlined
      type="success"
      text
      transition="scale-transition"
      width="100%"
      class="card-alert"
    >リクエストを承認しました</v-alert>
    <v-alert
      v-model="isRejectSuccess"
      close-text="Close Alert"
      dismissible
      dense
      outlined
      type="success"
      text
      transition="scale-transition"
      width="100%"
      class="card-alert"
    >リクエストを拒否しました</v-alert>
    <v-alert
      v-model="isError"
      close-text="Close Alert"
      dismissible
      dense
      outlined
      type="error"
      text
      transition="scale-transition"
      width="100%"
      class="card-alert"
    >エラーが発生しました</v-alert>
    <div class="mb-3">
      <div class="date-text">
        <span class="mr-2">{{ date }}</span><InfoBatch>フレンド</InfoBatch>
      </div>
    </div>
    <div class="request-description">『{{ request.name }}』さんからフレンド申請が届きました</div>
    <div class="px-6">
      <FriendInfoBox :user="request" />
      <div class="d-flex justify-space-between">
        <ButtonBase color="#949494" @click.native="rejectRequest">キャンセル</ButtonBase>
        <ButtonBase color="#E8730E" @click.native="acceptRequest">承認</ButtonBase>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment';
import axios from 'axios';
import FriendInfoBox from './FriendInfoBox.vue'
import ButtonBase from './ButtonBase.vue'
import InfoBatch from './InfoBatch.vue'

export default {
  components: {
    FriendInfoBox,
    ButtonBase,
    InfoBatch,
  },
  props: ['request'],
  data () {
    return {
      isAcceptSuccess: false,
      isRejectSuccess: false,
      isError: false,
    }
  },
  computed: {
    date() {
      moment.locale("ja");
      return moment( this.request.created_at).format("YYYY.MM.DD")
    },
    overlinerValue() {
      if (this.totalDuration < this.limit ) {
        return 0
      }
      return (( this.totalDuration - this.limit ) / ( this.limit * 0.25)) * 100
    }
  },
  methods: {
    acceptRequest: function() {
      axios
        .post('/friends', {
          id: this.request.id
        })
        .then(() => {
          this.isAcceptSuccess = true
          setTimeout(() => {
            this.isAcceptSuccess = false
          }, 2000)
        })
        .catch(() => {
          this.isError = true
          setTimeout(() => {
            this.isError = false
          }, 2000)
        })
    },
    rejectRequest: function() {
      axios
        .post('/requests/destroy', {
          id: this.request.id
        })
        .then(() => {
          this.isRejectSuccess = true
          setTimeout(() => {
            this.isRejectSuccess = false
          }, 2000)
        })
        .catch(() => {
          this.isError = false
          setTimeout(() => {
            this.isError = false
          }, 2000)
        })
    },
  }
}
</script>

<style scoped>
.date-text {
  font-size: 14px;
}
.request-description {
  font-size: 12px;
  margin-bottom: 30px;
}
</style>


