mongoose = require 'mongoose'
Schema = mongoose.Schema

Assignment = new Schema()

Assignment.add(
  name: {type: String, required: true}
  type: {type: String, required: true}
  day: {type: String, required: true, enum: ['Sunday', 'Tuesday', 'Thursday', 'Friday', 'Saturday']}
)

AssignmentRecord = new Schema()

AssignmentRecord.add
  users: [{type: Schema.ObjectId, ref: 'User'}]
  assignment: {type: Schema.ObjectId, ref: 'Assignment'}
  date: Date

User = new Schema()

User.add(
  priority: {type: Number, required: true, default: 0}
  firstName: {type: String, required: true}
  lastName: {type: String, required: true}
  email: {type: String, required: true}
  credits: {type: Number, default: 0, min: 0}
  # Use until Roles implemented into User model for Login purposes
  cook: {type: Boolean, default: false}
  dishes: {type: Boolean, default: false}
  mealPlan: {type: Boolean, default: false}
  soberPosition: {type: String, required: true, enum: ['Sober Host', 'Sober Driver', 'RMTF']}
  assignments: [Assignment]
)

module.exports =
  Assignment: mongoose.model('Assignment', Assignment)
  AssignmentRecord: mongoose.model('AssignmentRecord', AssignmentRecord)
  User: mongoose.model('User', User)