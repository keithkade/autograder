Feature: Submitting Code

  #Can't format the code correctly. trying to pass python code to javascript code to ruby code :/
  #@javascript
  #Scenario: I want to submit a solution for a homework assignment
  #  Given I am logged in as Student
  #  And I already have the python io problem and am on that page
  #  When I fill in the ace editor with a good python solution
  #  And I press "Submit Code"
  #  Then I should see "Code Succesfully Evaluated"

  @javascript
  Scenario: I want to see when my code didn't compile
    Given I am logged in as Student
    And I already have the python io problem and am on that page
    When I fill in the ace editor with a bad python solution
    And I press "Submit Code"
    Then I should see "Compile Error"
