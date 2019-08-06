<template >
  <div class="card my-4">
    <h5>Leave a  Comment: </h5>
    <div class="card-body">
      <form>
          <div class="form-group">
            <textarea class="form-control" rows="3" v-model="content"></textarea>
          </div>
          <button class="btn btn-primary" v-on:click.prevent="addComment"> Add Comment </button>
      </form>
    </div>
  </div>
</template>
<script>
  import {mapGetters} from 'vuex'
  export default {
    data(){
      return {
        content:'',
        article_id: this.$route.params.id,
        user_id: currentUser.id

      }
    },
    methods: {
      addComment(){
      console.log()
      this.$http.post('articles/' + this.$route.params.id + '/comments',{content: this.content}, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Barer ' + localStorage.token
        }
      }).then(function(response){
        alert("Udało się dodać komentarz! Poczekaj na zaakceptowanie przez administratora")
        this.success();
      })
    },
    success(){
      window.location.reload()
      this.submitted = true;
    }
    },
    computed: {
      ...mapGetters({currentUser:'currentUser'}),
      currentRouteName() {
        return this.$route.name;
    }
    },
  }
</script>
