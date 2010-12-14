Given /^I am logged in as "([^"]*)"$/ do |email|
  @page = Factory(:page, :title => 'home')
  Factory(:page_content, :page_id => @page.id)

  @current_user = User.find_by_email(email)
  if @current_user
    Given "I am on the user login page"
    When %Q{I fill in "user_email" with "#{email}"}
    And %Q{I fill in "user_password" with "foobar"}
    And %Q{I press "Sign in"}
  else
    raise "User not found"
  end
end
