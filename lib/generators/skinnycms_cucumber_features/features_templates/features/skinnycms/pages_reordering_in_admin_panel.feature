Feature: pages_reordering_in_admin_panel
  As a admin user of Resolveuganda
  I want to reorder pages in a admin panel
  To manage pages

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given a pages exist with names "first" and "second"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_pages page

  Scenario: I try to turn on 'reorder page' mode
    And I should see "first"
    And I should see "second"
    And I should see "Enable Page Order"
 #   And I follow "Enable Page Order"
 #   And I should see "Save Page Order"
 #   And I should see "clip_in_public"
 #   Then I follow "Save Page Order"
 #   And I should not see "Save Page Order"
 #   And I should not see "clip_in_public"