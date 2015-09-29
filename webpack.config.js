module.exports = {
  entry: "./app/dev/entry.js",

  output: {
    path: __dirname + "/public",
    filename: "bundle.js"
  },

  devtool: 'source-map',

  module: {
    preloaders: [
      { test: /\.js$/, loader: "source-map-loader"}
    ],
    loaders: [
      {
        test: /\.html$/,
        loader: "ngtemplate?!html"
      },
      {
        test:/\.css$/,
        loader: 'style!css'
      },
      {
        test: /\.scss$/,
        loader: "style!css!sass"
      }
    ]
  }

}
