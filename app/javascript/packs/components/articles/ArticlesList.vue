<template>

  <div class="projects-horizontal">
       <div class="container">
           <div class="intro">
               <h2 class="text-center"> Articles </h2>
               <form class="form-inline md-form form-sm mt-0">
                  <input type="text" class="form-control form-control-sm ml-3 w-75" v-model="search" placeholder="Search" aria-label="Search"/>
               </form>
           </div>
           <div class="row projects">
               <div class="col-sm-6 item"  v-for="article in filteredArticles">
                   <div class="row">
                       <div class="col-md-12 col-lg-5"><router-link v-bind:to="'/article/' + article.id"><img class="img-fluid" src="http://www.ahmedabadwebpromotion.com/images/article-writing-img.jpg"></router-link></div>
                       <div class="col">
                           <h3 class="name">{{article.title}}</h3>
                           <p>{{article.description | snippet}}</p>
                       </div>
                   </div>
               </div>
           </div>
       </div>
   </div>
</template>

<script>

import searchMixin from '../../mixins/searchMixin'

export default {

  data(){
    return{
      articles: [],
      search:'',
    }
  },
  methods:{

  },
  created(){
    this.$http.get('articles').then(function(data){
      this.articles = data.body.slice(0,10);
    })
  },
  computed:{

  },
  filters:{
    toUppercase(value){
      return value.toUpperCase();
    }
  },
  directives:{
    'rainbow':{
      bind(el,binding,vnode){
        el.style.color = "#" + Math.random().toString().slice(2,8);
      }
  }
},
mixins:[searchMixin]
}
</script>

<style>
.projects-horizontal {
  color:#313437;
  background-color:#fff;
}

.projects-horizontal p {
  color:#7d8285;
}

.projects-horizontal h2 {
  font-weight:bold;
  margin-bottom:40px;
  padding-top:40px;
  color:inherit;
}

@media (max-width:767px) {
  .projects-horizontal h2 {
    margin-bottom:25px;
    padding-top:25px;
    font-size:24px;
  }
}

.projects-horizontal .intro {
  font-size:16px;
  max-width:500px;
  margin:0 auto 10px;
}

.projects-horizontal .projects {
  padding-bottom:40px;
}

.projects-horizontal .item {
  padding-top:60px;
  min-height:160px;
}

@media (max-width:767px) {
  .projects-horizontal .item {
    padding-top:40px;
    min-height:160px;
  }
}

.projects-horizontal .item .name {
  font-size:18px;
  font-weight:bold;
  margin-top:10px;
  margin-bottom:15px;
  color:inherit;
}

@media (max-width:991px) {
  .projects-horizontal .item .name {
    margin-top:22px;
  }
}

.projects-horizontal .item .description {
  font-size:15px;
  margin-bottom:0;
}

</style>
