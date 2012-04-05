Spine = require('spine')
$     = Spine.$

Users     = require('controllers/users')
Manage    = require('controllers/manage')
Dashboard = require('controllers/dashboard')
class Assignments extends Spine.Controller

class Main extends Spine.Stack

  controllers:
    dashboard: Dashboard
    users: Users
    manage: Manage
    assignments: Assignments

  default: 'dashboard'

module.exports = Main
