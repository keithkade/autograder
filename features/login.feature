Feature: Login

  Scenario: Login as admin
    Given I am on the login page
    And I fill in "Username" with "admin"
    And I fill in "Password" with "root"
    When I press "Login"
    Then I should be on the admin courses page

  Scenario: Login as student
    Given I am on the login page
    And I have the existing student dman
    And I fill in "Username" with "dman"
    And I fill in "Password" with "password"
    When I press "Login"
    Then I should be on the student home page

  Scenario: Going to login as admin redirects me home
    Given I am logged in as Admin
    When I go to the login page
    Then I should be on the admin courses page

  Scenario: Going to login as student redirects me home
    Given I am logged in as Student
    When I go to the login page
    Then I should be on the student home page

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
