Spine = require('spine')
User  = require('models/user')
$     = Spine.$

class SoberDriverRow extends Spine.Controller
  tag: 'tr'

  events:
    'click a': 'click'

  constructor: ->
    super
    throw "@user required" unless @user
    @user.bind("update", @render)

  render: (user) =>
    @user = user if user

    @html(@template(@user))
    @

  template: (user) ->
    require('views/manage/soberDriverRow')(user)

  click: (e) ->
    e.preventDefault()

class SoberDriver extends Spine.Controller
  className: 'soberDriver'

  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind("refresh", @addAll)

  addOne: (user) =>
    row = new SoberDriverRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    User.each(@addOne)


module.exports = SoberDriver