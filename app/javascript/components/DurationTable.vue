<template>
  <v-app>
    <table id="table" border="0">
      <border />
      <tr v-for="item in items" :key="item.date">
        <td>
          {{formatDate(item.date)}}
        </td>
        <td>
          {{item.duration}}
        </td>
      </tr>
    </table>
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
    aaa: function() {
      return "aaa"
    }
  },
  methods: {
    formatDate: function(date) {
       moment.locale("ja");
      return moment(new Date(date)).format("MM月DD日(ddd)")
    },
    formatate: function(date) {
      return moment(new Date(date)).format("MM月DD日(ddd)")
    },
  }
}
</script>