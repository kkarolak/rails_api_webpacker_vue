<template>
  <div v-theme:column="'narrow'" class="container">
    <div class="row">
      <div class="col-lg-8">
          <h1 class="mt-4">{{article.title}}</h1>
          <p class="lead">
          by
          <a href="#">{{author}}</a>
        </p>
        <hr>

        <!-- Date/Time -->
        <p>Posted on {{article.created_at | formatDate}}</p>

        <hr>

        <!-- Preview Image -->
        <img class="img-fluid rounded" src="https://pbw.bydgoszcz.pl/wp-content/uploads/2019/06/nowosci-900x300.jpg" alt="">

        <hr>
        <p class="lead">{{article.description}}</p>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ut, tenetur natus doloremque laborum quos iste ipsum rerum obcaecati impedit odit illo dolorum ab tempora nihil dicta earum fugiat. Temporibus, voluptatibus.</p>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Eos, doloribus, dolorem iusto blanditiis unde eius illum consequuntur neque dicta incidunt ullam ea hic porro optio ratione repellat perspiciatis. Enim, iure!</p>

        <blockquote class="blockquote">
          <p class="mb-0">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer posuere erat a ante.</p>
          <footer class="blockquote-footer">Someone famous in
            <cite title="Source Title">Source Title</cite>
          </footer>
        </blockquote>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Error, nostrum, aliquid, animi, ut quas placeat totam sunt tempora commodi nihil ullam alias modi dicta saepe minima ab quo voluptatem obcaecati?</p>

        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Harum, dolor quis. Sunt, ut, explicabo, aliquam tenetur ratione tempore quidem voluptates cupiditate voluptas illo saepe quaerat numquam recusandae? Qui, necessitatibus, est!</p>

      </div>
    </div>
    <div>
      <app-comment v-if="currentUser" ></app-comment>
      <div v-for="comment in comments" v-if="comment.status == 'published'" class="media mb-4">
        <img class="d-flex mr-3 rounded-circle" src="http://placehold.it/50x50" alt="">
        <div v-for="user in users" v-if="comment.user_id == user.id" class="media-body">
          <h5 v-if="comment.status == 'published'" class="mt-0">{{user.name}}</h5>
            <p v-if="comment.status == 'published'">   {{comment.content}} </p>
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
        author: '',
      }
    },
    components: {
     'app-comment': AddComment
   },
    methods:{
      getArticleInfo(){
        this.$http.get('articles/' + this.id)
        .then(function(data){
          console.log(data.body)
          this.article = data.body
          this.getAuthor(this.article.user_id);
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
      },
      getAuthor(user_id){
        this.$http.get('users/' + user_id)
        .then(function(data){
          this.author = data.body.name
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

</style>
