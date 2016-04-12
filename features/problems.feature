Feature: Problems
  
Scenario: I want to view a problem
  Given I have a problem named "Existing Problem"
  And I am logged in as Admin
  And I am on the problems page
  When I tableclickproblem "Existing Problem"
  Then I should be on the problem page for "Existing Problem"
  
Scenario: I want to delete a problem
  Given I have a problem named "Existing Problem"
  And I am logged in as Admin
  And I am on the problems page
  When I tableclickproblem "Existing Problem"
  Then I should be on the problem page for "Existing Problem"
  And I follow "Delete"
  Then I should not have any problems
  
Scenario: I want to create a problem
  Given I am logged in as Admin
  And I am on the problems page
  When I follow "New Problem"
  And I fill in "Title" with "Sample Problem"
  And I press "Create Problem"
  Then I should be on the problem page for "Sample Problem"
  
Scenario: I want to edit an existing problem
  Given I have a problem named "Existing Problem"
  And I am logged in as Admin
  And I am on the problem page for "Existing Problem"
  When I follow "Edit"
  And I fill in "Skeleton" with "Code Here"
  And I press "Update Problem"
  Then I should be on the problem page for "Existing Problem"
  And "Existing Problem" should have field skeleton with value "Code Here"
  
Scenario: I want to add a test case to a problem
  Given I have a problem named "Existing Problem"
  And I am logged in as Admin
  And I am on the problems page
  When I tableclickproblem "Existing Problem"
  Then I should be on the problem page for "Existing Problem"
  And I follow "New Test Case"
  And I fill in "Input" with "1"
  And I fill in "Output" with "10"
  And I press "Create Problem test case"
  Then I should be on the problem page for "Existing Problem"
  And I should see "Input"
  And I should see "Output"

Scenario: I want to edit a test case for a problem
  Given I have a problem named "Existing Problem"
  And the problem "Existing Problem" has a "Existing test case" test case
  And I am logged in as Admin
  And I am on the problems page
  When I tableclickproblem "Existing Problem"
  Then I should be on the problem page for "Existing Problem"
  And I follow "Edit test case"
  And I fill in "Input" with "Edited Input"
  And I fill in "Output" with "Edited Output"
  And I press "Update Problem test case"
  Then I should be on the problem page for "Existing Problem"
  And I should see "Edited Input"
  And I should see "Edited Output"

Scenario: I want to remove a test case for a problem
  Given I have a problem named "Existing Problem"
  And the problem "Existing Problem" has a "Existing test case" test case
  And I am logged in as Admin
  And I am on the problems page
  When I tableclickproblem "Existing Problem"
  Then I should be on the problem page for "Existing Problem"
  And I follow "Remove"
  Then I should be on the problem page for "Existing Problem"
  And I should not see "Edit Test Case"


