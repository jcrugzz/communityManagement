h1 @title

p 'Edit User in Database'

form action: '/users/' + @user.id, method: 'POST', ->
  input type: 'hidden', name: '_method', value: 'PUT'
  div class: 'field', ->
    label for: 'priority', -> 'Priority:'
    input id: 'priority', name: 'user[priority]', value: @user.priority

  div class: 'field', ->
    label for: 'firstName', -> 'First Name:'
    input id: 'firstName', name: 'user[firstName]', value: @user.firstName

  div class: 'field', ->
    label for: 'lastName', -> 'Last Name:'
    input id: 'lastName', name: 'user[lastName]', value: @user.lastName

  div class: 'field', ->
    label for: 'email', -> 'Email:'
    input id: 'email', name: 'user[email]', value: @user.email

  div class: 'field', ->
    label for: 'soberPosition', -> 'Sober Position:'
    input id: 'soberPosition', name: 'user[soberPosition]', value: @user.soberPosition

  div class: 'field', ->
    label '.checkbox', ->
      input type: 'checkbox', name: 'user[cook]', checked: @user.cook
      text 'Cook?'

  div class: 'field', ->
    label 'checkbox', ->
      input type: 'checkbox', name: 'user[dishes]', checked: @user.dishes
      text 'Dishes?'

  div class: 'field', ->
    label '.checkbox', ->
      input type: 'checkbox', name: 'user[mealPlan]', checked: @user.mealPlan
      text 'Meal Plan?'

  button class: 'btn', -> 'Update'