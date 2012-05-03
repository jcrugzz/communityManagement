Spine = require('spine')
User = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

AssRecRow = require('./assRecRow')


class MidweekAssRecTable extends Spine.Controller
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
    midweekAssRecs = AssignmentRecord.midweekRecords()
    @log midweekAssRecs
    @addOne(assRec) for assRec in midweekAssRecs


module.exports = MidweekAssRecTable
