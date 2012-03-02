doctype 5
html ->
  head ->
    title "#{@title or 'Untitled'}"
    text js('jQuery')
    text css('/bootstrap/css/bootstrap')
    text js('/bootstrap/js/bootstrap')
  body ->
    div '.navbar', ->
      div '.navbar-inner', ->
        div '.container', ->
          a '.brand', href: '/', -> 'ΦΚΘ'
          ul '.nav', ->
            li -> a href: '/manage', -> 'Manage'
            li -> a href: '/users/', -> 'Users'
            li -> a href: '/assignments', -> 'Assignments'
    div '#content.container', -> @body
  footer ->
    text js('client')

