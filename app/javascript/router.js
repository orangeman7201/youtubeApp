import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/Pages/Home.vue';
import MovieInput from './components/Pages/MovieInput.vue';
import SignUp from './components/Pages/signup/SignUp.vue';
import SignUpLimit from './components/Pages/signup/steps/Limit.vue';
import SignUpName from './components/Pages/signup/steps/Name.vue';
import SignUpEmail from './components/Pages/signup/steps/Email.vue';
import SignUpPassword from './components/Pages/signup/steps/Password.vue';
import SignUpConfirm from './components/Pages/signup/steps/Confirm.vue';
import Login from './components/Pages/Login.vue';
import Friend from './components/Pages/Friend.vue';
import About from './components/Pages/About.vue';
import Timeline from './components/Pages/Timeline.vue';
import Profile from './components/Pages/Profile.vue';
import Notification from './components/Pages/Notification';

Vue.use(Router);

export default new Router ({
  mode: 'history',
  routes: [
    {path: '/', component: About}, 
    { path: '/home',
      name: 'Home',
      component: Home,
      meta: {
        requireAuth: true,
        title: "ホーム",
      },
    }, 
    { path: '/movies/new',
      component: MovieInput,
      meta: {
        requireAuth: true
      },
    }, 
    { 
      path: '/signup',
      component: SignUp,
      children: [
        {
          path: 'limit',
          component: SignUpLimit
        }, 
        {
          path: 'name',
          component: SignUpName
        }, 
        {
          path: 'email',
          component: SignUpEmail
        }, 
        {
          path: 'password',
          component: SignUpPassword
        }, 
        {
          path: 'confirm',
          component: SignUpConfirm
        }, 
      ]
    }, 
    { path: '/login',
      name: 'Login',
      component: Login,
    }, 
    { path: '/users/serch',
      name: 'Friend',
      component: Friend,
      meta: {
        requireAuth: true,
        title: "フレンド"
      },
    }, 
    { path: '/timeline',
      name: 'Timeline',
      component: Timeline,
      meta: {
        requireAuth: true
      },
    }, 
    { path: '/profile',
      name: 'Profile',
      component: Profile,
      meta: {
        requireAuth: true
      },
    }, 
    { path: '/notification',
      name: 'Notification',
      component: Notification,
      meta: {
        requireAuth: true
      },
    }, 
  ]
})
