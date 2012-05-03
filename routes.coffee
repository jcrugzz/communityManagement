User = require('./models').User
Assignment = require('./models').Assignment
AssignmentRecord = require('./models').AssignmentRecord
async = require('async')

module.exports =

  index: (req, res) ->
    res.render "index"

  assign: (req, res) ->
    user = JSON.parse(req.body.user)
    assignment = JSON.parse(req.body.assignment)
    console.log user
    async.parallel
      user: (callback) ->
        User.findById user._id, (err, u) ->
          u.assignments = user.assignments
          u.save (err, _u) ->
            if not err?
              callback(null, _u)
      assignmentRecord: (callback) ->
        day = assignment.day if assignment.day?
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

        assRec = new AssignmentRecord()
        assRec.users.push(user)
        assRec.assignment = [assignment]
        assRec.current = true
        assRec.complete = false
        assRec.date = dateSwitch()
        assRec.save (err, rec) ->
          if not err?
            callback(null, rec)
          else
            callback(err, rec)

      (err, results) ->
        if not err?
          res.send results
        else
          res.send err


  autoAssign: (req, res) ->
    console.log req.body
    users = JSON.parse(req.body.users)
    #console.log users
    assignmentRecords = JSON.parse(req.body.assignmentRecords)
    async.parallel
      users: (callback) ->
        count = 0
        for u in users
          done = ->
            if count == users.length
              User.find {}, (err, nUsers) ->
                if not err?
                  callback(null, nUsers)
                else
                  callback(err, nUsers)
          update = (u) ->
            User.findById u._id, (err, user) ->
              console.log u
              async.forEach(u.assignments,
              (item, call) ->
                user.assignments.push(item)
                #console.log user.assignments
                call(null)
              , (err) ->
                user.save (err, nUser) ->
                  if not err?
                    count++
                    done()
                  else
                    callback(err, nUser)
              )
          if u.assignments.length != 0
            update(u)
          else
            count++

      assignmentRecords: (callback) ->
        count = 0
        for rec in assignmentRecords
          console.log rec
          done = ->
            if count == assignmentRecords.length
              AssignmentRecord.find {}, (err, nAssignmentRecords) ->
                if not err?
                  callback(null, nAssignmentRecords)
                else
                  callback(err, nAssignmentRecords)
          new AssignmentRecord(rec).save (err, assignmentRecord) ->
            if not err?
              #console.log assignmentRecord
              count++
              done()
            else
              callback(err, assignmentRecord)
      (err, results) ->
        if not err?
          #console.log results
          res.send results
        else
          console.log err
          res.send err

  checkOff: (req, res) ->
    #console.log req.body
    AssignmentRecord.findById req.body.id, (err, assRec) ->
      assRec.current = false
      assRec.complete = true
      User.find(
        'assignments._id': assRec.assignment[0]._id
      , (err, users) ->
        if not err?
          console.log users
          async.forEach(users, (user, callback) ->
            user.assignments.id(assRec.assignment[0]._id).remove()

            user.save (e) ->
              callback(e)
          , (err) ->
            if not err?
              assRec.save (err, aRec) ->
                if not err?
                  res.send assRec
                else
                  res.send err
            else
              res.send err
          )
        else
          res.send err
      )


  # User Routes

  userIndex: (req, res) ->
    User.find {}, (err, users) ->
      res.send users

  newUser: (req, res) ->
    res.render 'addUser',
      title: 'Create New User'

  addUser: (req, res) ->
    console.log(req.body)
    new User(req.body.user).save (err, user) ->
      console.log(err)
      console.log(user)
      res.send user

  editUser: (req, res) ->
    User.findById req.params.id, (err, user) ->
      console.log(user)
      res.render 'editUser',
        user: user
        title: 'Edit User'

  removeUserAssignments: (req, res) ->
    User.find {}, (err, users) ->
      if not err?
        async.forEach(users,
          (user, callback) ->
            console.log user
            user.assignments = []
            user.save (err, user) ->
              callback(err)
          , (err) ->
            if not err?
              res.send 'Success'
        )
      else
        res.send err

  updateUser: (req, res) ->
   User.findById req.params.id, (err, user) ->
    console.log user
    if not err? and user?
      console.log req.body
      console.log req.params
      user.priority = req.body.priority
      user.firstName = req.body.firstName
      user.lastName = req.body.lastName
      user.soberPosition = req.body.soberPosition
      user.email = req.body.email
      user.cook = req.body.cook
      user.dishes = req.body.dishes
      user.mealPlan = req.body.mealPlan
      user.wdExempt = req.body.wdExempt
      user.newBro = req.body.newBro
      user.assignments = req.body.assignments
      user.save (err, user) ->
        if err?
          console.log err
          console.log 'Failed Update'
          res.send err

        else
          console.log 'Successful Update'
          console.log user
          res.send user

    else
      console.log err
      console.log 'User not Found'
      res.send err

  viewUser: (req, res) ->
    User.findById req.params.id, (err, user) ->
      console.log(user)
      res.render 'viewUser',
        user: user
        title: user.firstName + ' ' + user.lastName

  deleteUser: (req, res) ->
    User.findById req.params.id, (err, user) ->
      user.remove (err) ->
        if not err?
          res.send('success')
        else
          console.log(err)
          res.send(err)


  # Assignment Record Routes
  assignmentRecords: (req, res) ->
    AssignmentRecord.find {}, (err, assignmentRecords) ->
      res.send assignmentRecords

  addRecord: (req, res) ->
    console.log(req.body)
    rec = new AssignmentRecord()
    rec.users.push(req.body.userId)
    rec.assignment = req.body.assId
    rec.current = true

  removeAssignmentRecords: (req, res) ->
    AssignmentRecord.find {}, (err, assignmentRecords) ->
      count = 0
      if err?
        res.send err
      else
        for rec in assignmentRecords
          done = ->
            if count == assignmentRecords.length
              console.log 'count ' + count
              console.log 'length ' + assignmentRecords.length
              res.send 'Success'
          rec.remove (err) ->
            if err?
              res.send err
            else
              count++
            done()


  # Assignment Routes

  assignmentIndex: (req, res) ->
    Assignment.find {}, (err, assignments) ->
      res.send assignments

  removeAssignments: (req, res) ->
    Assignment.find {}, (err, assignments) ->
      count = 0
      if err?
        res.send err
      else
        for assignment in assignments
          done = ->
            if count == assignments.length
              console.log 'count ' + count
              console.log 'length ' + assignments.length
              res.send 'Success'
          assignment.remove (err) ->
            if err?
              res.send err
            else
              count++
            done()

  defaultAssignments: (req, res) ->
    assignments = [ new Assignment(name: 'Heads', type: 'midWeek', day: "Sunday")
                    new Assignment(name: 'Heads', type: 'midWeek', day: "Tuesday")
                    new Assignment(name: 'Heads', type: 'midWeek', day: "Thursday")
                    new Assignment(name: 'Halls', type: 'midWeek', day: "Tuesday")
                    new Assignment(name: 'Halls', type: 'midWeek', day: "Thursday")
                    new Assignment(name: 'Heads', type: 'workDetail', day: "Saturday")
                    new Assignment(name: 'Chapter Room', type: 'workDetail', day: "Saturday")
                    new Assignment(name: 'Halls', type: 'workDetail', day: "Sunday")
                    new Assignment(name: 'LDE', type: 'workDetail', day: "Sunday")
                    new Assignment(name: 'Kitchen', type: 'workDetail', day:"Sunday")
                    new Assignment(name: 'Sober Driver', type: 'soberPosition', day: "Tuesday")
                    new Assignment(name: 'Sober Driver', type: 'soberPosition', day: "Thursday")
                    new Assignment(name: 'Sober Driver', type: 'soberPosition', day: "Friday")
                    new Assignment(name: 'Sober Driver', type: 'soberPosition', day: "Saturday")
                    new Assignment(name: 'Bitch', type: 'bitch', day: "Monday")
                    new Assignment(name: 'Bitch', type: 'bitch', day: "Tuesday")
                    new Assignment(name: 'Bitch', type: 'bitch', day: "Wednesday")
                    new Assignment(name: 'Bitch', type: 'bitch', day: "Thursday")
                    new Assignment(name: 'Bitch', type: 'bitch', day: "Sunday")
                    new Assignment(name: 'Sober Host', type: 'soberPosition')
                    new Assignment(name: 'GMen', type: 'gmen')
    ]
    count = 0
    for assignment in assignments
      next = ->
        if count == assignments.length
          console.log 'count ' +count
          console.log 'length ' + assignments.length
          res.send 'Success'
      assignment.save (err, assignment) ->
        if err?
            res.send err
        else
          count++
        next()


  newAssignment: (req, res) ->
    res.render 'addAssignment',
      title: 'Create New Assignment'

  addAssignment: (req, res) ->
    console.log(req.body)
    new Assignment(req.body).save (err, assignment) ->
      console.log(err)
      console.log(assignment)
      res.send assignment

  editAssignment: (req, res) ->
    Assignment.findById req.params.id, (err, assignment) ->
      console.log(assignment)
      res.render 'editAssignment',
        assignment: assignment
        title: 'Edit Assignment'

  updateAssignment: (req, res) ->
   Assignment.findById req.params.id, (err, assignment) ->
    console.log assignment
    if not err? and assignment?
      console.log req.body.assignment
      assignment.day = req.body.day
      assignment.name = req.body.name
      assignment.type = req.body.type
      assignment.save (err, assignment) ->
        if not err?
          res.send assignment

        else
          console.log err
          res.send 'Failed Update'
    else
      console.log err
      res.send 'Assignment not Found'

  viewAssignment: (req, res) ->
    Assignment.findById req.params.id, (err, assignment) ->
      console.log(assignment)
      res.render 'viewAssignment',
        assignment: assignment
        title: assignment.name

  deleteAssignment: (req, res) ->
    Assignment.findById req.params.id, (err, assignment) ->
      assignment.remove (err) ->
        if not err?
          res.send('success')
        else
          console.log(err)
          res.send(err)








