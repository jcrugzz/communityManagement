Spine = require('spine')
User = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

class SoberDriverAssRecRow extends Spine.Controller
  tag: 'tr'

  events:
    'click .checkOff': 'checkOff'

  constructor: ->
    super
    throw "@assRec required" unless @assRec
    @assRec.bind("update", @render)

  render: (assRec) =>
    @assRec = assRec if assRec

    @html(@template(@assRec))
    @

  template: (assRec) ->
    require('views/dashboard/row/soberAssRecRow')(assRec)

  checkOff: (e) ->
    success = (data, status, xhr) ->
      User.trigger('ajaxSuccess', null, status, xhr)
      AssignmentRecord.trigger('ajaxSuccess', null, status, xhr)
      AssignmentRecord.fetch()
      AssignmentRecord.trigger("refresh")
      User.fetch()
    error = (data, statusText, xhr) ->
      User.trigger('ajaxError', null, statusText, xhr)
      AssignmentRecord.trigger('ajaxError', null, statusText, xhr)
    @log @assRec
    $.ajax(
      type: 'PUT'
      data:
        id: @assRec.id
      url: '/checkOff'
    ).success(success)
    .error(error)


class SoberDriverAssRecTable extends Spine.Controller
  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/dashboard/table/soberAssRecTable')()
    AssignmentRecord.bind("refresh", @addAll)

  addOne: (assRec) =>
    row = new SoberDriverAssRecRow(assRec: assRec)
    @here.append(row.render().el)

  addAll: =>
    @here.empty()
    soberDriverAssRecs = AssignmentRecord.soberDriverRecords()
    @log soberDriverAssRecs
    @addOne(assRec) for assRec in soberDriverAssRecs


module.exports = SoberDriverAssRecTable
