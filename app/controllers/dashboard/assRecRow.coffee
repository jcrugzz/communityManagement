Spine = require('spine')
User = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

class AssRecRow extends Spine.Controller
  tag: 'tr'

  events:
    'click .checkOff': 'checkOff'

  constructor: ->
    super
    throw "@assRec required" unless @assRec
    @assRec.bind("update", @render)
    AssignmentRecord.fetch(@render)

  render: (assRec) =>
    @assRec = assRec if assRec

    @html(@template(@assRec))
    @

  template: (assRec) ->
    require('views/dashboard/row/cleanAssRecRow')(assRec)

  checkOff: (e) ->
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
    @log @assRec

    $.ajax(
      type: 'POST'
      data:
        id: @assRec.id
      url: '/checkOff'
    ).success(success)
    .error(error)

module.exports = AssRecRow