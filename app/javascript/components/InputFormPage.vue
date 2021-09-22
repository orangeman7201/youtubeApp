<template>
  <div id="app">
    <div v-if="error === ''"></div>
    <div v-else>URLを入力してください</div>
    <form @submit.prevent="submitData">
      <label for="url">URL</label>
      <input id="url" type="text" v-model="movie.url">

      <label for="comment">コメント</label>
      <input id="comment" type="text" v-model="movie.comment">

      <button type="submit">新しい動画を追加</button>
    </form>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.withCredentials = true

export default {
  data: function () {
    return {
      movie: {
        url: '',
        duration: '',
        title: '',
        comment: '',
        thumbnail: '',
      },
      error: '',
    }  
  },
  methods: {
    calculateDuration: function(duration) {
      // durationは'PT8H2M29S'のような形で送られてくる。なぜかSecondは＋１秒される。
      if(duration.includes('H')) {
        let hour = Number(duration.match(/T(.*)H/)[1]);
        let minute = Number(duration.match(/H(.*)M/)[1]);
        let second = Number(duration.match(/M(.*)S/)[1]);
        return hour*3600 + minute*60 + (second - 1);
      }else if(duration.includes('M')) {
        let minute = Number(duration.match(/T(.*)M/)[1]);
        let second = Number(duration.match(/M(.*)S/)[1]);
        return minute*60 + (second - 1);
      }else{
        let second = Number(duration.match(/T(.*)S/)[1]);
        return second - 1;
      }
    },
    submitData: function() {
      if( this.movie.url === '' ) {
        this.error = 'error';
      } else {
        this.error = '';
        const Key = 'AIzaSyDmNgXHcyUTEkPFoxXsyVTZms7RIhwguBY';
        let Id = this.movie.url.slice(32)
  
        let apiUrl = 'https://www.googleapis.com/youtube/v3/videos'; 
        apiUrl += '?id=' + Id;
        apiUrl += '&key=' + Key;
        apiUrl += '&part=snippet,contentDetails'
  
        axios
          .get(apiUrl)
          .then(response => {
            let e = response.data;
            this.movie.thumbnail = e.items[0].snippet.thumbnails.standard.url
            this.movie.title = e.items[0].snippet.title
            this.movie.duration = this.calculateDuration(e.items[0].contentDetails.duration)
            axios
              .post('/movies', this.movie)
              .then(response => {
                let e = response.data
                this.$router.push({name: 'MovieDetailPage', params: { id: e.id } })
              })
              .catch(error => {
                console.error(error);
                console.error('Rubyの方の通信エラーです');
                console.error(this.movie);
              })
          })
          .catch(error => {
            console.error(error);
            console.error('youtubeAPIの方の通信エラーです');
          });

        console.log(this.movie)
      }
    },
  }
}
</script>

<style scoped>
div {
  text-align: center;
}
</style>