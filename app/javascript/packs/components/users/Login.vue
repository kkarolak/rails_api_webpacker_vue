<template>
    <div id="add-user">
        <h2>Login</h2>
        <div class="alert alert-danger" v-if="error">{{ error }}</div>
        <form>
            <label>Email:</label>
            <input type="email" v-model="email" required/>
            <label>Password:</label>
            <input type="password" v-model="password" required/>
        </form>
        <button v-on:click.prevent="login"> Login </button>
    </div>

</template>

<script>
// Imports
export default {
    data () {
        return {
                email: '',
                password:'',
                error: false
        }
    },
    methods: {
      login(){
          this.$http.post('http://localhost:3002/api/v1/auth/login', { password: this.password, email: this.email})
          .then(request => this.loginSuccessful(request))
          .catch(() => this.loginFailed())
        },
        loginSuccessful(req) {
        if(!req.body.access_token)
        {
          this.loginFailed()
        }
        this.error = false
        this.$router.push('/')
      },
      loginFailed(){
        this.error = 'Login failed!'
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
