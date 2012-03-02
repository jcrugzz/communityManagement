h1 @title

p 'Click on a user to go into detail'

a class: 'btn btn-inverse', href: '/users/new', -> 'Add User'
br()

table class: 'table table-striped table-bordered', ->
  thead ->
    tr ->
      th -> 'First Name:'
      th -> 'Last Name:'
      th -> 'Priority:'
      th -> 'Email:'
      th -> 'Sober Position:'
      th -> 'Cook?'
      th -> 'Dishes?'
      th -> 'Meal Plan?'
      th -> 'Actions:'
  tbody ->
      for user in @users
        tr ->
          td -> user.firstName
          td -> user.lastName
          td -> text user.priority
          td -> user.email
          td -> user.soberPosition
          td -> text user.cook
          td -> text user.dishes
          td -> text user.mealPlan
          td ->
            a href: '/users/' + user.id, -> 'View'
            text ' '
            a href: '/users/' + user.id + '/edit', -> 'Edit'
            text ' '
            a class: 'delete', href: '#', docId: user.id, docPath: '/users/', -> 'Delete'