var express = require('express')
var serveStatic = require('serve-static')
var compress = require('compression')

var app = express()

app.use(compress())
app.use(serveStatic('public', {'index': ['index.html', 'index.htm']}))
app.listen(process.env.PORT || 8400)
