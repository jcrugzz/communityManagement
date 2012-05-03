Spine = require('spine')
User  = require('models/user')
$     = Spine.$

class BitchRow extends Spine.Controller
  className: 'bitch'
  tag: 'tr'

  events:
    'click a': 'click'

  constructor: ->
    super
    throw "@user required" unless @user
    @user.bind("update", @render)

  render: (user) =>
    @user = user if user

    @html @template(@user)
    @

  template: (user) ->
    require('views/manage/bitchRow')(user)

  click: (e) ->
    e.preventDefault()

class Bitch extends Spine.Controller

  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind('refresh', @addAll)

  addOne: (user) =>
    row = new BitchRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    users = User.bitchUsers()
    users.sort(User.bitchSort)
    @addOne(user) for user in users


module.exports = Bitch