Feature: Student Homepage/Problems

  Scenario: See my problems due this week
    Given I am logged in as Student
    And I have a course named "test course"
    And I have a problem named "test problem"
    And the problem "test problem" is due in 1 days
    And I am in "test course" and have "test problem" assigned to me
    And I am on the student home page
    Then I should see "test problem"

  Scenario: See my submissions
    Given I am logged in as Student
    And I have a course named "test course"
    And I have a problem named "test problem"
    And I am in "test course" and have "test problem" assigned to me
    And I have a submission for "test problem" problem
    And I am on the student home page
    Then I should see "0 / 0 Passed"

  Scenario: Not see archived problems
    Given I am logged in as Student
    And I have a course named "test course"
    And I have a problem named "test problem"
    And I am in "test course" and have "test problem" assigned to me
    And the course of problem "test problem" is archived
    And I am on the student problems page
    Then I should not see "test problem"

  Scenario: See active problems
    Given I am logged in as Student
    And I have a course named "test course"
    And I have a problem named "test problem"
    And I am in "test course" and have "test problem" assigned to me
    And the course of problem "test problem" is not archived
    And I am on the student problems page
    Then I should see "test problem"