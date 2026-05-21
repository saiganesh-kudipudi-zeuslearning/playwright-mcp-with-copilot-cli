import { Page } from '@playwright/test';

export const todoMvcPage = (page: Page) => {
  const todoInput = page.getByRole('textbox', { name: 'What needs to be done?' });
  const todoList = page.locator('ul.todo-list');
  const todoItemByText = (text: string) => todoList.getByText(text);

  const goto = async () => {
    await page.goto('https://demo.playwright.dev/todomvc');
  };

  const addTodo = async (text: string) => {
    await todoInput.fill(text);
    await todoInput.press('Enter');
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
