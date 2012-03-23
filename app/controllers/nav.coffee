Spine = require('spine')
$     = Spine.$

class Nav extends Spine.Controller
  className: 'navigation'

  events:
    'click .navbar > .navbar-inner > .container a': 'clicked'

  constructor: ->
    super

    @html require('views/nav')()

  clicked: (e) ->
    e.preventDefault()
    element = $(e.target)
    id = element.attr('id')
    if id is "home"
      @navigate('/')
    else
      @navigate("/#{id}")

module.exports = Nav

