require 'lib/setup'

Spine = require('spine')
User  = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')

Nav  = require('controllers/nav')
Page = require('controllers/page')

class App extends Spine.Controller
  constructor: ->
    super

    @nav = new Nav
    @page = new Page

    @append @nav
    @append @page

    AssignmentRecord.fetch()
    User.fetch()
    Assignment.fetch()


    Spine.Route.setup()

module.exports = App
