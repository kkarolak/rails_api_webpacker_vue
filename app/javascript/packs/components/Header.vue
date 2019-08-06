<template>
  <nav class = "navbar navbar-expand-lg navbar-dark bg-dark fixed-top ">
    <div class="container">
      <a href="#" class="navbar-brand">Blog</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item active" v-if="currentUser && currentUser.role == 'user' || !currentUser""><router-link class="nav-link" to='/' exact>Home</router-link></li>
          <li class="nav-item" v-if="currentUser && currentUser.role == 'admin'""><router-link to='/admin'class="nav-link" exact>Admin Page</router-link></li>
          <li class="nav-item" v-if="currentUser && currentUser.role == 'user' || !currentUser"><router-link to='/articles' class="nav-link" exact>Articles</router-link></li>
          <li class="nav-item" v-if="currentUser && currentUser.role == 'admin'""><router-link to='/admin/articles' class="nav-link" exact>Manage Articles</router-link></li>
          <li class="nav-item" v-if="currentUser && currentUser.role == 'admin'""><router-link to='/admin/users' class="nav-link" exact>Manage Users</router-link></li>
          <li class="nav-item" v-if="currentUser && currentUser.role == 'user' || !currentUser"><router-link to='/about' class="nav-link" exact>About</router-link></li>
          <li class="nav-item" v-if="currentUser && currentUser.role == 'user' || !currentUser"><router-link to='/contact' class="nav-link" exact>Contact</router-link></li>
          <li class="nav-item" v-if="!currentUser"><router-link to='/login' class="nav-link" exact>Login</router-link></li>
          <li class="nav-item" v-if="currentUser"><router-link to='/logout' class="nav-link" exact>Logout</router-link></li>
          <li class="nav-item" v-if="!currentUser"><router-link to='/register' class="nav-link" exact>Register</router-link></li>
        </ul>
      </div>
    </div>

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

</style>
