_autoordering =
  up: (scope) ->
    $(scope).find('.table-up').click (e) ->
      c = $(this).parents 'tr'
      p = c.prevAll 'tr:first'
      if p.length > 0
        $.ajax
          type: 'POST'
          url: $(this).data('url')
          success: ->
            c.add(c.nextUntil 'tr').each ->
              p.before this
      e.preventDefault()
  down: (scope) ->
    $(scope).find('.table-down').click (e) ->
      c = $(this).parents 'tr'
      p = c.nextAll 'tr:first'
      if p.length > 0
        $.ajax
          type: 'POST'
          url: $(this).data('url')
          success: ->
            c.add(c.nextUntil 'tr').each ->
              p.after this
      e.preventDefault()

$ ->
  _autoordering.up(document)
  _autoordering.down(document)