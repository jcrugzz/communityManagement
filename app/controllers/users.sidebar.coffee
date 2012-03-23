Spine = require('spine')
User  = require('models/user')
List  = require('spine/lib/list')
$     = Spine.$

class Sidebar extends Spine.Controller
  className: 'span4 sidebar'

  elements:
    '.items': 'items'
    'input': 'search'

  events:
    'keyup input': 'filter'
    'click footer button': 'create'
    'click .item > a': 'click'

  constructor: ->
    super
    @html require('views/sidebar')()

    # Setup a spine list
    @list = new List
      el: @items,
      template: require('views/item'),
      selectFirst: true

    @list.bind 'change', @change

    @active (params) ->
      @list.change(User.find(params.id))

    User.bind('refresh change', @render)

  filter: ->
    @query = @search.val()
    @render()

  render: =>
    users = User.filter(@query)
    @list.render(users)

  change: (item) =>
    @navigate '/users', item.id

  click: (e) ->
    e.preventDefault()

  create: ->
    item = User.create()
    @log item
    @navigate('/users', item.id, 'edit')

module.exports = Sidebar
