<template>
    <div id="add-user">
      <div class="col-xs-12">
    <form>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Title: </label>
        </div>
        <div class="col-sm-7">
          <input type="text" v-model="title" required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Description: </label>
        </div>
        <div class="col-sm-7">
          <textarea v-model="description" rows="4" cols="50">
          </textarea>
        </div>
      </div>
    </form>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-7">
          <button v-on:click.prevent="create"> Save </button>
        </div>
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
          title: '',
          description: ''
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
      create(){
        console.log(this.title)
          this.$http.post('articles', {title: this.title, description: this.description}, {
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
    }
  </script>
  <style>

</style>
