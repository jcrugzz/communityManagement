express = require("express")
mongoose = require("mongoose")
routes = require './routes'
app = module.exports = express.createServer()

app.configure "development", ->
  app.set 'db-uri', 'mongodb://localhost/communityManagementDev'
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.set 'db-uri', 'mongodb://localhost/communityManagementProd'
  app.use express.errorHandler()

db = mongoose.connect app.set('db-uri')

app.configure ->
  app.set "views", __dirname + "/views"
  app.set 'view engine', 'coffee'
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser()
  app.use express.logger()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session(secret: "your secret here")
  app.use app.router
  app.use express.static(__dirname + "/public")

# Routes

app.get "/", routes.index
app.get "/manage", routes.manage


app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
