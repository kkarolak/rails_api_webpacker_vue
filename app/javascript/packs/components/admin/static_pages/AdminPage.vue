<template>
  <div>
    <h1>Admin Page</h1>
    <p>Here is some information. This is the admin page</p>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
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
   checkCurrentLogin(){
     if (!this.currentUser && this.$route.path !== '/' || this.currentUser.role == "user" && this.$route.path!== '/') {
       this.$router.push('/')
     }
   }
 }
}
</script>
<style>
</style>
