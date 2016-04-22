Feature: Submitting Code

  @javascript
  Scenario: I want to see when my code didn't compile
    Given I am logged in as Student
    And I already have the python io problem and am on that page
    When I fill in the ace editor with a bad python solution
    And I press "Submit Code"
    Then I should see "Code Succesfully Evaluated, but not all cases passed"
