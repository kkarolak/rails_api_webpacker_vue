<template>
  <div >
    <app-header></app-header>
    <div id="container">
          <router-view> </router-view>
    </div>
  </div>
</template>

<script>
import About from './packs/components/static_pages/About.vue'
import Home from './packs/components/static_pages/Home.vue'
import Contact from './packs/components/static_pages/Contact.vue'
import Header from './packs/components/Header.vue'
import Register from './packs/components/users/Register.vue'
import Login from './packs/components/users/Login.vue'
export default {
  components: {
    'app-contact': Contact,
    'app-home': Home,
    'app-about': About,
    'app-header': Header
  },
  data(){
    return{
    }
  },
  methods:{

  }
}
</script>

<style scoped>

</style>
