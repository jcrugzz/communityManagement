Spine = require('spine')

class AssignmentRecord extends Spine.Model
  @configure 'AssignmentRecord', 'users',
    'assignment', 'date', 'complete'

  @extends Spine.Model.Ajax

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