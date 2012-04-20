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

    @render()

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

  render: ->
     @html require('views/manage.tabs')()

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
        users = User.toJSON()
        console.log users
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
          a.assignments.push(assignments[assNum])
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
        assRecs[assignment.id] = []
        count = 0
        for a in assignees
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          count++
          assRecs[assignment.id].push(a)
          a.assignments.push(assignment)
          done()
      (users, assRecs, callback) ->
        bitchUsers = User.bitchFilter(users)
        bitchUsers.sort(User.bitchSort)
        assignments = Assignment.findAllByAttribute("type", "bitch")
        assignees = bitchUsers[0...5]
        count = 0
        for a in assignees
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          assRecs[assignments[count].id] = a
          a.assignments.push(assignments[count])
          count++

          done()
      (users, assRecs, callback) ->
        midweekUsers = User.midweekFilter(users)
        midweekUsers.sort(User.midweekSort)
        assignments = Assignment.findAllByAttribute("type", "midWeek")
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
          a.assignments.push(assignments[assNum])
          done()
      (users, assRecs, callback) ->
        gmenUsers = User.gmenFilter(users)
        gmenUsers.sort(User.gmenSort)
        assignment = Assignment.findByAttribute("type", "gmen")
        assignees = gmenUsers[0...2]
        count = 0
        for a in assignees
          combine = (user) ->
            if assRecs[assignment.id]
              [assRecs[assignment.id], user]
            else
              user
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          count++
          assRecs[assignment.id] = combine(a)
          a.assignments.push(assignment)
          done()
      (users, assRecs, callback) ->
        soberDriverUsers = User.soberDriverFilter(users)
        soberDriverUsers.sort(User.soberSort)
        assignments = Assignment.findAllByAttribute("name", "Sober Driver")
        assignees = soberDriverUsers[0...4]
        count = 0
        for a in assignees
          combine = (user) ->
            if assRecs[assignments[count].id]
              [assRecs[assignments[count].id], user]
            else
              user
          done = ->
            if count == assignees.length
              callback(null, users, assRecs)
          assRecs[assignments[count].id] = combine(a)
          a.assignments.push(assignments[count])
          count++
          done()

    ], (err, users, assRecs) ->
      console.log users
      console.log assRecs
      assignmentRecords = []
      for key, val of assRecs
        assignment = Assignment.find(key)
        day = ""
        day = assignment.day if assignment?.day?
        findDate = (dayNum) ->
          date = new Date()
          curDayNum = date.getDay()
          curDay = date.getDate()
          if curDayNum == 6
            curDay++
          if dayNum != 0
            curDay += dayNum
          else
            curDay += 7
          date.setDate(curDay)
          date.toDateString()

        dateSwitch = ->
          switch day
            when "Monday" then findDate(1)
            when "Tuesday" then findDate(2)
            when "Wednesday" then findDate(3)
            when "Thursday" then findDate(4)
            when "Friday" then findDate(5)
            when "Saturday" then findDate(6)
            when "Sunday" then findDate(0)
            else
              null

        date = dateSwitch()
        if date != null
          assignmentRecords.push(new AssignmentRecord(users: val, current: true, assignment: [assignment], date: date))
        else
          assignmentRecords.push(new AssignmentRecord(users: val, current: true, assignment: [assignment]))
      console.log assignmentRecords
      success = (data, status, xhr) ->
        User.trigger('ajaxSuccess', null, status, xhr)
        User.trigger('refresh')
        AssignmentRecord.trigger('ajaxSuccess', null, status, xhr)
        AssignmentRecord.trigger('refresh')
      error = (data, statusText, xhr) ->
        User.trigger('ajaxError', null, statusText, xhr)
        AssignmentRecord.trigger('ajaxError', null, statusText, xhr)
      console.log JSON.stringify(users)
      console.log JSON.stringify(assignmentRecords)
      $.ajax(
        type: 'POST'
        data:
          users: JSON.stringify(users)
          assignmentRecords: JSON.stringify(assignmentRecords)
        url: "/autoAssign"
      ).success(success)
      .error(error)




module.exports = Manage