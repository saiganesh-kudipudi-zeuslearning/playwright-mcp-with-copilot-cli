Feature: Add todo item
  As a user of the TodoMVC app
  I want to add a new todo item
  So that I can keep track of my tasks

  Scenario: Successfully adding a todo item
    Given I am on the TodoMVC page
    When I add a todo item with text "Buy milk"
    Then I should see the todo item "Buy milk" in the list
