import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user: '',
    today: null,
    totalDuration: 0,
  },
  getters: {
    storeToday: state => {
      return state.today
    },
    storeUser: state => {
      return state.user
    },
    totalDuration: state => {
      return state.totalDuration
    },
  },
  mutations: {
     requireLogin(state) {
      axios
      .get('/session_check')
      .then(response => {
        state.user = 'ok';
        state.today = new Date();
      })
      .catch(error => {
        router.push({name: 'LoginForm' })
        console.log(error)
      })
    },
    updateStatus(state) {
      state.user = 'ok'
      state.today = new Date();
    },
    lostUser(state) {
      state.user = ''
    },
    inputToday(state) {
      state.today = new Date();
    },
    oneDayAgo(state) {
      const newDay = new Date(state.today);
      newDay.setDate(state.today.getDate() - 1);
      state.today = newDay;
    },
    oneDayAfter(state) {
      const newDay = new Date(state.today);
      newDay.setDate(state.today.getDate() + 1);
      state.today = newDay;
    },
    getTotalDuration(state) {
      axios
      .get('/total', { 
        params: { date: state.today}
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