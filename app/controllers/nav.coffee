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
    $(".navbar > .navbar-inner > .container > ul > li").removeClass("active")
    element = $(e.target)
    id = element.attr('id')
    cls = element.attr('class')
    @log cls
    @log element
    if id is "dashboard" or cls is "brand"
      $("#dashboard").parent().addClass("active")
      @navigate('/')
    else
      $("#" + id).parent().addClass("active")
      @navigate("/#{id}")

module.exports = Nav

