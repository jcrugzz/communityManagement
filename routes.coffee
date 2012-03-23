User = require('./models').User
Assignment = require('./models').Assignment

module.exports =

  index: (req, res) ->
    res.render "index"

  # User Routes

  userIndex: (req, res) ->
    User.find {}, (err, users) ->
      res.render 'userIndex',
        title: 'User List',
        users: users

  newUser: (req, res) ->
    res.render 'addUser',
      title: 'Create New User'

  addUser: (req, res) ->
    console.log(req.body)
    new User(req.body.user).save (err, user) ->
      console.log(err)
      console.log(user)
      res.redirect '/users'

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
      console.log req.body.user
      user.priority = req.body.user.priority
      user.firstName = req.body.user.firstName
      user.lastName = req.body.user.lastName
      user.email = req.body.user.email
      user.cook = req.body.user.cook
      user.dishes = req.body.user.dishes
      user.mealPlan = req.body.user.mealPlan
      user.save (err, user) ->
        if err?
          console.log err
          console.log 'Failed Update'

        else
          console.log 'Successful Update'

        res.redirect '/users'
    else
      console.log err
      console.log 'User not Found'

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








