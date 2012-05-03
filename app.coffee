require('coffee-script')
express = require("express")
mongoose = require("mongoose")
httpProxy = require('http-proxy')
stylus = require('stylus')
routes = require './routes'

app = module.exports = express.createServer()

app.configure "development", ->
  mongoose.connect 'mongodb://localhost/communityManagementDev'
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  proxy = new httpProxy.RoutingProxy



  app.get '/application.(css|js)'

app.configure "production", ->
  mongoose.connect 'mongodb://localhost/communityManagementProd'
  app.use express.errorHandler()

app.configure ->
  publicDir = "#{__dirname}/public"
  viewsDir = "#{__dirname}/views"

  app.set "views", viewsDir
  app.set 'view options',
    layout: false
  app.set 'view engine', 'coffee'
  app.register '.coffee', require('coffeecup').adapters.express
  app.use express.bodyParser()
  app.use express.static(publicDir)
  #app.use express.logger()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session(secret: "your secret here")
  app.use app.router


# Routes
app.get "/", routes.index

# Custom
app.post "/autoAssign", routes.autoAssign
app.post '/checkOff', routes.checkOff
app.post '/assign', routes.assign

# User Routes
app.get '/users', routes.userIndex
app.get '/users/new', routes.newUser
app.post '/users', routes.addUser
app.get '/users/:id', routes.viewUser
app.get '/users/:id/edit', routes.editUser
app.put '/users/:id', routes.updateUser
app.del '/users/:id', routes.deleteUser

# AssignmentRecord Routes
app.post '/assignmentRecords', routes.addRecord
app.get '/assignmentRecords', routes.assignmentRecords
app.get '/removeAssignmentRecords', routes.removeAssignmentRecords

# Routes for database adjustment purposes
app.get '/removeUserAssignments', routes.removeUserAssignments
app.get '/addDefaultAssignments', routes.defaultAssignments
app.get '/removeAssignments', routes.removeAssignments
app.get '/addAssignment', routes.addAssignment
app.get '/deleteAssignment', routes.deleteAssignment
app.get '/updateAssignment', routes.updateAssignment

# Rest assignment routes if ever needed
app.get '/assignments', routes.assignmentIndex
app.get '/assignments/new', routes.newAssignment
app.post '/assignments/new', routes.addAssignment
app.get '/assignments/:id', routes.viewAssignment
app.get '/assignments/:id/edit', routes.editAssignment
app.put '/assignments/:id', routes.updateAssignment
app.del '/assignments/:id', routes.deleteAssignment

app.listen 3000
console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
