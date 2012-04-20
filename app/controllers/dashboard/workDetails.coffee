Spine = require('spine')
User = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

class WdAssRecRow extends Spine.Controller
  tag: 'tr'

  constructor: ->
    super
    throw "@assRec required" unless @assRec
    @assRec.bind("update", @render)

  render: (assRec) =>
    @assRec = assRec if assRec

    @html(@template(@assRec))
    @

  template: (assRec) ->
    require('views/dashboard/row/wdAssRecRow')(assRec)


class WdAssRecTable extends Spine.Controller

  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/dashboard/table/wdAssRecTable')()
    AssignmentRecord.bind("refresh", @addAll)

  addOne: (assRec) =>
    row = new WdAssRecRow(assRec: assRec)
    @here.append(row.render().el)

  addAll: =>
    wdAssRecs = AssignmentRecord.workDetailRecords()
    @log wdAssRecs
    @log 'bueler?'
    @addOne(assRec) for assRec in wdAssRecs


module.exports = WdAssRecTable
