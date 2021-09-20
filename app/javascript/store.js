import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';
import router from './router';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    movies: []
  },
  getters: {
    storeMovies: state => {
       return state.movies
    }
  },
  mutations: {
    getData(state) {
      axios
      .get('/movies.json')
      .then(response => (state.movies = response.data))
      .catch(error => {
        router.push({name: 'LoginForm' })
        console.log(error)
      })
    }
  },
  actions: {
    getData(context) {
      context.commit('getData')
    }
  }
})