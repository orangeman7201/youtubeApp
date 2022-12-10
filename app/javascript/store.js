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
    async requireLogin(context, to) {
      context.commit('updateUserLoadStatus', true)
      if(context.state.user === null) {
        await axios
        .get('/session_check')
        .then(response => {
          context.dispatch('updateUserStatus', response.data)
          if (to) {
            router.push({name: 'Home'}, () => {})
          }
        })
        .catch(() => {
          context.commit('updateUserLoadStatus', false)
          router.push({name: 'Login'}, () => {})
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
      .get('/durations')
      .then(response => {
        context.commit('setTotalDuration', response.data.total_duration)
      })
      .catch()
    },
  }
})