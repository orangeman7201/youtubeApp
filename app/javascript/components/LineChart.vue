<script>
import { Line, mixins } from 'vue-chartjs'
const { reactiveProp } = mixins


export default {
  extends: Line,
  mixins: [reactiveProp],

  mounted () {
    this.renderChart(this.chartData, this.options)
  },

  data: function () {
    return {
      loaded: false,
      duration: {},
      movies: [],
      options: {
        legend: {
          display: false
        },
        scales: {
          xAxes: [{
            ticks: {
              callback: function(value) {
                return value.slice(5)
              }
            }
          }],
          yAxes: [{
              ticks: {
                // Include a dollar sign in the ticks
                callback: function(value) {
                    const h = Math.floor(value / 3600);
                    const m = Math.floor(value / 60 % 60);
                    const s = Math.floor(value % 60);
                    if(h > 0) {
                      const a = h + "時間" + m + "分" 
                      return a
                    } else if(m > 0) {
                      const b = m + "分" + s +"秒"
                      return b
                    } else {
                      const c = s +"秒"
                      return c
                    }
                }
              }
          }]
        }
      }
    }
  },
  props: ['number'],
  computed: {

  },

}
</script>