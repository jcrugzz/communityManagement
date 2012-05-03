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
      if assRec.current and assRec.assignment[0].type == "workDetail"
        return true
      else
        return false
  @midweekRecords: ->
    records = @select (assRec) ->
      if assRec.current and assRec.assignment[0].type == "midWeek"
        return true
      else
        return false
  @bitchRecords: ->
    records = @select (assRec) ->
      if assRec.current and assRec.assignment[0].type == "bitch"
        return true
      else
        return false
  @gmenRecords: ->
    records = @select (assRec) ->
      if assRec.current and assRec.assignment[0].type == "gmen"
        return true
      else
        return false
  @soberDriverRecords: ->
    records = @select (assRec) ->
      if assRec.current and assRec.assignment[0].name == "Sober Driver"
        return true
      else
        return false

module.exports = AssignmentRecord