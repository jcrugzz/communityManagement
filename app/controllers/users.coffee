Spine = require('spine')
User  = require('models/user')
$     = Spine.$

Main        = require('controllers/users.main')
Sidebar     = require('controllers/users.sidebar')
UserHeading = require('controllers/userHeading')

class Users extends Spine.Controller
  className: 'row users'

  constructor: ->
    super

    @userHeading = new UserHeading
    @sidebar     = new Sidebar
    @main        = new Main

    @routes
      '/users/:id/edit': (params) ->
        @sidebar.active(params)
        @main.edit.active(params)

      '/users/:id': (params) ->
        @sidebar.active(params)
        @main.show.active(params)

    @append @userHeading
    @append @sidebar, @main

    User.fetch()


module.exports = Users