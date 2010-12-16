Feature: CRUD_methods_for_users_in_admin_panel
  As a admin user of Resolveuganda
  I want to have access to CRUD methods for users in a admin panel
  To manage users

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_users page

  Scenario: I try to add new empty user
    Then I follow "Add User"
    Then I press "Sign up"
    And I should see "There were problems with the following fields"

  Scenario: I try to add new user without email
    Then I follow "Add User"
    And I fill in "user_name" with "Foobar_user"
    Then I press "Sign up"
    And I should see "Email can't be blank"

  Scenario: I try to add new user without password
    Then I follow "Add User"
    And I fill in "user_name" with "Foobar_user"
    And I fill in "user_email" with "foobar@mail.com"
    Then I press "Sign up"
    And I should see "Password can't be blank"

  Scenario: I try to add new user without password_confirmation
    Then I follow "Add User"
    And I fill in "user_name" with "Foobar_user"
    And I fill in "user_email" with "foobar@mail.com"
    And I fill in "user_password" with "foobar"
    Then I press "Sign up"
    And I should see "Password confirmation can't be blank"

  Scenario: I try to add new user with different password and password_confirmation
    Then I follow "Add User"
    And I fill in "user_name" with "Foobar_user"
    And I fill in "user_email" with "foobar@mail.com"
    And I fill in "user_password" with "foobar"
    And I fill in "user_password_confirmation" with "raboof"
    Then I press "Sign up"
    And I should see "Password doesn't match confirmation"

  Scenario: I try to add new user correctly, view it, update it and then try to delete it
    Then I follow "Add User"
    And I fill in "user_name" with "Foobar_user"
    And I fill in "user_email" with "foobar@mail.com"
    And I fill in "user_password" with "foobar"
    And I fill in "user_password_confirmation" with "foobar"
    Then I press "Sign up"
    And I should see "User was successfully created!"
    And I should see "foobar@mail.com"
    Then I follow "foobar@mail.com"
    And I should see "Foobar_user"
    And I should see "foobar@mail.com"
    Then I follow "Edit"
    And I should see "Edit User"
    Then I fill in "user_name" with "Updated_user"
    And I fill in "user_email" with "updated_foobar@mail.com"
    And I fill in "user_password" with "foobar"
    And I fill in "user_password_confirmation" with "foobar"
    Then I press "Update User"
    And I should see "User was successfully updated! "
    And I should see "updated_foobar@mail.com"
    Then I follow "Delete User"
    And I should not see "updated_foobar@mail.com"