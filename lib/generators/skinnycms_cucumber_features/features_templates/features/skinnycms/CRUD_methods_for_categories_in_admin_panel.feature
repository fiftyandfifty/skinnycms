Feature: CRUD_methods_for_categories_in_admin_panel
  As a admin user of Resolveuganda
  I want to have access to CRUD methods for categories in a admin panel
  To manage categories

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_categories page

  Scenario: I try to add new empty category
    Then I follow "Add a Category"
    Then I press "Create Category"
    And I should see "Name can't be blank"

  Scenario: I try to add new category correctly, view it, update it and then try to delete it
    Then I follow "Add a Category"
    Then I fill in "category_name" with "My category"
    Then I press "Create Category"
    And I should see "Category was successfully created!"
    And I should see "My category"
    Then I follow "My category"
    And I should see "My category"
    Then I follow "Edit"
    Then I fill in "category_name" with "My updated category"
    Then I press "Save Changes"
    And I should see "Category was successfully updated!"
    And I should see "My updated category"
    Then I follow "Delete"
    And I should see "Category was successfully deleted!"
    And I should not see "My updated category"