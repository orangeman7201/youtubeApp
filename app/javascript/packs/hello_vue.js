import Vue from 'vue'
import App from '../app.vue'
import router from '../router.js';
import Vuetify from "vuetify"; 
import store from '../store';
import moment from "moment"
import "vuetify/dist/vuetify.min.css"; 
import '@mdi/font/css/materialdesignicons.css'


Vue.config.productionTip = true
Vue.use(Vuetify);
Vue.use(require('vue-moment'))
const vuetify = new Vuetify({
  icons: {
    iconfont: 'mdiSvg', // 'mdi' || 'mdiSvg' || 'md' || 'fa' || 'fa4' || 'faSvg'
  },
});

Vue.config.errorHandler = (err, vm, info) => {
  console.log(`Captured in Vue.config.errorHandler: ${info}`, err);
};
window.addEventListener("error", event => {
  console.log("Captured in error EventListener", event.error);
});
window.addEventListener("unhandledrejection", event => {
  console.log("Captured in unhandledrejection EventListener", event.reason);
});

router.beforeEach(async (to, from, next) => {
  if (to.meta.requireAuth) {
    await store.dispatch('requireLogin');
  }
  next()
});

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  new Vue({
    moment,
    el,
    router,
    store,
    vuetify,
    render: h => h(App)
  }).$mount()
})