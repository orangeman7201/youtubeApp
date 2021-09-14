import Vue from 'vue';
import Vuex from 'vuex';
import axios from 'axios';

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
    }
  },
  actions: {
    getData(context) {
      context.commit('getData')
    }
  }
})