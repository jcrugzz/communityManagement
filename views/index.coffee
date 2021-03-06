doctype 5
html ->
  head ->
    title "#{@title or 'Untitled'}"
    link rel: 'stylesheet', href: '/css/bootstrap.css'
    link rel: 'stylesheet', href: '/css/index.css'
    script type: 'text/javascript', src: '/js/async.js'
    script type: 'text/javascript', src: '/application.js'
    coffeescript ->
      jQuery = require("jqueryify")
      exports = this
      $ = jQuery
      $ ->
        App = require("index")
        exports.app = new App(el: $("body"))
  body ->

  footer ->
    script type: 'text/javascript', src: '/js/bootstrap-dropdown.js'