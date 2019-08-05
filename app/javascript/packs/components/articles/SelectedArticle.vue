<template>
  <div v-theme:column="'narrow'" class="single-article">
    <h1>{{article.title}}</h1>
    <article>
      {{article.description}}
    </article>
    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <div class="well well-lg">
          <app-comment v-if="currentUser" v-on></app-comment>
          <p>Comments: </p>
          <div v-for="comment in comments" class="article-body">
            <div v-for="user in users" class="article-title">
              <p v-if="comment.user_id == user.id">{{user.name}}</p>
            </div>
            {{comment.content}}
          </div>
        </div>
      </div>
    </div>
  </div>

</template>

<script>
  import AddComment from '../comments/AddComment.vue'
  import { mapGetters } from 'vuex'

  export default {
    data(){
      return{
        id: this.$route.params.id,
        article: {},
        comments: [],
        users: [],
      }
    },
    components: {
     'app-comment': AddComment
   },
    methods:{
      
    },
    computed: {
      ...mapGetters({currentUser:'currentUser'})
    },
    created(){
      this.$http.get('http://localhost:3002/api/v1/articles/' + this.id)
      .then(function(data){
        this.article = data.body
      })
      this.$http.get('http://localhost:3002/api/v1/articles/' + this.id + '/comments')
      .then(function(data){
        this.comments = data.body
      })
      this.$http.get('http://localhost:3002/api/v1/users/')
      .then(function(data){
        this.users =  data.body
      //  console.log(data.body)
      })
    }
  }
</script>
<style>
  #show-articles{
    max-width: 800px;
    margin: 0 auto;
  }
  .single-article{
    padding: 20px;
    margin: 20px 0;
    box-sizing: border-box;
    background: #eee;
  }
</style>
