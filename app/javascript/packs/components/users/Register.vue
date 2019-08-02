<template>
    <div id="add-user">
        <h2>Register</h2>
        <div class="alert alert-danger" v-if="error">{{ error }}</div>
        <form>
            <label>Username:</label>
            <input type="text" v-model="name" required />
            <label>Email:</label>
            <input type="email" v-model="email" required/>
            <label>Password:</label>
            <input type="password" v-model="password" required/>
            <label>Confirm password:</label>
            <input type="password" v-model="password_confirmation" required/>
        </form>
        <button v-on:click.prevent="register"> Register </button>
    </div>

</template>

<script>
// Imports
export default {
    data () {
        return {
                name: '',
                email: '',
                password:'',
                password_confirmation: '',
                error: false
        }
    },
    methods: {
      register(){
          this.$http.post('http://localhost:3002/api/v1/auth/register', {name: this.name, password: this.password, email: this.email})
          .then(request => this.registerSuccessful(request))
          .catch(() => this.registerFailed())
        },
      registerSuccessful(req) {
        if(!req.status == "201"){
          this.registerFailed()
          return
        }
        this.error = false
        this.$router.push('/')
      },
      registerFailed(){
        this.error = 'Register failed!'
      }
      }
    }

  </script>
  <style>
#add-user *{
    box-sizing: border-box;
}
button{
  margin: 5px;
}
#add-user{
    margin: 20px auto;
    max-width: 500px;
}
label{
    display: block;
    margin: 20px 0 10px;
}
input[type="text"], textarea{
    display: block;
    width: 100%;
    padding: 8px;
}
#preview{
    padding: 10px 20px;
    border: 1px dotted #ccc;
    margin: 30px 0;
}
h3{
    margin-top: 10px;
}

</style>
