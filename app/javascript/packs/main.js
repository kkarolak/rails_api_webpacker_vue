import Vue from 'vue'
import App from '../app.vue'
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'
import Routes from './routes'
import axios from 'axios'
Vue.use(VueResource);
Vue.use(VueRouter);

const router = new VueRouter({
  routes:Routes,
  //mode:'history' - problem przy odświeżaniu stron
});
Vue.filter('snippet', function(value){
  return value.slice(0,20) + '...'
})
new Vue({
  el:'#app',
  render: h=>h(App),
  router:router,
  axios
})
