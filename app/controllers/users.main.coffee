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
    "change input[type='checkbox']": 'checkBoxSet'

  elements:
    'form :input': 'form'

  constructor: ->
    super
    @active @change

  render: ->
    @html require('views/form')(@item)
    $(':checkbox').each ->
      console.log(@value)
      if @value is "true"
        console.log(@)
        $(@).val("1")
        $(@).attr("checked", "checked")
      else
        $(@).val("0")
        $(@).removeAttr("checked")


  change: (params) =>
    @item = User.find(params.id)
    @render()

  checkBoxSet: (e) ->
    element = $(e.target)
    if $(element).is(":checked")
      element.val("1")
    else
      element.val("0")
      element.removeAttr("checked")

  submit: (e) ->
    e.preventDefault()
    @log @form

    @item.fromForm(@form).save()
    @log @item
    @navigate('/users', @item.id)


class Main extends Spine.Stack
  className: 'span8 main viewport'

  controllers:
    show: Show
    edit: Edit

module.exports = Main