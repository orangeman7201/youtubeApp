import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    movies: [],
    user: '',
    today: null,
  },
  getters: {
    storeMovies: state => {
       return state.movies
    },
    storeToday: state => {
       return state.today
    },
    storeUser: state => {
       return state.user
    },
  },
  mutations: {
    getData(state) {
      axios
      .get('/session_check')
      .then(response => {
        console.log(response)
        state.user = 'ok'
        state.today = new Date();
      })
      .catch(error => {
        router.push({name: 'LoginForm' })
        console.log(error)
      })
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
  },
  actions: {
    getData(context) {
      context.commit('getData')
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
  }
})