Given(/^I am on main page$/) do
  visit 'phones/index'
end

Then(/^I should see main form$/) do
  assert page.has_css? 'form'
end

Then(/^I should see textarea field$/) do
  assert page.has_css? 'textarea'
end

Then(/^I should see '(.+)' button$/) do |name|
  assert page.has_button? name
end

Then(/^I should not see '(.+)' button$/) do |name|
  assert page.has_button? name, :visible => false
end

When(/^I fill in textarea with '(.+)'$/) do |phones|
  fill_in('phone_names', :with => phones)
end

When(/^I click '(.+)' button$/) do |text|
  click_button(text)
end

Then(/^I should see '(.+)' before '(.+)'$/) do |phone1, phone2|
  assert page.body.index(phone1) < page.body.index(phone2)
end

Then(/^I should see '(.+)' on page$/) do |text|
  assert page.has_text? text
end

Then(/^I should not see '(.+)' on page$/) do |text|
  assert page.has_no_text? text
end

Then(/^'(.+)' field value should be '(.*)'$/) do |selector, value|
  assert_equal page.find(selector).value, value
end

Then(/^I should not see '(.+)' in table$/) do |text|
  assert page.find('ul').not_to have_text(text)
end

Then(/^I should not see noscript message$/) do
  assert page.has_css? 'noscript', :visible => false
end

Then(/^points are correct for '(.+)'$/) do |phone_name|
  row = page.find(:xpath, "//*[@title='#{phone_name}']/../..")
  points = row.first(:css, '.phone_points').text
  assert_match(/^\d+$/, points)
  assert points.to_i > 0
end
