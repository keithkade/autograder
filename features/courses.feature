Feature: Courses 
  
  Scenario: I want to create a course
    Given I am logged in as Admin
    And I am on the courses page
    When I follow "New Course"
    And I fill in "Name" with "Added Course"
    And I press "Create Course"
    Then I should be on the course page for "Added Course"
    
  Scenario: I want to delete a course
    Given I am logged in as Admin
    And I have a course named "Existing Course"
    And I am on the courses page
    When I tableclickcourse "Existing Course"
    Then I should be on the course page for "Existing Course"
    When I follow "Delete"
    Then I should be on the courses page
    And I should not see "Existing Course"
    
  Scenario: I want to view a course
    Given I am logged in as Admin
    And I have a course named "Existing Course"
    And I am on the courses page
    When I tableclickcourse "Existing Course"
    Then I should be on the course page for "Existing Course"
    
  Scenario: I want to edit a course
    Given I am logged in as Admin
    And I have a course named "Existing Course"
    And I am on the courses page
    When I tableclickcourse "Existing Course"
    Then I should be on the course page for "Existing Course"
    When I follow "Edit"
    And I fill in "Name" with "New Name"
    And I press "Update Course"
    Then I should be on the course page for "New Name"
    
  Scenario: I want to filter the courses
    Given I am logged in as Admin
    And I have a course named "CSCE"
    And I have a course named "SOCI"
    And I have a course named "HIST"
    And I have a course named "MATH"
    And I have a course named "CHEM"
    And I am on the courses page
    When I fill in "year" with "CSCE"
    And I press "Refresh"
    Then I should be on the courses page
    And I should see "CSCE"
    And I should not see "SOCI"
    And I should not see "MATH"
    And I should not see "HIST"
    And I should not see "CHEM"

    
    