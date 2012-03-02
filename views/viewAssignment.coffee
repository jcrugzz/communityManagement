h1 @title

table class: 'table table-striped', ->
  tr ->
    th -> 'Type:'
    td -> @assignment.type
  tr ->
    th -> 'Day:'
    td ->  text @assignment.day