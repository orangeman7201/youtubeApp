import Vue from 'vue';
import Router from 'vue-router';
import HomeIndexPage from './components/HomeIndexPage.vue';
import MovieDetailPage from './components/MovieDetailPage.vue';
import InputFormPage from './components/InputFormPage.vue';
import Chart from './components/Chart.vue';
import ChartMethods from './components/ChartMethods.vue';
import SignUpForm from './components/SignUpForm.vue';
import LoginForm from './components/LoginForm.vue';
import UserSerchPage from './components/UserSerchPage.vue';
import UserDetailPage from './components/UserDetailPage.vue';
// import MovieNewPage from './components/MovieNewPage.vue';

Vue.use(Router);

export default new Router ({
  routes: [
     {path: '/', name: 'HomeIndexPage', component: HomeIndexPage}, 
     {path: '/movies/:id(\\d+)', name: 'MovieDetailPage',component: MovieDetailPage}, 
     {path: '/movies/new', component: InputFormPage}, 
     {path: '/movies/chart', component: Chart}, 
     {path: '/movies/chartmethods', component: ChartMethods}, 
     {path: '/signup', component: SignUpForm}, 
     {path: '/login', name: 'LoginForm', component: LoginForm}, 
     {path: '/user/serch', name: 'UserSerchPage', component: UserSerchPage}, 
     {path: '/user/:id(\\d+)', name: 'UserDetailPage', component: UserDetailPage}, 
  ]
})