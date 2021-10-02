import Vue from 'vue'
import App from '../app.vue'
import router from '../router.js';
import Vuetify from "vuetify"; 
import store from '../store';
import "vuetify/dist/vuetify.min.css"; 
import '@mdi/font/css/materialdesignicons.css'


Vue.config.productionTip = true
Vue.use(Vuetify);
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

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    router,
    store,
    vuetify,
    render: h => h(App)
  }).$mount()

  console.log(app)
})