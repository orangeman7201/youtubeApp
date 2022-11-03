<template>
  <div>
    <div class="mb-3">
      <div class="date-text">{{ date }}</div>
    </div>
    <div class="request-description">『{{ request.name }}』さんからフレンド申請が届きました</div>
    <div class="px-6">
      <FriendInfoBox :user="request" />
      <div class="d-flex justify-space-between">
        <ButtonBase color="#949494">キャンセル</ButtonBase>
        <ButtonBase color="#E8730E">保存</ButtonBase>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment';
import FriendInfoBox from './FriendInfoBox.vue'
import ButtonBase from './ButtonBase.vue'

export default {
  components: {
    FriendInfoBox,
    ButtonBase,
  },
  props: ['request'],
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


