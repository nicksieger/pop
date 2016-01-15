var http = require('http'),
    connect = require('connect'),
    bodyParser = require('body-parser'),
    restreamer = require('connect-restreamer'),
    proxyKit = require('./lib/proxy-kit.js')()

var app = connect()
  .use(bodyParser.json())
  .use(bodyParser.urlencoded({extended: true}))
  .use(bodyParser.text())
  .use(restreamer())
  .use(proxyKit.requestHandler)

http.createServer(app).listen(20559)