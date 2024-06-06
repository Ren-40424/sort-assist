const { environment } = require('@rails/webpacker')

const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)

environment.config.merge({
  node: {
    __dirname: true,
    __filename: true,
    global: true,
  }
})

const webpack = require('webpack')

// Vueのフラグを定義するための設定を追加
environment.plugins.append('DefinePlugin', new webpack.DefinePlugin({
  __VUE_OPTIONS_API__: true,
  __VUE_PROD_DEVTOOLS__: false,
  __VUE_PROD_HYDRATION_MISMATCH_DETAILS__: false
}))

module.exports = environment
