Feature: Contact form

  Scenario: Send an email via the contact form
    Given I am on the contact page
    When I fill in the contact form
    Then I should see a thank you message