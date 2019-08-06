<template>
  <div>
    <h1 align="center">Manage Users</h1>
    <button v-on:click.prevent="createUser()">Create User</button>
    <table class = "table table-striped table-hover">
      <thead>
      <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Role</th>

        <th colspan="2"> </th>
      </tr>
      </thead>
      <tbody v-for="user in users">
        <tr>
          <td> {{user.name}}</td>
          <td> {{user.email}}</td>
          <td> {{user.role}}</td>
          <td><button v-on:click.prevent="editUser(user.id)">Edit</button></td>
          <td><button v-on:click.prevent="deleteUser(user.id)">Delete</button></td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  data(){
    return{
      users: []
    }
  },
  computed: {
   ...mapGetters({ currentUser: 'currentUser' })
 },
 created () {
   this.checkCurrentLogin()
 },
 updated () {
   this.checkCurrentLogin()
 },
  methods: {
    deleteUser(user_id){
      this.$http.delete('users/' + user_id, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Barer ' + localStorage.token
        }
      }).then(function(response){
        this.$router.go(currentRouteName)
      })
    },
    editUser(user_id){
      this.$router.push('/admin/user/'+ user_id)
    },
    createUser(){
      this.$router.push('/admin/user')
    },
    checkCurrentLogin () {
      if (!this.currentUser && this.$route.path !== '/' || this.currentUser.role == "user" && this.$route.path!== '/') {
        this.$router.push('/')
      }
    }
  },
  created(){
    this.$http.get('users').then(function(data){
      this.users = data.body
    })
  },
}
</script>
<style>
</style>
