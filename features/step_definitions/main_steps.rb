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

When(/^I fill in textarea with '(.+)'$/) do |phones|
  fill_in('phones', :with => phones)
end

When(/^I click '(.+)' button$/) do |text|
  click_button(text)
end

Then(/^I should see '(.+)' before '(.+)'$/) do |phone1, phone2|
  expect(page.body.index(phone1)).to be < page.body.index(phone2)
end

Then(/^I should not see '(.+)'$/) do |text|
  expect(page.body).not_to have_text(text)
end

Then(/^textarea field should be empty$/) do
  print page.body
  expect(page.find(:id, 'phones').value).to be_empty
end

