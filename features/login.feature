Feature: Login

  Scenario: Login as admin
    Given I am on the login page
    When I fill in the login form with valid admin credentials
    Then I should be on the admin home page

  Scenario: Login as student
    Given I am on the login page
    When I fill in the login form with valid student credentials
    Then I should be on the student home page

  Scenario: Login fail
    Given I am on the login page
    When I fill in the login form with invalid credentials
    Then I should be shown an alert of failure
    And I should be on the the login page