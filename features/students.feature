Feature: Students 
  
  Scenario: I want to create a new student
    Given I am logged in as Admin
    And I am on the students page
    When I follow "New Student"
    And I fill in "Name" with "New Student"
    And I fill in "Id" with "00001"
    And I fill in "Username" with "New Student Username"
    And I fill in "Password" with "New Password"
    And I fill in "Course" with "New Course"
    And I press "Create Student"
    Then I should be on the student page for "New Student"
    
  Scenario: I want to delete a student
    Given I am logged in as Admin
    And I have a student named "Existing Student"
    And I am on the students page
    When I follow "Destroy"
    Then I should not see "Existing Student"
    
  Scenario: I want to view a student
    Given I am logged in as Admin
    And I have a student named "Existing Student"
    And I am on the students page
    When I follow "Show"
    Then I should be on the student page for "Existing Student"
    
  Scenario: I want to edit a student
    Given I am logged in as Admin
    And I have a student named "Existing Student"
    And I am on the students page
    When I follow "Edit"
    And I fill in "Name" with "New Name"
    And I press "Update student"
    Then I should be on the student page for "New Name"