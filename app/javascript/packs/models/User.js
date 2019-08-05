import JwtDecode from 'jwt-decode'

export default class User {
  static from (token) {
    try {
      let obj = JwtDecode(token)
      return new User(obj)
    }catch (_){
      return null
    }
  }
  constructor ({id,role,email}){
    this.id = id
    this.email = email
  }
  get isAdmin(){
    return this.role
  }
}
