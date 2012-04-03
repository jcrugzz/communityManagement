Spine = require('spine')
User  = require('models/user')
$     = Spine.$

Main = require('controllers/main')

class Page extends Spine.Controller
  className: 'container'

  constructor: ->
    super

    @main = new Main

    @routes
      '/': ->
        @main.home.active()
      '/manage': ->
        @main.manage.active()
      '/users': ->
        @main.users.active()
      '/assignments': ->
        @main.assignments.active()

    @append @main

    User.fetch()

module.exports = Page