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
  $('#search_btn').removeAttr('name')

  $share_results = $('#share_results')
  content = "<input class='form-control input-sm' value='" + window.location.href + "'>"
  $share_results.popover({container: '.container', html: true, placement: 'left', 'content': content})

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

  set_price = (element)->
    phone_name = $(element).prop('title')
    url = encodeURI('/phones/amazon_search?phone_name=' + phone_name)
    $.getJSON url, (resp)->
      url = resp.url
      lowestPrice = resp.lowestPrice
      $price = $(element).parent().parent().find('.price')
      $price.text(lowestPrice)
      $price.prop('href', url)
      $price.show()

  $('.phone_name').each (index)->
    resp = set_price(this)

