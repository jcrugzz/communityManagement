Spine = require('spine')
User  = require('models/user')
$     = Spine.$

Main = require('controllers/manage/main')

class Manage extends Spine.Controller
  className: 'manage'

  elements:
    '.tabs > ul > li': 'tabs'

  events:
    'click .tabs > ul > li > a': 'clicked'
    'click #auto-assign': 'assign'

  constructor: ->
    super

    @html require('views/manage.tabs')()

    @main = new Main

    @routes
      '/manage/workDetails': ->
        @main.workDetails.active()
      '/manage/kitchen': ->
        @main.kitchen.active()
      '/manage/midweeks': ->
        @main.midweeks.active()
      '/manage/bitch': ->
        @main.bitch.active()
      '/manage/gmen': ->
        @main.gmen.active()
      '/manage/soberHost': ->
        @main.soberHost.active()
      '/manage/soberDriver': ->
        @main.soberDriver.active()

    @append @main

  clicked: (e) ->
    e.preventDefault()
    @tabs.removeClass('active')
    element = $(e.target)
    element.parent().addClass('active')
    id = element.parent().attr('id')
    @navigate("/manage/#{id}")

  assign: (e) ->
    e.preventDefault()






module.exports = Manage