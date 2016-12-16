When(/^I go to the homepage$/) do
  visit root_path
end

When(/^I go to the register page$/) do
  visit new_user_registration_path
end

When(/^I go to "(.*?)"$/) do |path|
  visit path
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in field, :with=>value
end

When(/^I check "(.*?)"$/) do |field|
  check field
end


When(/^I go back$/) do
  visit page.driver.request.env['HTTP_REFERER']
end

When(/^I choose "([^"]*)"$/) do |value|
  choose(value)
end

Then(/^I should see a link called "(.*?)" to "(.*?)"$/) do |link, url|
  page.should have_link(link, :href => url)
end

Then(/^I should be on the homepage$/) do |text|
  assert page.current_path == root_path
end

Then(/^I should see "(.*?)"$/) do |text|
  page.body.should have_text(text)
end

Then(/^I should not see "(.*?)"$/) do |text|
  page.body.should_not have_text(text)
end

When(/^I click on "(.*?)"$/) do |link|
  if link[0].eql?('#') or link[0].eql?('.')
    page.execute_script "$('#{link}').trigger('click');"
  else
    click_link link
  end
end

When(/^I press "(.*?)"$/) do |button|
  click_button(button)
end

Then (/^(?:|I )should be on (.+)$/) do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then(/^the page title should read "(.*?)"$/) do |title|
  page.has_title? title
end

Then(/^I should see the page heading "(.*?)"$/) do |title|
  expect(find('.page-title').find('h1')).to have_content(title)
end
