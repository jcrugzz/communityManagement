Spine = require('spine')
User  = require('models/user')
AssignmentRecord = require('models/assignmentRecord')
Assignment = require('models/assignment')
$     = Spine.$

WdAssRecTable = require('controllers/dashboard/wdAssRec')
BitchAssRecTable = require('controllers/dashboard/bitchAssRec')
GmenAssRecTable = require('controllers/dashboard/gmenAssRec')
MidweekAssRecTable = require('controllers/dashboard/midweekAssRec')
SoberDriverAssRecTable = require('controllers/dashboard/soberDriverAssRec')


class Dashboard extends Spine.Controller

  elements:
    '.workDetail': 'workDetail'
    '.kitchen': 'kitchen'
    '.midweeks': 'midweek'
    '.bitch': 'bitch'
    '.gmen': 'gmen'
    '.soberDriver': 'soberDriver'
    '.soberHost': 'soberHost'

  constructor: ->
    super

    @html require('views/dashboard')()

    @wdTable = new WdAssRecTable()

    @workDetail.append(@wdTable.el)

    @bitchTable = new BitchAssRecTable()

    @bitch.append(@bitchTable.el)

    @gmenTable = new GmenAssRecTable()

    @gmen.append(@gmenTable.el)

    @midweekTable = new MidweekAssRecTable()

    @midweek.append(@midweekTable.el)

    @soberDriverTable = new SoberDriverAssRecTable()

    @soberDriver.append(@soberDriverTable.el)


module.exports = Dashboard