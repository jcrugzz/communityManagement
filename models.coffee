mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = mongoose.SchemaTypes.ObjectId

Assignment = new Schema()

Assignment.add(
  name: String
  type: String
  date: Date
)


User = new Schema()

User.add(
  priority: Number
  firstName: String
  lastName: String
  email: String
  assignments: [Assignment]
)

module.exports =
  Assignment: mongoose.model('Assignment', Assignment)
  User: mongoose.model('User', User)