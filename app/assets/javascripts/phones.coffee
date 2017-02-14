# FUNCTIONS
set_price = (phone)->
  phone_name = $(phone).find('td.name a').prop('title')
  url = '/versuscom/' + encodeURIComponent(phone_name) + '/price'
  $.getJSON url, (resp)->
    url = resp.url
    lowestPrice = resp.lowestPrice
    $price = $(phone).find('td.price a')
    if lowestPrice
      $price.text(lowestPrice)
      $price.prop('href', url)
    else
      $price.parent().text(get_translation('no_data'))

set_points = (phone)->
  $phone = $(phone)
  $name = $(phone).find('td.name a')
  lang = $('html').prop('lang')
  phone_name = $name.prop('title')
  url = '/' + lang + '/versuscom/' + encodeURIComponent(phone_name) + '/points'
  $.getJSON url, (resp)->
    $points = $phone.find('td.points a')
    if resp.points > 0
      $points.text(resp.points)
      $points.prop('href', resp.vs_url)
    else
      $points.parent().text(get_translation('no_data'))
    points = $('td.points').map ()->
      text = $(this).text().trim()
      value = parseInt(text)
      if isNaN(value) then text else value
    good_points = points.filter (i, e)->
      e > 0 or e == get_translation('no_data')
    all_elements_are_loaded = points.length == good_points.length
    if all_elements_are_loaded
      sort(points)

sort = (points)->
  points.sort( (a,b)-> a - b ) # reverse sort
  $(points).each (i, point)->
    $('td.points a').each (j, $point)->
      if point == parseInt($($point).text())
        $parent = $($point).parent().parent()
        $('tbody').prepend($parent)
  $('tr.phone').each (i, phone)->
    $(phone).find('td.place').text(i + 1)

get_translation = (key)->
  $('.translations').find("div[data-key='" + key + "']").attr('data-value')

init = ->
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

  $('#search_btn').removeAttr('name')

  $share_results = $('#share_results')
  href = window.location.href
  max_client_width = 620
  cur_client_width = window.innerWidth
  if cur_client_width > max_client_width
    max_chars = 50
    content = get_translation('link_to_share')
  else
    max_chars = 22
    content = ""
  text = decodeURI(href).substring(0, max_chars - 3) + '...'
  content += "<a href='#{href}' target='_blank'>#{text}</a>"
  $share_results.popover({container: '.container', html: true, placement: 'left', 'content': content})

  $('.phone').each (index)->
    set_price(this)
    set_points(this)

# EVENTS
$(document).on "turbolinks:load", ->
  init()

$(document).ready ->
  init()

$(document).on 'click', '#clear_btn', (event)->
  event.preventDefault()
  $('#phone_names').val('')

$(document).on 'click', '#search_btn', (event)->
  if $('#phone_names').val() == ''
    $('#notice').show()
    event.preventDefault()
    $('#notice').text(get_translation('type_phones_into_text_field'))
    delay = (ms, func) -> setTimeout func, ms
    delay 1000, ->
      $('#notice').hide('slow')
