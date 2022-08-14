import Vue from 'vue';
import Router from 'vue-router';
import HomeIndexPage from './components/HomeIndexPage.vue';
import MovieDetailPage from './components/MovieDetailPage.vue';
import InputFormPage from './components/InputFormPage.vue';
import SignUpForm from './components/SignUpForm.vue';
import LoginForm from './components/LoginForm.vue';
import UserDetailPage from './components/UserDetailPage.vue';
import UserSerchForm from './components/UserSerchForm.vue';
import FriendIndexPage from './components/FriendIndexPage.vue';
import About from './components/About.vue';
import Timeline from './components/Pages/Timeline.vue';
import Profile from './components/Pages/Profile.vue';
import ProfileEdit from './components/Pages/ProfileEdit.vue';
import MovieHistory from './components/Pages/MovieHistory';

Vue.use(Router);

export default new Router ({
  // mode: 'history',
  routes: [
     {path: '/', component: About}, 
     {path: '/home', name: 'HomeIndexPage', component: HomeIndexPage}, 
     {path: '/movies', name: 'MovieHistory', component: MovieHistory}, 
     {path: '/movies/:id(\\d+)', name: 'MovieDetailPage',component: MovieDetailPage}, 
     {path: '/movies/new', component: InputFormPage}, 
     {path: '/signup', component: SignUpForm}, 
     {path: '/login', name: 'LoginForm', component: LoginForm}, 
     {path: '/users/:id(\\d+)', name: 'UserDetailPage', component: UserDetailPage}, 
     {path: '/users/serch', name: 'UserSerchForm', component: UserSerchForm}, 
     {path: '/freinds/index', name: 'FriendIndexPage', component: FriendIndexPage}, 
     {path: '/timeline', name: 'Timeline', component: Timeline}, 
     {path: '/profile', name: 'Profile', component: Profile}, 
     {path: '/profile/edit', name: 'ProfileEdit', component: ProfileEdit}, 
  ]
})