mongoose = require 'mongoose'
User = require('models').User

describe 'User', ->
  before (done) ->
    mongoose.connect 'mongodb://localhost/communityManagementTest', ->
      User.remove(done)
  it 'should create a new User', (done) ->
    user = new User(priority: 1000, firstName: 'John', lastName: 'Doe', email: 'jdoe@example.com')
    user.save ->
      User.findOne _id: user.id, (err, retrievedUser) ->
        #TODO: Find why this first one makes the test fail(Number issue mongoose and should)
        retrievedUser.priority.should.eql 1000
        retrievedUser.firstName.should.eql 'John'
        retrievedUser.lastName.should.eql 'Doe'
        retrievedUser.email.should.eql 'jdoe@example.com'
        done()