Spine = require('spine')
User  = require('models/user')

class AssignmentRecord extends Spine.Model
  @configure 'AssignmentRecord', 'users',
    'assignment', 'current', 'date', 'complete'

  @extend Spine.Model.Ajax

  #@belongsTo 'user', User

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

  @workDetailRecords: ->
    records = @select (assRec) ->
      if assRec.current and assRec.assignment[0].type == "workDetail" and assRec.assignment[0].name != "Kitchen"
        return true
      else
        return false
  @kitchenRecords: ->
    records = @select (assRec) ->
      if not assRec.current or assRec.assignment[0].name != "Kitchen" or assRec.assignment[0].type != "workDetail"
        return false
      return true
  @midWeekRecords: ->
    records = @select (assRec) ->
      if not assRec.current or assRec.assignment[0].type != "midWeek"
        return false
      return true
  @bitchRecords: ->
    records = @select (assRec) ->
      if not assRec.current or assRec.assignment[0].type != "bitch"
        return false
      return true
  @gmenRecords: ->
    records = @select (assRec) ->
      if not assRec.current or assRec.assignment[0].type != "gmen"
        return false
      return true
  @soberRecords: ->
    records = @select (assRec) ->
      if not assRec.current or assRec.assignment[0].name == "Sober Driver"
        return false
      return true

module.exports = AssignmentRecord