<template>
    <div class="jumbotron">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 offset-sm-2">
                    <div>
                        <h2>Login</h2>
                        <form @submit.prevent="handleSubmit">
                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" v-model="user.email" id="email" name="email" class="form-control" :class="{ 'is-invalid': submitted && $v.user.email.$error }" />
                                <div v-if="submitted && $v.user.email.$error" class="invalid-feedback">
                                    <span v-if="!$v.user.email.required">Email is required</span>
                                    <span v-if="!$v.user.email.email">Email is invalid</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password">Password</label>
                                <input type="password" v-model="user.password" id="password" name="password" class="form-control" :class="{ 'is-invalid': submitted && $v.user.password.$error }" />
                                <div v-if="submitted && $v.user.password.$error" class="invalid-feedback">
                                    <span v-if="!$v.user.password.required">Password is required</span>
                                    <span v-if="!$v.user.password.minLength">Password must be at least 6 characters</span>
                                </div>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-primary">Register</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>


<script>
import { mapGetters } from 'vuex'
import { required, email, minLength, sameAs } from "vuelidate/lib/validators";
export default {
    data () {
        return {
          user: {
               name: "",
               email: "",
               password: "",
               password_confirmation: ""
           },
           submitted: false
        }
    },
    validations: {
             user: {
                 email: { required, email },
                 password: { required, minLength: minLength(6) },
             }
    },
    computed: {
      ...mapGetters({currentUser: 'currentUser'})
    },
    created (){
      this.checkCurrentLogin()
    },
    updated (){
      this.checkCurrentLogin()
    },
    methods: {
      handleSubmit(e) {
             this.submitted = true;

             // stop here if form is invalid
             this.$v.$touch();
             if (this.$v.$invalid) {
                 return;
             }

             this.login()
         },
      checkCurrentLogin(){
        if(this.currentUser.role == "admin"){
          this.$router.replace(this.$route.query.redirect || '/admin')
        }
        else {
          this.$router.replace(this.$route.query.redirect || '/')
        }
      },
      login(){
          this.$http.post('auth/login', { password: this.user.password, email: this.user.email})
          .then(request => this.loginSuccessful(request))
          .catch(() => this.loginFailed())
        },
        loginSuccessful(req) {
        if(!req.body.access_token)
        {
          this.loginFailed()
          return
        }
        this.error = false
        console.log(req.body.access_token)
        localStorage.token = req.body.access_token
        this.$store.dispatch('login')
        if(this.currentUser.role == 'admin')
        {
          this.$router.push('/admin')
        }
        else {
          this.$router.push('/')
        }

      },
      loginFailed(){
        this.error = 'Login failed!'
        this.$store.dispatch('logout')
        delete localStorage.token
      }
      }
    }

  </script>
  <style>
  body{
      font-size:14px;
      color:#fff;
  }
  .simple-login-container{
      width:300px;
      max-width:100%;
      margin:50px auto;
  }
  .simple-login-container h2{
      text-align:center;
      font-size:20px;
  }


  a{
      color:#fff;
  }
</style>
