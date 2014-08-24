# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
((i, s, o, g, r, a, m) ->
    i["GoogleAnalyticsObject"] = r
    i[r] = i[r] or ->
      (i[r].q = i[r].q or []).push arguments

    i[r].l = 1 * new Date()

    a = s.createElement(o)
    m = s.getElementsByTagName(o)[0]

    a.async = 1
    a.src = g
    m.parentNode.insertBefore a, m
  ) window, document, "script", "//www.google-analytics.com/analytics.js", "ga"
ga('create', 'UA-53906467-1', 'auto')
ga('send', 'pageview')


$(document).ready ->
  $('table').hide()
  $('#search_btn').removeAttr('name')

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
    table = $(this).siblings('table')
    event.preventDefault()
    table.toggle('fast')
