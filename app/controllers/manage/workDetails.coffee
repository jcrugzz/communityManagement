Spine = require('spine')
User = require('models/user')
$     = Spine.$


class WorkDetails extends Spine.Controller

  elements:
    '.items': 'items'

  constructor: ->
    super

    @html



module.exports = WorkDetails