_autocomplete = (scope) ->
  $(scope).find('.autocomplete').autocomplete
    minLength: 2
    source: (request, response) ->
      $.ajax
        url: $('.autocomplete').data('url')
        dataType: "json"
        data:
          name: request.term
        success: (data) ->
          response(data)

$ ->
  $('#descriptions').on 'cocoon:after-insert', (e, insertedItem) ->
    _autocomplete(insertedItem)
  _autocomplete(document)