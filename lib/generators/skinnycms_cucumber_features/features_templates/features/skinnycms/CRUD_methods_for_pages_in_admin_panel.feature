Feature: CRUD_methods_for_pages_in_admin_panel
  As a admin user of Resolveuganda
  I want to have access to CRUD methods for pages in a admin panel
  To manage pages

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_pages page

  Scenario: I try to add new empty page
    Then I follow "Add a New Page"
    Then I press "Create Page"
    And I should see "Page was not created, check your input data and try again!"

  Scenario: I try to add new page without permalink
    Then I follow "Add a New Page"
    And I fill in "page_title" with "My page"
    Then I press "Create Page"
    And I should see "Page was not created, check your input data and try again!"
    And I should not see "My page"

  Scenario: I try to add new page correctly, view it, update it and then try to delete it
    Then I follow "Add a New Page"
    Then I fill in "page_title" with "My page"
    Then I fill in "page_permalink" with "my_page"
    Then I fill in "page_content_content" with "Hello!"
    Then I press "Create Page"
    And I should see "Page successfully created!"
    And I should see "My page"
    Then I follow "Preview"
    And I should see "My page"
    And I should see "Hello!"
    Then I am on the admin_pages page
    And I should see "My page"
    Then I follow "Edit"
    Then I fill in "page_title" with "My updated page"
    Then I press "Update Page"
    And I should see "Page successfully updated!"
    And I should see "My updated page"
    Then I follow "Delete"
    And I should see "Page successfully deleted!"
    And I should not see "My updated page"