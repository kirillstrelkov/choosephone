# frozen_string_literal: true

Given(/^I am on main page$/) do
  visit('/')
end

Then(/^I should see main form$/) do
  assert_selector('form', count: 1)
end

Then(/^I should see textarea field$/) do
  assert_selector('textarea', count: 1)
end

Then(/^I should see '(.+)' button$/) do |name|
  assert_selector('button', text: name, count: 1)
end

Then(/^I should not see '(.+)' button$/) do |name|
  assert page.has_button? name, visible: false
end

When(/^I fill in textarea with '(.+)'$/) do |phones|
  fill_in('phone_names', with: phones)
end

When(/^I click '(.+)' button$/) do |text|
  click_button(text)
end

Then(/^I should see '(.+)' before '(.+)'$/) do |phone1, phone2|
  text = page.text
  assert_text(phone1)
  assert_text(phone2)
  expect(text.index(phone1)).to be < text.index(phone2)
end

Then(/^I should see '(.+)' on page$/) do |text|
  assert_text(text)
end

Then(/^I should not see '(.+)' on page$/) do |text|
  assert_no_text(text)
end

Then(/^'(.+)' field value should be '(.*)'$/) do |selector, value|
  expect(find(selector).value).to eq(value)
end

Then(/^I should not see '(.+)' in table$/) do |text|
  assert page.find('ul').not_to have_text(text)
end

Then(/^points are correct for '(.+)'$/) do |phone_name|
  assert_no_text('Loading', wait: 20)
  points = find(
    :xpath,
    "//a[@title='#{phone_name}']/../../*[@class='points']"
  ).text
  expect(points).to match(/\d+/)
  is_tablet = /tab|ipad/.match(phone_name.downcase)
  expect(points.to_i).to be >= (is_tablet ? 70 : 53)
end

Then(/^price is correct for '(.+)'$/) do |phone_name|
  assert_no_text('Loading', wait: 20)
  points = find(
    :xpath,
    "//a[@title='#{phone_name}']/../../*[@class='price']"
  ).text
  expect(points).to match(/[$€]\d+[,.]\d+/)
end

Then(/^I should see '(.+)' (\d+) times$/) do |text, times|
  assert_text(text, count: times)
end

Then(/^I wait for '(.+)' is not visible$/) do |text|
  assert_no_text(text, wait: 2.minutes)
end

Then(/^I should be redirected to '(.+)'$/) do |path|
  assert_current_path(path)
end

Given(/^I am on '(.+)' page$/) do |path|
  visit(path)
end

When(/^I click '(.+)' link$/) do |text|
  click_link(text)
end

When(/^I debug$/) do |_text|
  byebug
end
