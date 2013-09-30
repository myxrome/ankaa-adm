_autoordering =
  add: (scope) ->
    index = $('.nested-fields').filter ->
      $(this).is ':visible'
    .index(scope) + 1
    $(scope).find('.hidden').val index
  remove: (scope) ->
    $(scope).nextAll().filter ->
      $(this).is ':visible'
    .each ->
        e = $(this).find '.hidden'
        e.val(e.val() - 1)
  swap: (l, r) ->
    lval = l.val()
    rval = r.val()
    l.val rval
    r.val lval
  up: (scope) ->
    $(scope).find('.up').click (e) ->
      c = $(this).parents '.nested-fields'
      p = c.prevAll '.nested-fields:visible:first'
      if p.length > 0
        _autoordering.swap c.find('.hidden'), p.find('.hidden')
        c.add(c.nextUntil '.nested-fields').each ->
          p.before this
      e.preventDefault()
  down: (scope) ->
    $(scope).find('.down').click (e) ->
      c = $(this).parents '.nested-fields'
      p = c.nextAll '.nested-fields:visible:first'
      if p.length > 0
        _autoordering.swap c.find('.hidden'), p.find('.hidden')
        c.add(c.nextUntil '.nested-fields').each ->
          p.after this
      e.preventDefault()

$ ->
  $('#descriptions').on 'cocoon:after-insert', (e, insertedItem) ->
    _autoordering.add(insertedItem)
    _autoordering.up(insertedItem)
    _autoordering.down(insertedItem)
  $('#descriptions').on 'cocoon:before-remove', (e, insertedItem) ->
    _autoordering.remove(insertedItem)
  _autoordering.up(document)
  _autoordering.down(document)