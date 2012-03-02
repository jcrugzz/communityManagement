h1 @title

p 'List of Assignments'

a class: 'btn btn-inverse', href: '/assignments/new', -> 'Add Assignment'
br()

table class: 'table table-striped table-bordered', ->
  thead ->
    tr ->
      th -> 'Name'
      th -> 'Type'
      th -> 'Day'
  tbody ->
    for assignment in @assignments
      td -> assignment.name
      td -> assignment.type
      td -> assignment.day
      td ->
        a href: "/assignments/#{assignment.id}", -> 'View'
        text ' '
        a href: "/assignments/#{assignment.id}/edit", -> 'Edit'
        text ' '
        a class: 'delete', href: "#", docId: assignment.id, docPath: '/assignments/', -> 'Delete'