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
  priority: {type: Number, default: 0}
  firstName: {type: String}
  lastName: {type: String}
  email: {type: String}
  workDetailCredits: {type: Number, default: 0, min: 0}
  kitchenCredits: {type: Number, default: 0, min: 0}
  midweekCredits: {type: Number, default: 0, min: 0}
  soberCredits: {type: Number, default: 0, min: 0}
  bitchCredits: {type: Number, default: 0, min: 0}
  gmenCredits: {type: Number, default: 0, min: 0}
  # Use until Roles implemented into User model for Login purposes
  cook: {type: Boolean, default: false}
  dishes: {type: Boolean, default: false}
  mealPlan: {type: Boolean, default: false}
  wdExempt: {type: Boolean, default: false}
  soberPosition: {type: String}
  assignments: [Assignment]
)

module.exports =
  Assignment: mongoose.model('Assignment', Assignment)
  AssignmentRecord: mongoose.model('AssignmentRecord', AssignmentRecord)
  User: mongoose.model('User', User)