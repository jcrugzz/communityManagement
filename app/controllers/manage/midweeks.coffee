Spine = require('spine')
User  = require('models/user')
$     = Spine.$

class MidWeekRow extends Spine.Controller
  className: 'midweek'
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
    require('views/manage/midweekRow')(user)

  click: (e) ->
    e.preventDefault()

class MidWeeks extends Spine.Controller

  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind("refresh", @addAll)

  addOne: (user) =>
    row = new MidWeekRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    User.each(@addOne)


module.exports = MidWeeks