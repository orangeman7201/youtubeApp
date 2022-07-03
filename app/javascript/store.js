import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: '',
    dateStatus: 0,
    totalDuration: 0,
  },
  getters: {
    storeUser: state => {
      return state.user
    },
    dateStatus: state => {
      return state.dateStatus
    },
    totalDuration: state => {
      return state.totalDuration
    },
  },
  mutations: {
     requireLogin(state) {
      axios
      .get('/session_check')
      .then(() => {
        state.user = 'ok';
      })
      .catch(error => {
        router.push({name: 'LoginForm' })
        console.log(error)
      })
    },
    updateStatus(state) {
      state.user = 'ok'
    },
    lostUser(state) {
      state.user = ''
    },
    oneDayAgo(state) {
      state.dateStatus--
    },
    oneDayAfter(state) {
      state.dateStatus++
    },
    getTotalDuration(state) {
      axios
      .get('/total', { 
        params: { dateStatus: state.dateStatus}
      })
      .then(response => {
        state.totalDuration = response.data.total_duration;
      })
      .catch()
    },
  },
  actions: {
    requireLogin(context) {
      context.commit('requireLogin')
    },
    updateStatus(context) {
      context.commit('updateStatus')
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
  }
})