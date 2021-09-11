import Vue from 'vue';
import Router from 'vue-router';
import HomeIndexPage from './components/HomeIndexPage.vue';
import MovieDetailPage from './components/MovieDetailPage.vue';
// import MovieNewPage from './components/MovieNewPage.vue';

Vue.use(Router);

export default new Router ({
  routes: [
     {path: '/', component: HomeIndexPage}, 
     {path: '/movies/:id(\\d+)', name: 'MovieDetailPage',component: MovieDetailPage}, 
    //  {path: '/movies/new', name: 'MovieNewPage',component: MovieNewPage}, 
  ]
})