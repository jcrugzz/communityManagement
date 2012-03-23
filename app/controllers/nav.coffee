Spine = require('spine')
$     = Spine.$

class Nav extends Spine.Controller
  className: 'navigation'

  events:
    'click #home': 'home'
    'click #manage': 'manage'
    'click #users': 'users'
    'click #assignments': 'assignments'

  constructor: ->
    super

    @html require('views/nav')()

  home: (e) ->
    e.preventDefault()
    @navigate('/')

  manage: (e) ->
    e.preventDefault()
    @navigate('/manage')

  users: (e) ->
    e.preventDefault()
    @navigate('/users')

  assignments: (e) ->
    e.preventDefault()
    @navigate('/assignments')


module.exports = Nav

