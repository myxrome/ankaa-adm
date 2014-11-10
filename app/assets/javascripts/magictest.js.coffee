_magictest = ->
  $('form.test-form').submit(->
    $('.test-result').empty()
    $('<div class="loader">Loading...</div>').appendTo('.test-result')
    $('#test-modal').foundation('reveal', 'open');
    $.ajax(
      type: 'POST'
      url: $(this).attr('action')
      data: $(this).serialize()
      dataType: "JSON"
      success: (data) ->
        $('.test-result').empty()
        if data? and not (data.length == 0)
          html = "<table width='100%'>"
          for value in data
            html = "#{html}<tr><td>#{value}</td></tr>"
          html = "#{html}</table>"
          $(html).appendTo('.test-result')
        else
          $("<h1 class='text-center'>No Result</h1>").appendTo('.test-result')
      error: ->
        $('#test-modal').foundation('reveal', 'close');
    )
    return false
  )

$ ->
  _magictest()