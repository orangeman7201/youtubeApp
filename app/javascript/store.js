import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: null,
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
  },
  mutations: {
    requireLogin(state) {
      axios
      .get('/session_check')
      .then((response) => {
        state.user = response.data
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
       .then(response => (state.user = response.data))
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
    getSelf(context) {
      context.commit('getSelf')
    },
  }
})