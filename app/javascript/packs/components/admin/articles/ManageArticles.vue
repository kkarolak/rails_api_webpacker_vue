<template>
  <div>
    <h1 align="center">Manage Articles</h1>
    <button v-on:click.prevent="createArticle()">Create Article</button>
    <table class = "table table-striped table-hover">
      <thead>
      <tr>
        <th>Title</th>
        <th>Description</th>
        <th colspan="2"> </th>
      </tr>
      </thead>
      <tbody v-for="article in articles">
        <tr>
          <td> {{article.title}}</td>
          <td> {{article.description}}</td>
          <td><button v-on:click.prevent="editArticle(article.id)">Edit</button></td>
          <td><button v-on:click.prevent="deleteArticle(article.id)">Delete</button></td>
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
      articles: []
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
    deleteArticle(article_id){
      this.$http.delete('articles/' + article_id, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Barer ' + localStorage.token
        }
      }).then(function(response){
        this.$router.go(currentRouteName)
      })
    },
    editArticle(article_id){
      this.$router.push('/admin/article/' + article_id)
    },
    createArticle(){
      this.$router.push('/admin/article')
    },
    checkCurrentLogin () {
      if (!this.currentUser && this.$route.path !== '/' || this.currentUser.role == "user" && this.$route.path!== '/') {
        this.$router.push('/articles')
      }
   }
  },
  created(){
    this.$http.get('articles').then(function(data){
      this.articles = data.body
    })
  },
}
</script>
<style>
</style>
