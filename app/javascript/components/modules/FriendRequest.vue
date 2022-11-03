<template>
  <div>
    <div>{{ date }}</div>
    <div>{{ request.name }}さんからフレンド申請が届きました。</div>
    <FriendInfoBox :user="request" />
    <div>
      <ButtonBase color="#949494" class="mr-7" >キャンセル</ButtonBase>
      <ButtonBase color="#E8730E" >保存</ButtonBase>
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
.border {
  border: 0.5px solid #1995AD;
  background-color: #1995AD;
}
.liner1 {
  flex-basis: 75%;
}
.liner2 {
  flex-basis: 25%;
}
</style>


