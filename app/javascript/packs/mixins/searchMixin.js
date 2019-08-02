export default {
  computed: {
    filteredArticles:function(){
      return this.articles.filter((article) =>{
        return article.title.match(this.search)
      })
    }
  }
}
