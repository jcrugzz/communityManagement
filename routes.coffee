User = require('./models').User
Assignment = require('./models').Assignment
AssignmentRecord = require('./models').AssignmentRecord

module.exports =

  index: (req, res) ->
    res.render "index"

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
          next = ->
            if count == assignments.length
              console.log 'count ' + count
              console.log 'length ' + assignments.length
              res.send 'Success'
          assignment.remove (err) ->
            if err?
              res.send err
            else
              console.log
              count++
            next()

  defaultAssignments: (req, res) ->
    assignments = [ new Assignment(name: 'Heads', type: 'midWeek')
                    new Assignment(name: 'Halls', type: 'midWeek')
                    new Assignment(name: 'Heads', type: 'workDetail')
                    new Assignment(name: 'Chapter Room', type: 'workDetail')
                    new Assignment(name: 'Halls', type: 'workDetail')
                    new Assignment(name: 'LDE', type: 'workDetail')
                    new Assignment(name: 'Kitchen', type: 'workDetail')
                    new Assignment(name: 'Sober Driver', type: 'soberPosition')
                    new Assignment(name: 'Bitch', type: 'bitch')
                    new Assignment(name: 'Sober Host', type: 'soberPosition')
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
    new Assignment(req.body.assignment).save (err, assignment) ->
      console.log(err)
      console.log(assignment)
      res.redirect '/assignments'

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
      assignment.name = req.body.assignment
      assignment.save (err, assignment) ->
        if err?
          console.log err
          console.log 'Failed Update'

        else
          console.log 'Successful Update'

        res.redirect '/assignments'
    else
      console.log err
      console.log 'User not Found'

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








