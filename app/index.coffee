require 'lib/setup'

Spine = require('spine')
Users = require('controllers/users')

class App extends Spine.Controller
  constructor: ->
    super

    @users = new Users
    @append require("views/userHeading")()
    @append @users.active()


    Spine.Route.setup()

module.exports = App
