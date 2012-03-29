Spine = require('spine')
$     = Spine.$

WorkDetails = require('controllers/manage/workDetails')
Kitchen     = require('controllers/manage/kitchen')
MidWeeks    = require('controllers/manage/midweeks')
Bitch       = require('controllers/manage/bitch')
GMen        = require('controllers/manage/gmen')
SoberHost   = require('controllers/manage/soberHost')
SoberDriver = require('controllers/manage/soberDriver')

class Main extends Spine.Stack

  controllers:
    workDetails: WorkDetails
    kitchen: Kitchen
    midweeks: MidWeeks
    bitch: Bitch
    gmen: GMen
    soberHost: SoberHost
    soberDriver: SoberDriver

  default: 'workDetails'


module.exports = Main
