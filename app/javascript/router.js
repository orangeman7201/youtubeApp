import Vue from 'vue';
import Router from 'vue-router';
import HomeIndexPage from './components/HomeIndexPage.vue';
import MovieDetailPage from './components/MovieDetailPage.vue';
import InputFormPage from './components/InputFormPage.vue';
import Chart from './components/Chart.vue';
import ChartMethods from './components/ChartMethods.vue';
import SignUpForm from './components/SignUpForm.vue';
import LoginForm from './components/LoginForm.vue';
import UserDetailPage from './components/UserDetailPage.vue';
import UserSerchForm from './components/UserSerchForm.vue';
import FriendRequestPage from './components/FriendRequestPage.vue';
import FriendIndexPage from './components/FriendIndexPage.vue';
import DurationRankingPage from './components/DurationRankingPage.vue';

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
     {path: '/users/:id(\\d+)', name: 'UserDetailPage', component: UserDetailPage}, 
     {path: '/users/serch', name: 'UserSerchForm', component: UserSerchForm}, 
     {path: '/freinds/requests', name: 'FriendRequestPage', component: FriendRequestPage}, 
     {path: '/freinds/index', name: 'FriendIndexPage', component: FriendIndexPage}, 
     {path: '/friends/ranking', name: 'DurationRankingPage', component: DurationRankingPage}, 
  ]
})