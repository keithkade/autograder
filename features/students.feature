Feature: Students 
  
  Scenario: I want to create a new student
    Given I am logged in as Admin
    And I am on the students page
    When I follow "New Student"
    And I fill in "Firstname" with "studentfirstname"
    And I fill in "Lastname" with "studentlastname"
    And I fill in "Id" with "00001"
    And I fill in "Username" with "New Student Username"
    And I fill in "Password" with "New Password"
    And I press "Create Student"
    Then I should be on the student page for "studentfirstname"
    
  Scenario: I want to delete a student
    Given I am logged in as Admin
    And I have a student named "Existing Student"
    And I am on the students page
    When I tableclickstudent "Existing Student"
    Then I should be on the student page for "Existing Student"
    When I follow "Delete"
    Then I should be on the student page
    And I should not see "Existing Student"
    
  Scenario: I want to view a student
    Given I am logged in as Admin
    And I have a student named "Existing Student"
    And I am on the students page
    When I tableclickstudent "Existing Student"
    Then I should be on the student page for "Existing Student"

  Scenario: I want to view a students sumbisions
    Given I am logged in as Admin
    And I have a student with a submission named "Existing Student"
    And I am on the students page
    When I tableclickstudent "Existing Student"
    Then I should be on the student page for "Existing Student"
    Then I should see "problem"
    
  Scenario: I want to edit a student
    Given I am logged in as Admin
    And I have a student named "Existing Student"
    And I am on the students page
    When I tableclickstudent "Existing Student"
    Then I should be on the student page for "Existing Student"
    When I follow "Edit"
    And I fill in "Firstname" with "New First Name"
    And I press "Update Student"
    Then I should be on the student page for "New First Name"

  Scenario: I want to fillter students
    Given I am logged in as Admin
    And I am on the students page
    And I have a student named "Existing Student"
    Given I have the existing student dman
    And I fill in "estudiante" with "Dishman"
    Then I should not see "Existing Student"
    And I should see "Name"
    When I follow "Name"
    Then I should see "Name"
    And I should see "Existing Student"
    When I follow "Grades"
    Then I should see "Grades"
    And I should see "Existing Student"




