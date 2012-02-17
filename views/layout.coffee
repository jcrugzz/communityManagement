doctype 5
html ->
  head ->
    title "#{@title or 'Untitled'}"
    link rel: 'stylesheet', href: '/stylesheets/bootstrap.css'
  body ->
    div '.navbar', ->
      div '.navbar-inner', ->
        div '.container', ->
          a '.brand', href: '/', -> 'ΦΚΘ'
          ul '.nav', ->
            li -> a href: '/manage', -> 'Manage'
    div '#content.container', -> @body

