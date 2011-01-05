Feature: CRUD_methods_for_posts_in_admin_panel
  As a admin user of Resolveuganda
  I want to have access to CRUD methods for posts in a admin panel
  To manage posts

  Background:
    Given a admin user exists with an email address of "jonsmith@example.com"
    Given I am logged in as "jonsmith@example.com"
    Given I am on the admin_posts page

  Scenario: I try to add new empty post
    Then I follow "Add a New Post"
    Then I press "Save Changes"
    And I should see "There was an error: post cannot be empty!"

  Scenario: I try to add new post without permalink
    Then I follow "Add a New Post"
    And I fill in "post_title" with "My post"
    Then I press "Save Changes"
    And I should see "There was an error: post cannot be empty!"
    And I should not see "My post"

  Scenario: I try to add new post correctly, view it, update it and then try to delete it
    Then I follow "Add a New Post"
    Then I fill in "post_title" with "My post"
    Then I fill in "post_content" with "description"
    Then I press "Save Changes"
    And I should see "Post successfully created!"
    And I should see "My post"
    Then I follow "Preview"
    And I should see "My post"
    Then I am on the admin_posts page
    And I should see "My post"
    Then I follow "Edit"
    Then I fill in "post_title" with "My updated post"
    Then I press "Save Changes"
    And I should see "Post successfully updated! "
    Then I follow "Delete"
    And I should see "Post successfully deleted!"