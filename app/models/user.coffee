Spine = require('spine')

class User extends Spine.Model
  @configure 'User', 'priority',
    'name', 'email', 'credits',
    'cook', 'dishes', 'mealPlan',
    'soberPosition'

  @extend Spine.Model.Local

  @filter: (query) ->
    return @all() unless query
    query = query.toLowerCase()
    @select (item) ->
      item.name?.toLowerCase().indexOf(query) isnt -1 or
        item.email?.toLowerCase().indexOf(query) isnt -1


module.exports = User

