import About from './components/static_pages/About.vue'
import Home from './components/static_pages/Home.vue'
import Contact from './components/static_pages/Contact.vue'
import Register from './components/users/Register.vue'
import ArticlesList from './components/articles/ArticlesList.vue'
import SelectedArticle from './components/articles/SelectedArticle.vue'
import Login from './components/users/Login.vue'
import Logout from './components/users/Logout.vue'

import AdminPage from './components/admin/static_pages/AdminPage.vue'
import ManageArticles from './components/admin/articles/ManageArticles.vue'
import ManageUsers from './components/admin/users/ManageUsers.vue'
import EditUser from './components/admin/users/EditUser.vue'
import EditArticle from './components/admin/articles/EditArticle.vue'
import CreateArticle from './components/admin/articles/CreateArticle.vue'
import CreateUser from './components/admin/users/CreateUser.vue'


export default [
  {path: '/',component:Home},
  {path: '/about', component:About},
  {path: '/contact', component:Contact},
  {path: '/register', component:Register},
  {path: '/articles', component:ArticlesList},
  {path: '/article/:id', component:SelectedArticle},
  {path: '/login', component:Login},
  {path: '/logout', component:Logout},
  {path: '/admin', component:AdminPage},
  {path: '/admin/articles', component:ManageArticles},
  {path: '/admin/users', component:ManageUsers},
  {path: '/admin/user/:id', component: EditUser},
  {path: '/admin/article/:id', component: EditArticle},
  {path: '/admin/article', component: CreateArticle},
  {path: '/admin/user', component: CreateUser}
]
