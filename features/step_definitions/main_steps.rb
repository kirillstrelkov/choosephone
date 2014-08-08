Given(/^I am on main page$/) do
  visit 'phones/index'
end

Then(/^I should see main form$/) do
  expect(page).to have_css('form')
end

Then(/^I should see textarea field$/) do
  expect(page).to have_css('textarea')
end

Then(/^I should see '(.+)' button$/) do |name|
  expect(page).to have_button(name)
end

Then(/^I should not see 'Clear' button$/) do 
  expect(page).to have_selector('#clear_btn', visible: false)
end

When(/^I fill in textarea with '(.+)'$/) do |phones|
  fill_in('phones', :with => phones)
end

When(/^I click '(.+)' button$/) do |text|
  click_button(text)
end

Then(/^I should see '(.+)' before '(.+)'$/) do |phone1, phone2|
  expect(page.body.index(phone1)).to be < page.body.index(phone2)
end

Then(/^I should see '(.+)' on page$/) do |text|
  expect(page.body).to have_text(text)
end

Then(/^I should not see '(.+)' on page$/) do |text|
  expect(page.body).not_to have_text(text)
end

Then(/^'(.+)' field value should be '(.*)'$/) do |selector, value|
  expect(page.find(selector).value).to eq value
end

Then(/^I should not see '(.+)' in table$/) do |text|
  expect(page.find('ul')).not_to have_text(text)
end

