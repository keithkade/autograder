Feature: Student Problems Page

  Scenario: See all my problems
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a problem named "test problem"
    And I am in "test course" and have the problem "test problem" assigned to me
    And I am on the student problems page
    Then I should see "test problem"