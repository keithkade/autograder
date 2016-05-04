Feature: Quizzes

  Scenario: Take Empty Quiz
    Given I am logged in as Student
    And I have a course named "test course"
    And I have a quiz named "test quiz"
    And the quiz "test quiz" is due in 1 days
    And I am in "test course" and have the quiz "test quiz" assigned to me
    And I am on the student quizzes page
    And I studenttableclickquiz "test quiz"
    Then I should see "When you are ready, hit the"
    And I follow "Take Quiz"
    Then I should see "Do not leave this page! If you do, your quiz will be submitted as is, and you will not be able to access it again."

  Scenario: I want to create a quiz
    Given I am logged in as Admin
    And I am on the admin quizzes page
    And I have a course named "Test Course"
    When I follow "New Quiz"
    And I fill in "Title" with "Sample Quiz"
    And I press "Create Quiz"
    Then I should be on the admin quiz page for "Sample Quiz"
