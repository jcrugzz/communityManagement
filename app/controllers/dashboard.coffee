Spine = require('spine')
User  = require('models/user')
AssignmentRecord = require('models/assignmentRecord')
Assignment = require('models/assignment')
$     = Spine.$

WdAssRecTable = require('controllers/dashboard/workDetails')


class Dashboard extends Spine.Controller

  elements:
    '.workDetail': 'workDetail'
    '.kitchen': 'kitchen'
    '.midweeks': 'midweek'
    '.bitch': 'bitch'
    '.gmen': 'gmen'
    '.soberDriver': 'soberDriver'

  constructor: ->
    super

    @html require('views/dashboard')()

    @wdTable = new WdAssRecTable()

    @workDetail.append(@wdTable.el)



module.exports = Dashboard