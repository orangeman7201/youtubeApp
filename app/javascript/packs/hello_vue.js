import Vue from 'vue'
import App from '../app.vue'
import router from '../router.js'

Vue.config.productionTip = true

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('hello'))
  const app = new Vue({
    el,
    router,
    render: h => h(App)
  }).$mount()

  console.log(app)
})