<template>
    <div id="add-user">
      <div class="col-xs-12">
    <form>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Title: </label>
        </div>
        <div class="col-sm-7">
          <input type="text" v-model="article.title" :placeholder="[[article.title]]"required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Description: </label>
        </div>
        <div class="col-sm-7">
          <textarea v-model="article.description" rows="4" cols="50">
            {{article.description}}
          </textarea>
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-7">
          <button v-on:click.prevent="edit"> Save </button>
        </div>
      </div>
    </form>
    <table class = "table table-striped table-hover">
      <thead>
      <tr>
        <th>Comment</th>
        <th>Status</th>
        <th colspan="2"> </th>
      </tr>
      </thead>
      <tbody v-for="comment in comments">
        <tr>
          <td> {{comment.content}}</td>
          <td> {{comment.status}}</td>
          <td><button v-if="comment.status == 'unpublished'" v-on:click.prevent="visibility(comment.id, 'published')">Publish</button></td>
          <td><button v-if="comment.status == 'published'" v-on:click.prevent="visibility(comment.id, 'unpublished')">Unpublish</button></td>
          <td><button v-on:click.prevent="deleteComment(comment.id)">Delete</button></td>
        </tr>
      </tbody>
    </table>
      </div>

    </form>
    </div>
    </div>

</template>

<script>
import { mapGetters } from 'vuex'

export default {
    data () {
        return {
          article: {},
          comments:[]
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
      edit(){
          //console.log(this.article.title)
          this.$http.put('articles/' + this.$route.params.id, {title: this.article.title, description: this.article.description}, {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Barer ' + localStorage.token
            }
          }).then(function(response){
            this.$router.go('admin/' + this.$route.params.id)
          })
      },
      deleteComment(comment_id){
        this.$http.delete('articles/' + this.$route.params.id + '/comments/' + comment_id, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Barer ' + localStorage.token
          }
        }).then(function(response){
          this.$router.go('admin/' + this.$route.params.id)
        })
      },
      visibility(comment_id, state){
        this.$http.put('articles/' + this.$route.params.id + '/comments/' + comment_id, {status: state}, {
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Barer ' + localStorage.token
          }
        }).then(function(response){
          this.$router.go('admin/' + this.$route.params.id)
        })
      },
      checkCurrentLogin () {
        if (!this.currentUser && this.$route.path !== '/' || this.currentUser.role == "user" && this.$route.path!== '/') {
          this.$router.push('/articles')
        }
      }
    },
    created(){
      this.$http.get('articles/' + this.$route.params.id)
      .then(function(data){
        this.article = data.body
      })
      this.$http.get('articles/' + this.$route.params.id + '/comments')
      .then(function(data){
        this.comments = data.body
      })
    },

  }
  </script>
  <style>

</style>
