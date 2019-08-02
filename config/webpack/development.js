const environment = require('./environment')
const HtmlWebpackPlugin = require('html-webpack-plugin')

environment.plugins.prepend('HtmlWebpackPlugin', new HtmlWebpackPlugin({
  title: 'My Vuejs App',
  inject: true
}))

module.exports = environment.toWebpackConfig()
