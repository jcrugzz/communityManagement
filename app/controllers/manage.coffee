Spine = require('spine')
$     = Spine.$

class Manage extends Spine.Controller
  className: 'manage'

  constructor: ->
    super

    @html require('views/manage.tabs')

module.exports = Manage