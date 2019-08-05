<template>
    <div id="add-user">
      <div class="col-xs-12">
    <form>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Name: </label>
        </div>
        <div class="col-sm-7">
          <input type="text" v-model="name"required/>
        </div>
      </div>
      <div class="form-group">
        <div class="control-label col-sm-2">
          <label>Email: </label>
        </div>
        <div class="col-sm-7">
          <input type="email" v-model="email"  required/>
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
          <select v-model="role">
            <option disabled value="">Please select one</option>
            <option>admin</option>
            <option>user</option>
          </select>
        </div>
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
export default {
    data () {
        return {
          name: '',
          email:'',
          role: '',
          password_confirmation:'',
          password: '',
        }
    },
    methods: {
      create(){
        this.$http.post('auth/register', {name: this.name, password: this.password, email: this.email, role: this.role})
        .then(function(data){
          console.log(data);
        })
        }
      }
    }
  </script>
  <style>

</style>
