_activetoggler = (scope) ->
  $(scope).on('change', '.active-toggle', ->
    $.ajax
      type: 'POST'
      url: $(this).data('url')
      error: ->
        $(this).prop('checked', !$(this).prop('checked'))
  )

$ ->
  $('input:not([checked])').prop('checked', false)
  $('input[checked]').prop('checked', true)
  _activetoggler(document)