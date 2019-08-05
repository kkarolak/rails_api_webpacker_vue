<template>
  <nav>
    <ul>
      <li v-if="currentUser && currentUser.role == 'user' || !currentUser""><router-link to='/' exact>Blog</router-link></li>
      <li v-if="currentUser && currentUser.role == 'admin'""><router-link to='/admin' exact>Admin Page</router-link></li>
      <li v-if="currentUser && currentUser.role == 'user' || !currentUser"><router-link to='/articles' exact>Articles</router-link></li>
      <li v-if="currentUser && currentUser.role == 'admin'""><router-link to='/admin/articles' exact>Manage Articles</router-link></li>
      <li v-if="currentUser && currentUser.role == 'admin'""><router-link to='/admin/users' exact>Manage Users</router-link></li>
      <li v-if="currentUser && currentUser.role == 'user' || !currentUser"><router-link to='/about' exact>About</router-link></li>
      <li v-if="currentUser && currentUser.role == 'user' || !currentUser"><router-link to='/contact' exact>Contact</router-link></li>
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
