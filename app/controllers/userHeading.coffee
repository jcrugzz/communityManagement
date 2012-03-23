Spine = require('spine')
$     = Spine.$

class UserHeading extends Spine.Controller
  className: 'row'

  constructor: ->
    super

    @html require('views/userHeading')()

module.exports = UserHeading
