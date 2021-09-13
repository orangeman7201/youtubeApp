import Vue from 'vue'
import App from '../app.vue'
import router from '../router.js';
import Vuetify from "vuetify"; 
import "vuetify/dist/vuetify.min.css"; 

Vue.config.productionTip = true
Vue.use(Vuetify);
const vuetify = new Vuetify();

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    router,
    vuetify,
    render: h => h(App)
  }).$mount()

  console.log(app)
})