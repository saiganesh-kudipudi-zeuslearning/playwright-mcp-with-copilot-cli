import { Page } from '@playwright/test';

export const todoPage = (page: Page) => {
  const newTodoInput = page.getByRole('textbox', { name: 'What needs to be done?' });
  const todoList = page.locator('ul.todo-list');
  const todoItemByText = (text: string) => page.getByText(text, { exact: true });

  const goto = async () => {
    await page.goto('https://demo.playwright.dev/todomvc');
  };

  const addTodo = async (text: string) => {
    await newTodoInput.fill(text);
    await newTodoInput.press('Enter');
  };

  const isTodoVisible = async (text: string) => {
    return await todoItemByText(text).isVisible();
  };

  return {
    goto,
    addTodo,
    isTodoVisible,
  };
};
