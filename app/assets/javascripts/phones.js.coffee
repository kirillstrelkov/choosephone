# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $('table').hide()

  $('#clear_btn').click (event)->
    event.preventDefault()
    $('#phone_names').val('')

  $('#search_btn').click (event)->
    if $('#phone_names').val() == ''
      $('#notice').show()
      event.preventDefault()
      $('#notice').text('Please type interested phones in text field.')
      delay = (ms, func) -> setTimeout func, ms
      delay 1000, ->
        $('#notice').hide('slow')
  
  $('.toggle_tech_data').prop('disabled', false)
  $('.toggle_tech_data').click (event)->
    event.preventDefault()
    $(this).siblings('table').toggle('fast')
