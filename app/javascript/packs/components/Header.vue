<template>
  <nav>
    <ul>
      <li><router-link to='/' exact>Blog</router-link></li>
      <li><router-link to='/articles' exact>Articles</router-link></li>
      <li><router-link to='/about' exact>About</router-link></li>
      <li><router-link to='/contact' exact>Contact</router-link></li>
      <li v-if="!currentUser"><router-link to='/login' exact>Login</router-link></li>
      <li v-if="currentUser"><router-link to='/logout' exact>Logout</router-link></li>
      <li v-if="!currentUser"><router-link to='/register' exact>Register</router-link></li>
    </ul>
  </nav>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  }
}
</script>

<style scoped>
ul{
  list-style-type: none;
  text-align: center;
  margin: 0;
}
li{
  display: inline-block;
  margin: 0 10px;
}
a{
  color: #fff;
  text-decoration: none;
  padding: 6px 8px;
  border-radius: 10px;
}
nav{
  background: #444;
  padding: 14px 0;
  margin-bottom: 40px;
}
.router-link-active{
  background: #eee;
  color: #444;
}
</style>
