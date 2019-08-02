<template>
  <div id="single-article">
    <h1>{{article.title}}</h1>
    <article>
      {{article.description}}
    </article>
  </div>
</template>

<script>
  export default {
    data(){
      return{
        id: this.$route.params.id,
        article: {}
      }
    },
    created(){
      this.$http.get('http://localhost:3002/api/v1/articles/' + this.id)
      .then(function(data){
        this.article = data.body
      })
    }
  }
</script>
