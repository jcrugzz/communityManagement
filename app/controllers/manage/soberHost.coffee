Spine = require('spine')
User  = require('models/user')
$     = Spine.$

class SoberHostRow extends Spine.Controller
  tag: 'tr'

  events:
    'click a': 'click'

  constructor: ->
    super
    throw "@user required" unless @user
    @user.bind('update', @render)

  render: (user) =>
    @user = user if user

    @html(@template(@user))
    @

  template: (user) ->
    require('views/manage/soberHostRow')(user)

  click: (e) ->
    e.preventDefault()


class SoberHost extends Spine.Controller
  className: 'soberHost'

  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind('refresh', @addAll)

  addOne: (user) =>
    row = new SoberHostRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    User.each(@addOne)


module.exports = SoberHost