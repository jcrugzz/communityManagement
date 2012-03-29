Spine = require('spine')
User  = require('models/user')
$     = Spine.$

class Show extends Spine.Controller
  #set class
  className: 'show'

  events:
    'click .edit': 'edit'
    'click .delete': 'delete'

  constructor: ->
    super
    #Bind change callback to the active event
    @active @change

  render: ->
    @html require('views/show')(@item)

  change: (params) =>
    @item = User.find(params.id)
    @render()

  edit: ->
    @navigate('/users', @item.id, 'edit')

  delete: ->
    if confirm('Are you sure?')
      @item.destroy()


class Edit extends Spine.Controller

  className: 'edit'

  events:
    'submit form': 'submit'
    'click .save': 'submit'

  elements:
    'form': 'form'

  constructor: ->
    super
    @active @change

  render: ->
    @html require('views/form')(@item)

  change: (params) =>
    @item = User.find(params.id)
    @render()

  submit: (e) ->
    e.preventDefault()
    @item.fromForm(@form).save()
    @log @form
    @log @item.fromForm(@form)
    @navigate('/users', @item.id)


class Main extends Spine.Stack
  className: 'span8 main viewport'

  controllers:
    show: Show
    edit: Edit

module.exports = Main