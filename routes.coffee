module.exports =

  index: (req, res) ->
    res.render "index",
      title: "Assignments."

  manage: (req, res) ->
    res.render "manage",
      title: "Manage"
