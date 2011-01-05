Feature: View_dashboard_in_admin_panel
  As a admin user of Resolveuganda
  I want to view dashboard in a admin panel
  To control project

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_dashboard page

  Scenario: I view admin dashboard page
    And I should see "Dashboard"