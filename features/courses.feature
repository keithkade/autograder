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
    And I have a course named "Existing Course" on "Spring", "2016"
    And I am on the courses page
    When I tableclickcourse "Existing Course"
    Then I should be on the course page for "Existing Course"
    When I follow "Delete"
    Then I should be on the courses page
    And I should not see "Existing Course"
    
  Scenario: I want to view a course
    Given I am logged in as Admin
    And I have a course named "Existing Course" on "Spring", "2016"
    And I am on the courses page
    When I tableclickcourse "Existing Course"
    Then I should be on the course page for "Existing Course"
    
  Scenario: I want to edit a course
    Given I am logged in as Admin
    And I have a course named "Existing Course" on "Spring", "2016"
    And I am on the courses page
    When I tableclickcourse "Existing Course"
    Then I should be on the course page for "Existing Course"
    When I follow "Edit"
    And I fill in "Name" with "New Name"
    And I press "Update Course"
    Then I should be on the course page for "New Name"
    
  Scenario: I want to filter the courses
    Given I am logged in as Admin
    And I have a course named "CSCE" on "Spring", "2016"
    And I have a course named "SOCI" on "Fall", "2016"
    And I have a course named "HIST" on "Spring", "2017"
    And I have a course named "MATH" on "Spring", "2018"
    And I have a course named "CHEM" on "Spring", "2018"
    And I am on the courses page
    Then I should see "CSCE"
    When I fill in "year" with "2016"
    And I select "Spring" from "semester"
    And I press "Refresh"
    Then I should see "CSCE"
    And I should not see "SOCI"
    And I should not see "MATH"
    And I should not see "HIST"
    And I should not see "CHEM"

    
    