Spine = require('spine')
$     = Spine.$

class User extends Spine.Model
  @configure 'User', 'priority',
    'firstName', 'lastName', 'email',
    'workDetailCredits', 'kitchenCredits', 'midweekCredits',
    'soberCredits', 'bitchCredits', 'gmenCredits',
    'cook', 'dishes', 'mealPlan',
    'wdExempt', 'soberPosition', 'assignments'

  @extend Spine.Model.Ajax

  fromForm: (form) ->
    result = {}
    form.each ->
      result[@name] = $(@).val()
    @load(result)

  @filter: (query) ->
    return @all() unless query
    query = query.toLowerCase()
    @select (item) ->
      item.firstName?.toLowerCase().indexOf(query) isnt -1 or
        item.lastName?.toLowerCase().indexOf(query) isnt -1 or
          item.email?.toLowerCase().indexOf(query) isnt -1


  @fromJSON: (objects) ->
    return unless objects
    if typeof objects is 'string'
      objects = JSON.parse(objects)

    # Do some customization...
    if Spine.isArray(objects)
      for object in objects
        object.id = object._id
        delete object._id

    objects
    if Spine.isArray(objects)
      (new @(value) for value in objects)
    else
      new @(objects)

  toJSON: (objects) ->
    atts = @attributes()
    # Do some customization...
    atts._id = atts.id
    delete atts.id
    atts


module.exports = User

