Spine = require('spine')
User  = require('models/user')
$     = Spine.$


class Dashboard extends Spine.Controller

  constructor: ->
    super

    @html require('views/dashboard')()


module.exports = Dashboard