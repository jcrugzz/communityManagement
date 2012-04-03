require 'lib/setup'

Spine = require('spine')

Nav  = require('controllers/nav')
Page = require('controllers/page')

class App extends Spine.Controller
  constructor: ->
    super

    @nav = new Nav
    @page = new Page

    @append @nav
    @append @page

    Spine.Route.setup()

module.exports = App
