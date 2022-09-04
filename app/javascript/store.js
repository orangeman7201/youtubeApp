import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router.js';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: null,
    userLoaded: false,
    dateStatus: 0,
    totalDuration: 0,
  },
  getters: {
    dateStatus: state => {
      return state.dateStatus
    },
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
    updateDateStatus(state) {
      state.today = new Date();
    },
    lostUser(state) {
      state.user = null
    },
    oneDayAgo(state) {
      state.dateStatus--
    },
    oneDayAfter(state) {
      state.dateStatus++
    },
    getTotalDuration(state) {
      axios
      .get('/durations', { 
        params: { dateStatus: state.dateStatus}
      })
      .then(response => {
        state.totalDuration = response.data.total_duration;
      })
      .catch()
    },
    getSelf(state) {
      axios
      .get('/self')
      .then(response => {
        state.user = response.date})
    }
  },
  actions: {
    requireLogin(context, to) {
      context.commit('updateUserLoadStatus', true)
      if(context.state.user === null) {
        axios
        .get('/session_check')
        .then(response => {
          context.commit('updateUserStatus', response.data)
          context.commit('updateDateStatus')
          if (to) {
            router.push({name: 'HomeIndexPage'}, () => {})
          }
        })
        .catch(() => {
          context.commit('updateUserLoadStatus', false)
          router.push({name: 'LoginForm'}, () => {})
        })
      }
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
      context.commit('getTotalDuration')
    },
    getSelf(context) {
      context.commit('getSelf')
    },
  }
})