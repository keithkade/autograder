Feature: Login

  Scenario: Login as admin
    Given I am on the login page
    And I fill in "Username" with "admin"
    And I fill in "Password" with "root"
    When I press "Login"
    Then I should be on the admin courses page

  Scenario: Login as student
    Given I am on the login page
    And I am in the student database
    And I fill in "Username" with "dman"
    And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on the student home page

  Scenario: Login as student logs me out as admin
    Given I am logged in as Admin
    And I am on the login page
    And I am in the student database
    And I fill in "Username" with "dman"
    And I fill in "Password" with "password"
    When I press "Login"
    Then I should not be logged in as Admin

  Scenario: Login as admin logs me out as student
    Given I am logged in as Student
    And I am on the login page
    And I fill in "Username" with "admin"
    And I fill in "Password" with "root"
    When I press "Login"
    Then I should not be logged in as Student

  Scenario: Login fail
    Given I am on the login page
    And I fill in "Username" with "bad"
    And I fill in "Password" with "bad"
    When I press "Login"
    Then I should see "Login Failed"
    And I should be on the login page

  Scenario: Logout as Admin
    Given I am logged in as Admin
    And I am on the admin courses page
    When I follow "Logout"
    Then I should be on the login page

  Scenario: Logout as Student
    Given  I am logged in as Student
    And I am on the student home page
    When I follow "Logout"
    Then I should be on the login page
