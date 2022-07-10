<template>
  <v-app>
    <div v-for="item in items" :key="item.date" class="duration-table">
      <div class="item-date">
        {{formatDate(item.date)}}
      </div>
      <div class="item-duration" :class="overTargetDuration(item.duration)">
        {{formatDuration(item.duration)}}
      </div>
    </div>
  </v-app>
</template>

<script>
import moment from 'moment';

export default {
  props: ['items'],
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
  computed: {

  },
  methods: {
    formatDate: function(date) {
      moment.locale("ja");
      return moment(new Date(date)).format("MM月DD日(ddd)")
    },
    formatDuration: function(duration) {
      const minute = Math.floor(duration/60)
      return `${minute}分`
    },
    overTargetDuration: function(duration) {
      // 60*60の部分は目標の再生時間が入る
      return duration > 60*60 ? "over-duration" : ""
    }
  }
}
</script>

<style scoped>
.duration-table {
  display: flex;
  justify-content: space-between;
  margin: 0 0 16px;
  border-bottom: 1px solid #BCBABE;
}
.item-date {
  color: #5E5E5E;
}
.item-duration {
  font-size: 32px;
  color: #333333;
}
.over-duration {
  color: #FF5F5D;
}
</style>