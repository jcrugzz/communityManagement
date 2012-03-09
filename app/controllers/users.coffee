Spine = require('spine')
User  = require('models/user')
$     = Spine.$

Main    = require('controllers/users.main')
Sidebar = require('controllers/users.sidebar')

class Users extends Spine.Controller
  className: 'row users'

  constructor: ->
    super

    @sidebar  = new Sidebar
    @main     = new Main

    @routes
      '/users/:id/edit': (params) ->
        @sidebar.active(params)
        @main.edit.active(params)

      '/users/:id': (params) ->
        @sidebar.active(params)
        @main.show.active(params)

      '/users': (params) ->
        @sidebar.active(params)


    @append @sidebar, @main

    User.fetch()

module.exports = Users