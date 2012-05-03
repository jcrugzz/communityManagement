Spine = require('spine')
User = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

class WorkDetailRow extends Spine.Controller
  className: 'workDetail'
  tag: 'tr'

  events:
    'click a': 'click'
    'click ul > li > a': 'assign'

  constructor: ->
    super
    throw "@user required" unless @user
    @user.bind("update", @render)
    User.fetch(@render)

  render: (user) =>
    @user = user if user

    @html(@template(@user))
    @

  template: (user) ->
    require('views/manage/workDetailRow')(user)

  click: (e) ->
    e.preventDefault()

  assign: (e) ->
    e.preventDefault()
    element = $(e.target)
    name = element.attr("name")
    type = element.attr("type")
    assignments = Assignment.select (ass) ->
      if ass.name == name and ass.type == type
        return true
      else
        return false
    @log assignments
    @user.assignments.push(assignments[0])


    success = (data, status, xhr) ->
      User.trigger('ajaxSuccess', null, status, xhr)
      AssignmentRecord.trigger('ajaxSuccess', null, status, xhr)
      AssignmentRecord.fetch()
      AssignmentRecord.trigger("refresh")
      User.fetch()
      User.trigger("refresh")
    error = (data, statusText, xhr) ->
      User.trigger('ajaxError', null, statusText, xhr)
      AssignmentRecord.trigger('ajaxError', null, statusText, xhr)
    $.ajax(
      type: 'POST'
      data:
        user: JSON.stringify(@user)
        assignment: JSON.stringify(assignments[0])
      url: "/assign"
    ).success(success)
    .error(error)



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
    users = User.workDetailUsers()
    users.sort(User.workDetailSort)
    @addOne(user) for user in users



module.exports = WorkDetails