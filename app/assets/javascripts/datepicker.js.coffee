$ ->
  $("input.datepicker").each (i) ->
    $(this).datepicker
      altFormat: "yy-mm-dd"
      dateFormat: "dd/mm/yy"
      altField: $(this).next()
      showOtherMonths: true
      numberOfMonths: 2
      showButtonPanel: true
      minDate: 0
