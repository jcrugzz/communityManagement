h1 @title

table class: 'table table-striped', ->
  tr ->
    th -> 'Email:'
    td -> @user.email
  tr ->
    th -> 'Priority:'
    td ->  text @user.priority
