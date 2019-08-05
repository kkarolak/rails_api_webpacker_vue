<template >
  <div id="add-comment">
    <form v-if="!submitted">
            <label>Add Comment</label>
            <textarea v-model="content"></textarea>
    </form>
    <div v-if="submitted">
          <h3>Thanks for submiting your comment</h3>
    </div>
    <button v-on:click.prevent="addComment"> Add Comment </button>
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
      this.$http.post('http://localhost:3002/api/v1/articles/' + this.$route.params.id + '/comments',{content: this.content}, {
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Barer ' + localStorage.token
        }
      }).then(function(response){
        console.log(response)
      })
      }
    },
    computed: {
      ...mapGetters({currentUser:'currentUser'})
    },
  }
</script>
