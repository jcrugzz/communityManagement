mongoose = require 'mongoose'

user = mongoose.model 'user', new mongoose.Schema
  id: {type: Number, unique: true }
  name: String

