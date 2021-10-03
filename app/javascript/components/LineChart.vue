<script>
import { Line } from "vue-chartjs";
import axios from 'axios';

export default {
  extends: Line,
  
  mounted () {
    this.getData();
    console.log(this.oneWeekDurationArray)
    this.renderChart(this.chartData, this.options)
  },
  data: function () {
    return {
      loaded: false,
      duration: {},
      movies: [],
      options: {}
    }
  },
  computed: {
    oneWeekDateArray: function() {
      let dateArray = [];
      for(let num = 6; num >= 0; num--) {
        const date = new Date;
        date.setDate(date.getDate() - num)
        let year = String(date.getFullYear());
        let month = String(date.getMonth() + 1);
        if(month.length == 1) {
          month = 0 + month
        };
        let day = String(date.getDate());
        if(day.length == 1) {
          day = 0 + day
        };
        const fitToday = year + '-' +  month + '-' + day
        dateArray.push(fitToday);
      }
      return dateArray
    },
    oneWeekDurationArray: function() {
      const durationArray = [];
      const stepArray = []
      this.oneWeekDateArray.forEach(date => {
        const stepObj = {x: date, y: 0}
        stepArray.push(stepObj)
      })
      this.movies.forEach(element => {
          console.log(element)
        })
      stepArray.forEach(stepObj => {
        // this.movies.forEach(movie => {
        //   console.log(movie)
        //   // if(stepObj.x === movie.created_at.slice(0, 10)) {
        //   //   stepObj.y += movie.duration
        //   //   console.log('if文中')
        //   // }
        // })
        durationArray.push(stepObj)
      })
      return durationArray
    },
    chartData: function() {
      const chartdata = {
          datasets: [
            {
              label: 'test1',
              backgroundColor: '#f87979',
              data: this.oneWeekDurationArray
            }
          ]
      }
      return chartdata
    },
  },
  methods: {
    getData: async function() {
      await axios
        .get('/movies.json')
        .then(response => {
          response.data.forEach(element => {
            this.movies.push(element)
          })
        })
        .catch(error => {
          router.push({name: 'LoginForm' })
          console.log(error)
      })
    },
  }
}
</script>