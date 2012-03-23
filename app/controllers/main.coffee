Spine = require('spine')
$     = Spine.$

Users = require('controllers/users')
Manage = require('controllers/manage')
class Home extends Spine.Controller
class Assignments extends Spine.Controller

class Main extends Spine.Stack

  controllers:
    home: Home
    users: Users
    manage: Manage
    assignments: Assignments

  default: 'users'

module.exports = Main
