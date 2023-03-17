import Vue from 'vue';
import Router from 'vue-router';
import Home from './components/Pages/Home.vue';
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
    { path: '/',
      component: About,
    }, 
    { path: '/home',
      name: 'Home',
      component: Home,
      meta: {
        title: "ホーム",
      },
    },
    { 
      path: '/signup',
      component: SignUp,
      children: [
        {
          path: 'limit',
          name: 'SignUpLimit',
          component: SignUpLimit
        }, 
        {
          path: 'name',
          name: 'SignUpName',
          component: SignUpName
        }, 
        {
          path: 'email',
          name: 'SignUpEmail',
          component: SignUpEmail
        }, 
        {
          path: 'password',
          name: 'SignUpPassword',
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
    { path: '/users/search',
      name: 'Friend',
      component: Friend,
      meta: {
        title: "フレンド"
      },
    }, 
    { path: '/timeline',
      name: 'Timeline',
      component: Timeline,
    }, 
    { path: '/profile',
      name: 'Profile',
      component: Profile,
    }, 
    { path: '/notification',
      name: 'Notification',
      component: Notification,
    }, 
  ]
})
