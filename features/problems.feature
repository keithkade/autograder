Feature: Problems
  
Scenario: I want to view a problem
  Given I already have the problem "Existing Problem"
  And I am on the problems page
  When I follow "View"
  Then I should be on the details page for "Existing Problem"
  
Scenario: I want to delete a problem
  Given I already have the problem "Existing Problem"
  And I am on the problems page
  When I follow "Delete"
  Then I should not have any problems
  
Scenario: I want to create a problem
  Given I am on the problems page
  When I follow "New Problem"
  And I fill in "Title" with "Sample Problem"
  And I press "Submit"
  Then I should be on the details page for "Sample Problem"
  
Scenario: I want to edit an existing problem
  Given I already have the problem "Existing Problem"
  And I am on the details page for "Existing Problem"
  When I follow "Edit This Problem"
  And I fill in "Skeleton" with "Code Here"
  And I press "Submit"
  Then I should be on the details page for "Existing Problem"
  And "Existing Problem" should have field skeleton with value "Code Here"
  
Scenario: I want to add a test case to a problem
  Given I already have the problem "Existing Problem"
  And I am on the details page for "Existing Problem"
  When I press "New Test Case"
  And I press "Submit"
  Then the number of test cases for "Existing Problem" will be 2
  
#Scenario: I want to edit an existing test case for a problem
  
#Scenario: I want to remove a test case from a problem