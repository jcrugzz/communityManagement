Spine = require('spine')
User = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

AssRecRow = require('./assRecRow')


class WdAssRecTable extends Spine.Controller
  elements:
    'tbody': 'here'

  constructor: ->
    super
    @html require('views/dashboard/table/cleanAssRecTable')()
    AssignmentRecord.bind("refresh", @addAll)

  addOne: (assRec) =>
    row = new AssRecRow(assRec: assRec)
    @here.append(row.render().el)

  addAll: =>
    @here.empty()
    wdAssRecs = AssignmentRecord.workDetailRecords()
    @log wdAssRecs
    @addOne(assRec) for assRec in wdAssRecs


module.exports = WdAssRecTable
