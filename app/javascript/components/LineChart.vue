<script>
import { Line } from "vue-chartjs";
import axios from 'axios';

export default {
  extends: Line,
  
  mounted () {
    this.getData();
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
    fourWeekDateArray: function() {
      let dateArray = [];
      for(let num = 29; num >= 0; num--) {
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
    twoWeekDateArray: function() {
      let dateArray = [];
      for(let num = 13; num >= 0; num--) {
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
        const stepObj = {date: date, duration: 0}
        stepArray.push(stepObj)
      })
      stepArray.forEach(stepObj => {
        this.movies.forEach(movie => {
          if(stepObj.date === movie.created_at.slice(0, 10)) {
            stepObj.duration += movie.duration
          }
        })
        durationArray.push(stepObj.duration)
      })
      return durationArray
    },
    twoWeekDurationArray: function() {
      const durationArray = [];
      const stepArray = []
      this.twoWeekDateArray.forEach(date => {
        const stepObj = {date: date, duration: 0}
        stepArray.push(stepObj)
      })
      stepArray.forEach(stepObj => {
        this.movies.forEach(movie => {
          if(stepObj.date === movie.created_at.slice(0, 10)) {
            stepObj.duration += movie.duration
          }
        })
        durationArray.push(stepObj.duration)
      })
      return durationArray
    },
    fourWeekDurationArray: function() {
      const durationArray = [];
      const stepArray = []
      this.fourWeekDateArray.forEach(date => {
        const stepObj = {date: date, duration: 0}
        stepArray.push(stepObj)
      })
      stepArray.forEach(stepObj => {
        this.movies.forEach(movie => {
          if(stepObj.date === movie.created_at.slice(0, 10)) {
            stepObj.duration += movie.duration
          }
        })
        durationArray.push(stepObj.duration)
      })
      return durationArray
    },
    chartData: function() {
      const chartdata = {
        datacollection: {
          labels: this.oneWeekDateArray,
          datasets: [
            {
              label: 'test1',
              backgroundColor: '#f87979',
              data: this.oneWeekDurationArray
            }
          ]
        }
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
    check: function() {
      console.log(this.chartData)
    }
  }
}
</script>