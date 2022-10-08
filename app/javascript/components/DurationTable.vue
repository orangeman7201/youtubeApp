<template>
  <div class="duration-table">
    <div v-for="item in items" :key="item.date" class="duration-table-item">
      <div class="item-date">
        {{formatDate(item.date)}}
      </div>
      <div class="item-duration" :class="overTargetDuration(item.duration)">
        <span v-if="item.duration > limit" class="excess-text">過剰</span><span class="mr-3 ml-4 d-flex justify-center">{{formatDuration(item.duration)}}</span><span class="minute-text">分</span>
      </div>
    </div>
  </div>
</template>

<script>
import moment from 'moment';

export default {
  props: ['items', 'limit'],
  data: function () {
    return {
      headers: [
          {
            text: 'sss',
            align: 'start',
            value: 'date',
          },
          { text: 'Calories', value: 'duration' }
      ]
    }
  },
  methods: {
    formatDate: function(date) {
      moment.locale("ja");
      return moment(new Date(date)).format("MM月DD日")
    },
    formatDuration: function(duration) {
      const minute = Math.floor(duration/60)
      if (minute === 0) {
        return "-"
      }
      return `${minute}`
    },
    overTargetDuration: function(duration) {
      return duration > this.limit ? "over-duration" : ""
    }
  }
}
</script>

<style scoped>
.duration-table {
  padding: 0 32px 40px;
}
.duration-table-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  border-bottom: 1px solid #BCBABE;
  margin-bottom: 17px;
}
.item-date {
  color: #5E5E5E;
}
.item-duration {
  font-size: 30px;
  color: #333333;
  display: flex;
  align-items: center;
}
.over-duration {
  color: #FF5F5D;
}
.minute-text {
  padding-top: 10px;
  font-size: 15px;
}
.excess-text {
  border: 0.8px solid #EB440C;
  padding: 0 12px;
  font-size: 15px;
}
</style>