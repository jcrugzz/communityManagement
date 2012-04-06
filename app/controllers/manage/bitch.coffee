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

    @html(@template(@user))
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

  sortArray: (a, b) =>
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.bitchCredits < b.bitchCredits
      return -1
    if a.bitchCredits > b.bitchCredits
      return 1
    return 0

  addOne: (user) =>
    row = new BitchRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    users = User.select (user) ->
      if user.cook or not user.mealPlan
        return false
      return true
    users.sort(@sortArray)
    @addOne(user) for user in users


module.exports = Bitch