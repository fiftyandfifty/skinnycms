Feature: View_categories_settings_in_admin_panel
  As a admin user of Resolveuganda
  I want to view categories settings in a admin panel
  To control categories

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_categories page

  Scenario: I view admin categories page and categories settings
    And I should see "Categories"