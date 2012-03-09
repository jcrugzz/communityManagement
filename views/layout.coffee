doctype 5
html ->
  head ->
    title "#{@title or 'Untitled'}"
    link rel: 'stylesheet', href: '/css/bootstrap.css'
    link rel: 'stylesheet', href: '/css/index.css'
    script type: 'text/javascript', src: '/application.js'
    coffeescript ->
      jQuery = require("jqueryify")
      exports = this
      $ = jQuery
      $ ->
        App = require("index")
        exports.app = new App(el: $("#page"))
  body ->
    div '.navbar', ->
      div '.navbar-inner', ->
        div '.container', ->
          a '.brand', href: '/', -> 'ΦΚΘ'
          ul '.nav', ->
            li -> a href: '/manage', -> 'Manage'
            li -> a href: '/users/', -> 'Users'
            li -> a href: '/assignments', -> 'Assignments'
  div "#page.container", ->

