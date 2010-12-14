Feature: View_pages_settings_in_admin_panel
  As a admin user of Resolveuganda
  I want to view pages settings in a admin panel
  To control pages

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_pages page

  Scenario: I view admin pages page and pages settings
    And I should see "Pages"
    And I should see "Main Navigation Pages"
    And I should see "Private Pages"