import About from './components/static_pages/About.vue'
import Home from './components/static_pages/Home.vue'
import Contact from './components/static_pages/Contact.vue'
import Register from './components/users/Register.vue'
import ArticlesList from './components/articles/ArticlesList.vue'
import SelectedArticle from './components/articles/SelectedArticle.vue'
import Login from './components/users/Login.vue'

export default [
  {path: '/',component:Home},
  {path: '/about', component:About},
  {path: '/contact', component:Contact},
  {path: '/register', component:Register},
  {path: '/articles', component:ArticlesList},
  {path: '/article/:id', component:SelectedArticle},
  {path: '/login', component:Login}
]
