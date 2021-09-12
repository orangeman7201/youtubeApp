<template>
  <div id="app">
    <form>
      <label for="url">URL</label>
      <input id="url" type="text" v-model="movie.url">

      <label for="comment">コメント</label>
      <input id="comment" type="text" v-model="movie.comment">

      <label for="button">追加</label>
      <input id="button" type="button" @click.prevent="submitData">
    </form>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      movie: {
        url: '',
        duration: '',
        title: '',
        comment: '',
      },
      
    }
    
  },
  methods: {
    submitData: function() {
      if( this.url === '' ) {
        alert('urlを入力してください')
      } else {
        const Key = 'AIzaSyDmNgXHcyUTEkPFoxXsyVTZms7RIhwguBY';
        let Id = this.movie.url.slice(32)
  
        let apiUrl = 'https://www.googleapis.com/youtube/v3/videos'; 
        apiUrl += '?id=' + Id;
        apiUrl += '&key=' + Key;
        apiUrl += '&part=snippet,contentDetails'
        // apiUrl += '&part=snippet,contentDetails,statistics,status'
  
         axios
          .get(apiUrl)
          .then(response => {
            let e = response.data;
            // ↓動画のサムネイルを取得できる
            // this.json = e.items[0].snippet.thumbnails.standard.url
            this.movie.title = e.items[0].snippet.title
            // this.movie.duration = e.items[0].contentDetails.duration
          })
          .catch(error => {
            console.error(error);
            console.error('youtubeAPIの方の通信エラーですぅ');
          });

        console.log(this.movie)
        axios
          .post('/movie', this.movie)
          .then(response => {
            let e = response.data
            this.$router.push({ name: 'MovieDetailPage', params: { id: e.id } })
          })
          .catch(error => {
            console.error(error);
            console.error('Rubyの方の通信エラーですぅ');
          })
      }
    }
  }
}
</script>

<style scoped>
div {
  font-size: 2em;
  text-align: center;
}
</style>