User = require('./models').User
Assignment = require('./models').Assignment

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

  # Assignment Routes

  assignmentIndex: (req, res) ->
    Assignment.find {}, (err, assignments) ->
      res.render 'assignmentIndex',
        title: 'Assignment List',
        assignments: assignments

  defaultAssignments: (req, res) ->
    ass0 = new Assignment(name: 'Heads', type: 'MidWeek', day: 'Sunday')
    ass1 = new Assignment(name: 'Heads', type: 'MidWeek', day: 'Tuesday')
    ass2 = new Assignment(name: 'Halls', type: 'MidWeek', day: 'Tuesday')
    ass3 = new Assignment(name: 'Heads', type: 'MidWeek', day: 'Thursday')
    ass4 = new Assignment(name: 'Halls', type: 'MidWeek', day: 'Thursday')
    ass5 = new Assignment(name: 'Heads', type: 'Work Detail', day: 'Saturday')
    ass6 = new Assignment(name: 'Chapter Room', type: 'Work Detail', day: 'Saturday')
    ass7 = new Assignment(name: 'Halls', type: 'Work Detail', day: 'Sunday')
    ass8 = new Assignment(name: 'LDE', type: 'Work Detail', day: 'Sunday')
    ass9 = new Assignment(name: 'Kitchen', type: 'Kitchen', day: 'Sunday')
    ass10 = new Assignment(name: 'Sober Driver', type: 'Sober Position', day: 'Tuesday')
    ass11 = new Assignment(name: 'Sober Driver', type: 'Sober Position', day: 'Thursday')
    ass12 = new Assignment(name: 'Sober Driver', type: 'Sober Position', day: 'Friday')
    ass13 = new Assignment(name: 'Sober Driver', type: 'Sober Position', day: 'Saturday')
    ass14 = new Assignment(name: 'Bitch', type: 'Bitch', day: 'Tuesday')

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








