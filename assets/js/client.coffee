$ = jQuery
$ ->
  deleteDoc = (id, path) ->
    console.log(id)
    console.log(path)
    $.ajax
      url: path + id
      type: 'DELETE'
      success: (data, textStatus, jqXHR) ->
        console.log("Post resposne:")
        console.dir(data)
        console.log(textStatus)
        console.dir(jqXHR)

  $('.delete').click (e) ->
    e.preventDefault()
    docId = $(@).attr('docId')
    docPath = $(@).attr('docPath')
    console.log(docId)
    console.log(docPath)
    deleteDoc(docId, docPath)
    location.reload()


