# FUNCTIONS
update_title = ()->
  $(document).prop(
    'title',
    $('.phone').map(()-> $(this).data('name')).toArray().join(' vs ')
  )

is_points_loaded = ()->
  $points = $('.points')
  total = $points.length
  loaded = $points.filter(()-> $(this).text().indexOf(get_translation('loading')) == -1).length
  $points.length == loaded

update_progress = ()->
  $points = $('.points')
  total = $points.length
  loaded = $points.filter(()-> $(this).text().indexOf(get_translation('loading')) == -1).length
  progress = loaded / total * 100
  $progress = $('.progress-bar')
  $progress.attr('aria-valuenow', progress)
  $progress.css('width', "#{progress}%")
  $progress.find('.sr-only').text("#{progress}%")
  if loaded == total
    $('.modal').modal('hide')

update_row_data = (row, data)->
  $row = $(row)
  $row.data(data)

format_row_data = (row)->
  $row = $(row)
  $name = $row.find('.name')
  $points = $row.find('.points')
  points_title = get_translation('compare_phone_with_top_phone').replace('%{name}', $row.data('name'))

  $name.empty()
  a = "<a href='#{$row.data('url')}' target='_blank' title='#{$row.data('name')}'>#{$row.data('name')}</a>"
  $name.append(a)

  points = $row.data('points')
  $points.empty()
  if parseInt(points) > 0
    points = points
    a = "<a href='#{$row.data('vs_url')}' target='_blank' title='#{points_title}'>#{points}</a>"
  else
    a = get_translation('no_data')
  $points.append(a)

format_row_price = (row)->
  $row = $(row)
  $price = $row.find('.price')
  price_title = get_translation('possible_price_for_phone').replace('%{name}', $row.data('name'))

  $price.empty()
  price = $row.data('price')
  if price == null
    a = get_translation('no_data')
  else
    a = "<a href='#{$row.data('amazon_url')}' target='_blank' title='#{price_title}'>#{price}</a>"
  $price.append(a)

update_prices = ()->
  $('.phone').each ()->
    set_price($(this))

set_price = (row)->
  $row = $(row)
  phone_name = $row.data('query')
  url = '/versuscom/' + encodeURIComponent(phone_name) + '/price'
  $.ajax url,
    dataType: 'json'
    success:  (resp)->
      url = resp.url
      lowestPrice = resp.lowestPrice
      $price = $(row).find('td.price')
      if lowestPrice
        update_row_data($row, {'price': lowestPrice, 'amazon_url': url})
      else
        $price.text(get_translation('no_data'))
      format_row_price($row)
    error: (jqxhr, text_status, error)->
      if jqxhr.status == 503
        set_price(row)

set_points_and_price = (phone)->
  $phone = $(phone)
  phone_name = $(phone).data('query')
  lang = $('html').prop('lang')
  url = '/' + lang + '/versuscom/' + encodeURIComponent(phone_name) + '/points'
  $.ajax url,
    dataType: 'json'
    success:  (resp)->
      if resp.status == '500'
        set_points_and_price(phone)
      else
        update_row_data($phone, resp)
        format_row_data($phone)
        update_title()
        update_progress()
        if is_points_loaded()
          sort_phones()
          update_prices()
    error: (jqxhr, text_status, error)->
      if jqxhr.status == 503
        set_points_and_price(phone)

sort_phones = ()->
  $phones = $('.phone')
  points = $phones.map ()->
    $(this).data('points')
  points.sort( (a,b)-> a - b ) # reverse sort
  $(points).each (i, point)->
    $phones.each (j, $phone)->
      $phone = $($phone)
      if point == parseInt($phone.data('points'))
        $('tbody').prepend($phone)
  $('tr.phone').each (i, phone)->
    $(phone).find('td.place').text(i + 1)

get_translation = (key)->
  $('.translations').find("div[data-key='" + key + "']").data('value')

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

  $phones = $('.phone')
  if $phones.length > 0
    $('.modal').modal('show')
  else
    $('.modal').modal('hide')

  $phones.each (index)->
    set_points_and_price(this)

# EVENTS
$(document).on "turbolinks:load", ->
  init()

# needed for heroku:
$(document).on "ready", ->
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
