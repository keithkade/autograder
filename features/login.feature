Feature: Login

  Scenario: Login as admin
    Given I am on the login page
    And I fill in "Username" with "admin"
    And I fill in "Password" with "root"
    When I press "Login"
    Then I should be on the admin courses page

  Scenario: Login as student
    Given I am on the login page
    And I fill in "Username" with "student"
    And I fill in "Password" with "root"
    When I press "Login"
    Then I should be on the student home page

  Scenario: Login fail
    Given I am on the login page
    And I fill in "Username" with "bad"
    And I fill in "Password" with "bad"
    When I press "Login"
    Then I should see "Login Failed"
    And I should be on the login page