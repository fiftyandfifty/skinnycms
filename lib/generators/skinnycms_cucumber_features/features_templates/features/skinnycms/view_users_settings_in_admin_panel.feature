Feature: View_users_settings_in_admin_panel
  As a admin user of Resolveuganda
  I want to view users settings in a admin panel
  To control users

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_users page

  Scenario: I view admin users page and users settings
    And I should see "Users"