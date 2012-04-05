Spine = require('spine')
$     = Spine.$

Main = require('controllers/main')

class Page extends Spine.Controller
  className: 'container'

  constructor: ->
    super

    @main = new Main

    @routes
      '/': ->
        @main.dashboard.active()
      '/manage': ->
        @main.manage.active()
      '/users': ->
        @main.users.active()
      '/assignments': ->
        @main.assignments.active()

    @append @main

module.exports = Page