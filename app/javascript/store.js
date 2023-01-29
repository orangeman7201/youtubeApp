import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router.js';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: null,
    userLoaded: false,
    totalDuration: 0,
  },
  getters: {
    totalDuration: state => {
      return state.totalDuration
    },
    storeUser: state => {
      return state.user
    },
    storeUserLoaded: state => {
      return state.userLoaded
    },
  },
  mutations: {
    updateUserStatus(state, user) {
      state.user = user
    },
    updateUserLoadStatus(state, bool) {
      state.userLoaded = bool
    },
    lostUser(state) {
      state.user = null
    },
    setTotalDuration(state, totalDuration) {
      state.totalDuration = totalDuration
    },
  },
  actions: {
    async sessionCheck(context, route) {
      context.commit('updateUserLoadStatus', true)
      if(context.state.user === null) {
        await axios
        .get('/api/v1/session_check')
        .then(response => {
          context.dispatch('updateUserStatus', response.data)
          // 行き先がログイン系のバスならHomeに飛ばす。
          if (route.to.path === '/' || route.to.path === '/login') {
            router.push({name: 'Home'}, () => {})
          }
        })
        .catch(() => {
          context.commit('updateUserLoadStatus', false)
          const forgetPath = ['/', '/login']
          // 行き先がforgetPathかsignup関連のpath以外ならLoginに飛ばす。
          if(!forgetPath.includes(route.to.path) && !route.to.path.match('/signup')) {
            router.push({name: 'Login'}, () => {})
          }
        })
      }
    },
    updateUserStatus(context, user) {
      context.commit('updateUserStatus', user)
    },
    lostUser(context) {
      context.commit('lostUser')
    },
    inputToday(context) {
      context.commit('inputToday')
    },
    oneDayAgo(context) {
      context.commit('oneDayAgo')
    },
    oneDayAfter(context) {
      context.commit('oneDayAfter')
    },
    getTotalDuration(context) {
      axios
      .get('/api/v1/durations')
      .then(response => {
        context.commit('setTotalDuration', response.data.total_duration)
      })
      .catch()
    },
  }
})