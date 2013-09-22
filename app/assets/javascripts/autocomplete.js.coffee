$ ->
  $('#descriptions').on 'cocoon:after-insert', (e, insertedItem) ->
      $(insertedItem).find('.autocomplete').autocomplete
        minLength: 2
        source: (request, response) ->
          $.ajax
            url: $('.autocomplete').data('url')
            dataType: "json"
            data:
              name: request.term
            success: (data) ->
              response(data)