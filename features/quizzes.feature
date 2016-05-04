Feature: Quizzes

  Scenario: Take  Quiz
    Given I am logged in as Student
    And I have a course named "test course" on "Spring", "2016"
    And I have a quiz named "test quiz"
    And the quiz "test quiz" is due in 1 days
    And I am in "test course" and have the quiz "test quiz" assigned to me
    And I am on the student quizzes page
    And I studenttableclickquiz "test quiz"
    Then I should see "When you are ready, hit the"
    And I follow "Take Quiz"
    Then I should see "Do not leave this page! If you do, your quiz will be submitted as is, and you will not be able to access it again."
    And I fill in "for-test" with "lol"
    And I press "Submit"
    Then I should see "Quiz submission was successfully created."
    And I follow "Quiz List"
    Then I should be on the student quizzes page

  Scenario: I want to create a quiz
    Given I am logged in as Admin
    And I am on the admin quizzes page
    And I have a course named "Test Course" on "Spring", "2016"
    When I follow "New Quiz"
    And I fill in "Title" with "Sample Quiz"
    And I press "Create Quiz"
    Then I should be on the admin quiz page for "Sample Quiz"

  Scenario: I want to delete a quiz
    Given I am logged in as Admin
    And I am on the admin quizzes page
    And I have a course named "Test Course" on "Spring", "2016"
    When I follow "New Quiz"
    And I fill in "Title" with "test quiz"
    And I press "Create Quiz"
    And I am on the admin quiz page for "test quiz"
    And I follow "Delete"
    Then I should not have any quizzes

  Scenario: I want to update a quiz
    Given I am logged in as Admin
    And I am on the admin quizzes page
    And I have a course named "Test Course" on "Spring", "2016"
    When I follow "New Quiz"
    And I fill in "Title" with "test quiz"
    And I press "Create Quiz"
    And I am on the admin quiz page for "test quiz"
    And I follow "Edit"
    And I fill in "Title" with "test quiz change"
    And I press "Update Quiz"
    Then I should see "Quiz was successfully updated."
    And I should see "test quiz change"