<template>
    <div class="jumbotron">
        <div class="container">
            <div class="row">
                <div class="col-sm-8 offset-sm-2">
                    <div>
                        <h2>Register</h2>
                        <form @submit.prevent="handleSubmit">
                            <div class="form-group">
                                <label for="name">First Name</label>
                                <input type="text" v-model="user.name" id="name" name="name" class="form-control" :class="{ 'is-invalid': submitted && $v.user.name.$error }" />
                                <div v-if="submitted && !$v.user.name.required" class="invalid-feedback">
                                  <span v-if="!$v.user.name.required"> Name is required!</span>
                                 </div>
                            </div>
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
                                <label for="password_confirmation">Confirm Password</label>
                                <input type="password" v-model="user.password_confirmation" id="password_confirmation" name="password_confirmation" class="form-control" :class="{ 'is-invalid': submitted && $v.user.password_confirmation.$error }" />
                                <div v-if="submitted && $v.user.password_confirmation.$error" class="invalid-feedback">
                                    <span v-if="!$v.user.password_confirmation.required">Confirm Password is required</span>
                                    <span v-else-if="!$v.user.password_confirmation.sameAsPassword">Passwords must match</span>
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
// Imports
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
                 name: { required },
                 email: { required, email },
                 password: { required, minLength: minLength(6) },
                 password_confirmation: { required, sameAsPassword: sameAs('password') }
             }
         },
    methods: {
      handleSubmit(e) {
             this.submitted = true;

             // stop here if form is invalid
             this.$v.$touch();
             if (this.$v.$invalid) {
                 return;
             }

             this.register()
         },
      register(){
          this.$http.post('auth/register', {name: this.user.name, password: this.user.password, email: this.user.email})
          .then(request => this.registerSuccessful(request))
          .catch(() => this.registerFailed())
        },
      registerSuccessful(req) {
        if(!req.status == "201"){
          this.registerFailed()
          return
        }
        this.error = false
        this.$router.push('/login')
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
