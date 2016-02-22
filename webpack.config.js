var webpack = require('webpack')
var CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    entry: './src/index',
    output: {
        path: __dirname + '/public',
        filename: 'bundle.js'
    },
    plugins: [
        new webpack.ProvidePlugin({
            riot: 'riot',
            'fetch': 'imports?this=>global!exports?global.fetch!whatwg-fetch'
        }),
        new CopyWebpackPlugin([{
            from: 'static'
        }])
    ],
    module: {
        preLoaders: [
            {
                test: /\.js|\.tag|\.styl$/,
                loader: 'source-map-loader'
            },
            {
                test: /\.tag$/,
                exclude: /node_modules/,
                loader: 'riotjs-loader',
                query: { type: 'none' }
            }
        ],
        loaders: [
            {
                test: /\.js|\.tag$/,
                exclude: /node_modules/,
                loader: 'babel-loader',
                query: { presets: ['es2015'] } },
            {
                test: /\.styl$/,
                loader: 'style-loader!css-loader!stylus-loader?sourceMap'
            }
        ]
    },
    devtool: 'source-map',
    devServer: {
        contentBase: './public',
        port: '8999'
    }
}
