# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

  Article.create([{title:'First article', description: 'First description'},title:'Second article', description: 'Second description'])
  Comment.create([{comment:'Super artykuł', article_id: 1},{comment:'Fajny artykuł', article_id: 1},{comment:'Świetny artykuł', article_id: 2}])
