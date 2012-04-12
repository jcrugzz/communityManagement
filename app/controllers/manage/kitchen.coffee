Spine = require('spine')
User  = require('models/user')
$     = Spine.$


class KitchenRow extends Spine.Controller
  className: 'kitchen'
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
    require('views/manage/kitchenRow')(user)

  click: (e) ->
    e.preventDefault()

class Kitchen extends Spine.Controller

  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind("refresh", @addAll)



  addOne: (user) =>
    row = new KitchenRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    users = User.kitchenUsers()
    users.sort(User.kitchenSort)
    @addOne(user) for user in users


module.exports = Kitchen