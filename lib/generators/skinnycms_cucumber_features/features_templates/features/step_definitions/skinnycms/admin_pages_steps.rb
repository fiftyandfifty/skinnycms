Given /^a admin user exists with an email address of "([^"]*)"$/ do |email|
  Factory(:user, :email => email)
end

Given /^a pages exist with names "([^"]*)" and "([^"]*)"$/ do |first, second|
  Factory(:page, :title => first, :visibility => 'public')
  Factory(:page, :title => second, :visibility => 'public')
end
