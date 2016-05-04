Feature: Student Homepage/Problems

  Scenario: See my problems due this week
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a problem named "test problem"
    And the problem "test problem" is due in 1 days
    And I am in "test course" and have the problem "test problem" assigned to me
    And I am on the student home page
    Then I should see "test problem"

  Scenario: See my quizzes due this week
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a quiz named "test quiz"
    And the quiz "test quiz" is due in 1 days
    And I am in "test course" and have the quiz "test quiz" assigned to me
    And I am on the student home page
    Then I should see "test quiz"

  Scenario: See my submissions
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a problem named "test problem"
    And I am in "test course" and have the problem "test problem" assigned to me
    And I have a submission for "test problem" problem
    And I am on the student home page
    Then I should see "0 / 0 Passed"

  Scenario: Not see archived problems
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a problem named "test problem"
    And I am in "test course" and have the problem "test problem" assigned to me
    And the course of problem "test problem" is archived
    And I am on the student problems page
    Then I should not see "test problem"

  Scenario: See active problems
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a problem named "test problem"
    And I am in "test course" and have the problem "test problem" assigned to me
    And the course of problem "test problem" is not archived
    And I am on the student problems page
    Then I should see "test problem"
