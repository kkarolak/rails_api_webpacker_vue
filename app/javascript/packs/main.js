import Vue from 'vue'
import App from '../app.vue'
import Vuelidate from 'vuelidate';
import VueResource from 'vue-resource'
import VueRouter from 'vue-router'
import Routes from './routes'
import store from './store'
import axios from 'axios'
import {apiHost} from './config'
import "bootstrap/dist/css/bootstrap.min.css"
import "bootstrap"
import moment from 'moment'
Vue.use(VueResource);
Vue.use(VueRouter);
Vue.use(Vuelidate)
Vue.http.options.root = apiHost

const router = new VueRouter({
  routes:Routes,
  //mode:'history' - problem przy odświeżaniu stron
});
Vue.filter('snippet', function(value){
  return value.slice(0,20) + '...'
}),
Vue.filter('formatDate', function(value) {
  if (value) {
    return moment(String(value)).format('MM/DD/YYYY hh:mm')
  }
}),
new Vue({
  el:'#app',
  render: h=>h(App),
  router:router,
  store

})
