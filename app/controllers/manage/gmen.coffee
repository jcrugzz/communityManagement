Spine = require('spine')
User  = require('models/user')
$     = Spine.$

class GMenRow extends Spine.Controller
  className: 'gmen'
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
    require('views/manage/gmenRow')(user)

  click: (e) ->
    e.preventDefault()

class GMen extends Spine.Controller
  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind('refresh', @addAll)


  addOne: (user) =>
    row = new GMenRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    users = User.gmenUsers()
    users.sort(User.gmenSort)
    @addOne(user) for user in users


module.exports = GMen