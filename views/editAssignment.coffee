h1 @title

p 'Add new Assignment to the Database'

form action: "/assignments/#{@assignment.id}", method: 'POST', ->
  input type: 'hidden', name: '_method', value: 'PUT'
  div class: 'field', ->
    label for: 'name', -> 'Name:'
    input id: 'name', name: 'assignment[name]'
  div class: 'field', ->
    label for: 'type', -> 'Type:'
    input id: 'type', name: 'assignment[type]'
  div class: 'field', ->
    label for: 'day', -> 'Day:'
    input id: 'day', name: 'assignment[day]'
  button class: 'btn', -> 'Update'
