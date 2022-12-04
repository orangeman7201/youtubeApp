import Vue from 'vue';
import Router from 'vue-router';
import HomeIndexPage from './components/HomeIndexPage.vue';
import MovieDetailPage from './components/MovieDetailPage.vue';
import InputFormPage from './components/InputFormPage.vue';
import SignUp from './components/Pages/signup/SignUp.vue';
import SignUpLimit from './components/Pages/signup/steps/Limit.vue';
import SignUpName from './components/Pages/signup/steps/Name.vue';
import SignUpEmail from './components/Pages/signup/steps/Email.vue';
import SignUpPassword from './components/Pages/signup/steps/Password.vue';
import SignUpConfirm from './components/Pages/signup/steps/Confirm.vue';
import LoginForm from './components/LoginForm.vue';
import UserDetailPage from './components/UserDetailPage.vue';
import UserSerchForm from './components/UserSerchForm.vue';
import FriendIndexPage from './components/FriendIndexPage.vue';
import About from './components/Pages/About.vue';
import Timeline from './components/Pages/Timeline.vue';
import Profile from './components/Pages/Profile.vue';
import MovieHistory from './components/Pages/MovieHistory';
import Notification from './components/Pages/Notification';

Vue.use(Router);

export default new Router ({
  // mode: 'history',
  routes: [
    {path: '/', component: About}, 
    { path: '/home',
      name: 'HomeIndexPage',
      component: HomeIndexPage,
      meta: {
        requireAuth: true,
        title: "ホーム",
      },
    }, 
    { path: '/movies',
      name: 'MovieHistory',
      component: MovieHistory,
      meta: {
        requireAuth: true
      },
    }, 
    { path: '/movies/:id(\\d+)',
      name: 'MovieDetailPage',
      component: MovieDetailPage,
      meta: {
        requireAuth: true
      },
    }, 
    { path: '/movies/new',
      component: InputFormPage,
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
      name: 'LoginForm',
      component: LoginForm,
    }, 
    { path: '/users/:id(\\d+)',
      name: 'UserDetailPage',
      component: UserDetailPage,
      meta: {
        requireAuth: true
      },
    }, 
    { path: '/users/serch',
      name: 'UserSerchForm',
      component: UserSerchForm,
      meta: {
        requireAuth: true,
        title: "フレンド"
      },
    }, 
    { path: '/freinds/index',
      name: 'FriendIndexPage',
      component: FriendIndexPage,
      meta: {
        requireAuth: true
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
