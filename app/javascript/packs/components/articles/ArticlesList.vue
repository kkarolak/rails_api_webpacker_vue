<template>
  <div v-theme:column="'narrow'" id="show-articles">
    <h1>List Article Titles</h1>
    <input type="text" v-model="search" placeholder="search articles"/>
    <div v-for="article in filteredArticles" class="single-article">
      <router-link v-bind:to="'/article/' + article.id">
        <h2>{{article.title | to-uppercase}}</h2>
      </router-link>
      <h2>{{article.description | snippet}}</h2>
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
    this.$http.get('http://localhost:3002/api/v1/articles').then(function(data){
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
