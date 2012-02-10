routes = require '../routes'
mongoose = require 'mongoose'
require "should"

describe "routes", ->
  req =
    params: {}
    body: {}
  res =
    redirect: (route) ->
      # Do Nothing
    render: (view, vars) ->
      # Do Nothing

  before (done) ->
    mongoose.connect 'mongodb://localhost/communityManagement-test', ->
      done()
  describe 'index', ->
    it 'should display the index with assignments', (done) ->
      res.render = (view, vars) ->
        view.should.equal 'index'
        vars.title.should.equal 'Assignments.'
        done()
      routes.index(req, res)

  describe 'manage', ->
    it 'should display the manage page with tabbed grids', (done) ->
      res.render = (view, vars) ->
        view.should.equal 'manage'
        vars.title.should.equal 'Manage'
        done()
      routes.manage(req, res)