Spine = require('spine')

class User extends Spine.Model
  @configure 'User', 'priority',
    'firstName', 'lastName', 'email',
    'credits', 'cook', 'dishes',
    'mealPlan', 'soberPosition'

  @extend Spine.Model.Ajax

  @filter: (query) ->
    return @all() unless query
    query = query.toLowerCase()
    @select (item) ->
      item.name?.toLowerCase().indexOf(query) isnt -1 or
        item.email?.toLowerCase().indexOf(query) isnt -1

  @fromJSON: (objects) ->
    return unless objects
    if typeof objects is 'string'
      objects = JSON.parse(objects)

    # Do some customization...


    objects
    if Spine.isArray(objects)
      (new @(value) for value in objects)
    else
      new @(objects)

  toJSON: (objects) ->
    data = @attributes()
    # Do some customization...


module.exports = User

