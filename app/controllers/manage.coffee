Spine = require('spine')
User  = require('models/user')
Assignment = require('models/assignment')
AssignmentRecord = require('models/assignmentRecord')
$     = Spine.$

Main = require('controllers/manage/main')

class Manage extends Spine.Controller
  className: 'manage'

  elements:
    '.tabs > ul > li': 'tabs'

  events:
    'click .tabs > ul > li > a': 'clicked'
    'click #auto-assign': 'assign'

  constructor: ->
    super

    @html require('views/manage.tabs')()

    @main = new Main

    @routes
      '/manage/workDetails': ->
        @main.workDetails.active()
      '/manage/kitchen': ->
        @main.kitchen.active()
      '/manage/midweeks': ->
        @main.midweeks.active()
      '/manage/bitch': ->
        @main.bitch.active()
      '/manage/gmen': ->
        @main.gmen.active()
      '/manage/soberHost': ->
        @main.soberHost.active()
      '/manage/soberDriver': ->
        @main.soberDriver.active()

    @append @main

  clicked: (e) ->
    e.preventDefault()
    @tabs.removeClass('active')
    element = $(e.target)
    element.parent().addClass('active')
    id = element.parent().attr('id')
    @navigate("/manage/#{id}")


  assign: (e) ->
    e.preventDefault()
    async.waterfall [
      (callback) ->
        users = User.all()
        wdUsers = User.workDetailFilter(users)
        wdUsers.sort(User.workDetailSort)
        assignees = wdUsers[0...8]
        assignments = Assignment.select (assignment) ->
          if assignment.type == "workDetail" and assignment.name != "Kitchen"
            return true
        count = 0
        assNum = 0
        assRecs = {}
        for a in assignees
          combine = (user) ->
            if assRecs[assignments[assNum].id]
              [assRecs[assignments[assNum].id], user]
            else
              user
          done = ->
            if count == assignees.length
              callback(null, users, assRecs, assignments)
          if count % 2 == 0 and count != 0
            assNum++
          count++
          assRecs[assignments[assNum].id] = combine(a)
          a.assignments.push(assignments[assNum].id)
          done()
      (users, assRecs, prevAssignments, callback) ->
        # Ghetto way of finding Ids of assignments on same day
        console.log prevAssignments
        assIds = (ass.id for ass in prevAssignments when (ass.name == "Halls" or ass.name == "LDE"))
        console.log assIds
        excludeIds = {}
        console.log assRecs
        for id in assIds
          for i in assRecs[id]
            excludeIds[i.id] = true
        console.log excludeIds
        kitchenUsers = User.kitchenFilter(users, excludeIds)
        kitchenUsers.sort(User.kitchenSort)
        assignment = Assignment.findByAttribute("name", "Kitchen")
        assignees = kitchenUsers[0...3]
        assRecs[assignment.id] = assignees
        count = 0
        for a in assignees
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          count++
          a.assignments.push(assignment.id)
          done()
      (users, assRecs, callback) ->
        bitchUsers = User.bitchFilter(users)
        bitchUsers.sort(User.bitchSort)
        assignments = Assignment.findAllByAttribute("name", "Bitch")
        assignees = bitchUsers[0...5]
        count = 0
        for a in assignees
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          count++
          assRecs[assignments[count].id] = a
          a.assignments.push(assignments[count].id)
          done()
      (users, assRecs, callback) ->
        midweekUsers = User.midweekFilter(users)
        midweekUsers.sort(User.midweekSort)
        assignments = Assignments.select (assignment) ->
          assignment.type == "midWeek"
        assignees = midweekUsers[0...10]
        count = 0
        assNum = 0
        for a in assignees
          combine = (user) ->
            if assRecs[assignments[assNum].id]
              [assRecs[assignments[assNum].id], user]
            else
              user
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          if count % 2 == 0 and count != 0
            assNum++
          count++
          assRecs[assignments[assNum].id] = combine(a)
          a.assignments.push(assignments[assNum].id)
          done()
      (users, assRecs, callback) ->


    ], (err, result) ->
      console.log result

module.exports = Manage