$ ->
  $('#miner_category_id').change ->
    $('#miner_name').val($('#miner_category_id option:selected').text())