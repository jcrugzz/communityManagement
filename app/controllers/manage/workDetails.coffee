Spine = require('spine')
User = require('models/user')
#Assignment = require('models/assignment')
$     = Spine.$


class WorkDetailRow extends Spine.Controller
  className: 'workDetail'
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
    require('views/manage/workDetailRow')(user)

  click: (e) ->
    e.preventDefault()


class WorkDetails extends Spine.Controller
  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/manage/tableHeader')()
    User.bind("refresh", @addAll)

  addOne: (user) =>
    row = new WorkDetailRow(user: user)
    @here.append(row.render().el)

  addAll: =>
    users = User.select (user) ->
      user.wdExempt == false
    @addOne(user) for user in users



module.exports = WorkDetails