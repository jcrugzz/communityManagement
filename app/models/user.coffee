Spine = require('spine')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

class User extends Spine.Model
  @configure 'User', 'priority',
    'firstName', 'lastName', 'email',
    'workDetailCredits', 'kitchenCredits', 'midweekCredits',
    'soberCredits', 'bitchCredits', 'gmenCredits',
    'cook', 'dishes', 'mealPlan',
    'wdExempt', 'soberPosition', 'assignments',
    'newBro'

  @extend Spine.Model.Ajax

  #@hasMany 'assignments', AssignmentRecord

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

  # User Sorts

  @gmenSort: (a, b) ->
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.gmenCredits < b.gmenCredits
      return -1
    if a.gmenCredits > b.gmenCredits
      return 1
    return 0

  @soberSort: (a, b) ->
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.soberCredits < b.soberCredits
      return -1
    if a.soberCredits > b.soberCredits
      return 1
    return 0

  @bitchSort: (a, b) ->
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.bitchCredits < b.bitchCredits
      return -1
    if a.bitchCredits > b.bitchCredits
      return 1
    return 0

  @midweekSort: (a, b) ->
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.midweekCredits < b.midweekCredits
      return -1
    if a.midweekCredits > b.midweekCredits
      return 1
    return 0

  @kitchenSort: (a, b) ->
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.kitchenCredits < b.kitchenCredits
      return -1
    if a.kitchenCredits > b.kitchenCredits
      return 1
    return 0

  @workDetailSort: (a, b) ->
    # Sort by priority descending and credits ascending
    if a.priority > b.priority
      return -1
    if a.priority < b.priority
      return 1
    if a.workDetailCredits < b.workDetailCredits
      return -1
    if a.workDetailCredits > b.workDetailCredits
      return 1
    return 0

  #User Sets

  @workDetailUsers: ->
    users = @select (user) ->
      user.wdExempt == false

  @kitchenUsers: ->
    users = @select (user) ->
      if user.dishes == true or user.wdExempt == true
        return false
      return true

  @midweekUsers: ->
    users = @select (user) ->
      user.wdExempt == false

  @bitchUsers: ->
    users = @select (user) ->
      if user.cook or not user.mealPlan
        return false
      return true

  @gmenUsers: ->
    users = @select (user) ->
      user.newBro

  @soberHostUsers: ->
    users = @select (user) ->
      user.soberPosition == "Sober Host"

  @soberDriverUsers: ->
    users = @select (user) ->
      user.soberPosition == "Sober Driver"


module.exports = User

