Feature: Add Todo Item
  As a user
  I want to add a new todo item
  So that I can track my tasks

  Scenario: Successfully adding a todo item
    Given I am on the TodoMVC page
    When I add a todo item with text "Buy milk"
    Then I should see "Buy milk" in the todo list
