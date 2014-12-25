# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# the compiled file.
#
# WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
# GO AFTER THE REQUIRES BELOW.
#
#= require jquery
#= require jquery_ujs
#= require_tree .
#= require bootstrap-sprockets
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
  href = window.location.href
  max_client_width = 620
  cur_client_width = window.innerWidth
  if cur_client_width > max_client_width
    max_chars = 50
    content = "Link to share: "
  else
    max_chars = 22
    content = ""
  text = decodeURI(href).substring(0, max_chars - 3) + '...'
  content += "<a href='#{href}' target='_blank'>#{text}</a>"
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
    url = '/amazon/' + encodeURIComponent(phone_name)
    $.getJSON url, (resp)->
      url = resp.url
      lowestPrice = resp.lowestPrice
      $price = $(element).parent().parent().find('.price')
      $price.text(lowestPrice)
      $price.prop('href', url)
      $price.show()

  $('.phone_name').each (index)->
    resp = set_price(this)
