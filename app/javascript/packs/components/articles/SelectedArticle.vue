<template>
  <div v-theme:column="'narrow'" class="single-article">
    <h1>{{article.title}}</h1>
    <article>
      {{article.description}}
    </article>
    <div class="row">
      <div class="col-xs-8 col-xs-offset-2">
        <div class="well well-lg">
          <app-comment v-if="currentUser" ></app-comment>
          <p>Comments: </p>
          <div v-for="comment in comments" class="article-body">
            <div v-for="user in users" class="article-title">
              <p v-if="comment.user_id == user.id && comment.status == 'published'">{{user.name}}</p>
            </div>
            <p v-if="comment.status == 'published'">   {{comment.content}} </p>
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
      getArticleInfo(){
        this.$http.get('articles/' + this.id)
        .then(function(data){
          this.article = data.body
        })
      },
      getComments(){
        this.$http.get('articles/' + this.id + '/comments')
        .then(function(data){
          console.log(data.body)
          this.comments = data.body
        })
      },
      getUsers(){
        this.$http.get('users/')
        .then(function(data){
          this.users =  data.body
        //  console.log(data.body)
        })
      }
    },
    computed: {
      ...mapGetters({currentUser:'currentUser'})
    },
    created(){
      this.getArticleInfo();
      this.getComments();
      this.getUsers();
    },
    mounted(){
      this.getComments();

      this.$bus.$on('updateComments', event => {
        this.getComments();
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
