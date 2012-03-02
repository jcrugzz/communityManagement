h1 @title

p 'Add User to the Database'

form action: '/users/new', method: 'post', ->
  div class: 'field', ->
    label for: 'priority', -> 'Priority:'
    input id: 'priority', name: 'user[priority]'

  div class: 'field', ->
    label for: 'firstName', -> 'First Name:'
    input id: 'firstName', name: 'user[firstName]'

  div class: 'field', ->
    label for: 'lastName', -> 'Last Name:'
    input id: 'lastName', name: 'user[lastName]'

  div class: 'field', ->
    label for: 'email', -> 'Email:'
    input id: 'email', name: 'user[email]'

  div class: 'field', ->
    label for: 'soberPosition', -> 'Sober Position:'
    input id: 'soberPosition', name: 'user[soberPosition]'

  div class: 'field', ->
    label '.checkbox', ->
      input type: 'checkbox', name: 'user[cook]',
      text 'Cook?'

  div class: 'field', ->
    label 'checkbox', ->
      input type: 'checkbox', name: 'user[dishes]'
      text 'Dishes?'

  div class: 'field', ->
    label '.checkbox', ->
      input type: 'checkbox', name: 'user[mealPlan]'
      text 'Meal Plan?'

  button class: 'btn', -> 'Save'