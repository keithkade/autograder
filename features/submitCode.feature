Feature: Submitting Code

  @javascript
  Scenario: I want to submit a solution for a homework assignment
    Given I am logged in as Student
    And I already have the problem "Existing Problem"
    And I am on the student problem page for "Existing Problem"
    When I fill in the ace editor with "good code"
    And I press "Submit Code"
    Then I should see "Code Submitted"

  Scenario: I want to see when my code has succeeded
    Given I am logged in as Student
    And I am on a homework problem page
    When I fill in "Solution" with "good code"
    And I press "Submit Code"
    Then I should see "Test Case #0 Passed"

  Scenario: I want to see when my code has failed
    Given I am logged in as Student
    And I am on a homework problem page
    When I fill in "Solution" with "good code"
    And I press "Submit Code"
    Then I should see "Test Case #0 Failed"

  Scenario: I want to see when my code didn't compile
    Given I am logged in as Student
    And I am on a homework problem page
    When I fill in "Solution" with "bad syntax code"
    And I press "Submit Code"
    Then I should see "Compile Error"
