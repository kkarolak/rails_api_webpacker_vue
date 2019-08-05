<template>
    <div id="add-user">
      <div class="col-xs-12">
    <form>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Name: </label>
        </div>
        <div class="col-sm-7">
          <input type="text" v-model="user.name" :placeholder="[[user.name]]"required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Email: </label>
        </div>
        <div class="col-sm-7">
          <input type="email" v-model="user.email" :placeholder="[[user.email]]" required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Password: </label>
        </div>
        <div class="col-sm-7">
          <input type="password" v-model="password" required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Password Confirmation</label>
        </div>
        <div class="col-sm-7">
          <input type="password" v-model="password_confirmation" required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Role</label>
        </div>
        <div class="col-sm-7">
          <select v-model="user.role">
            <option disabled value="">Please select one</option>
            <option>admin</option>
            <option>user</option>
          </select>
        </div>
      </div>
      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-7">
          <button v-on:click.prevent="edit"> Save </button>
        </div>
      </div>
    </form>
    </div>
    </div>

</template>

<script>
export default {
    data () {
        return {
          user: {},
          password_confirmation:'',
          password: '',
        }
    },
    methods: {
      edit(){
        if(this.password == '')
        {
          this.$http.put('users/' + this.$route.params.id, {role: this.user.role, name: this.user.name, email: this.user.email}, {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Barer ' + localStorage.token
            }
          }).then(function(response){
            this.$router.go('admin/users')
          })
        }
        else {
          this.$http.put('users/' + this.$route.params.id, {role: this.user.role, name: this.user.name, email: this.user.email, password: this.password}, {
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Barer ' + localStorage.token
            }
          }).then(function(response){
            this.$router.go('admin/users')
          })
        }

      }
    },
    created(){
      this.$http.get('users/' + this.$route.params.id)
      .then(function(data){
        this.user = data.body
      })
    }
    }
  </script>
  <style>

</style>
