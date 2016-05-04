Feature: Submitting Code

  @javascript
  Scenario: I want to see when my code didn't compile after submit
    Given I am logged in as Student
    And I already have the python io problem and am on that page
    When I fill in the ace editor with a bad python solution
    And I press "Submit Code"
    Then I should see "Code Succesfully Submited, but not all cases passed"

  @javascript
  Scenario: I want to see when my code didn't compile after evaluation
    Given I am logged in as Student
    And I already have the python io problem and am on that page
    When I fill in the ace editor with a bad python solution
    And I press "Evaluate Code"
    Then I should see "Code Succesfully Evaluated, but not all cases passed"

  @javascript
  Scenario: I want to save and load my code for the first time
    Given I am logged in as Student
    And I already have the python io problem and am on that page
    When I fill in the ace editor with a bad python solution
    And I press "Save"
    And I fill in the ace editor with an ok python solution
    And I press "Load"
    Then I should see "ayyyy lmao"

  @javascript
  Scenario: I want to save and load my code multiple times
    Given I am logged in as Student
    And I already have the python io problem and am on that page
    When I fill in the ace editor with a bad python solution
    And I press "Save"
    And I fill in the ace editor with an ok python solution
    And I press "Save"
    When I fill in the ace editor with a bad python solution
    And I press "Save"
    And I fill in the ace editor with an ok python solution
    And I press "Load"
    Then I should see "ayyyy lmao"
