import { Page } from '@playwright/test';

export const todoPage = (page: Page) => {
  const todoInput = page.getByPlaceholder('What needs to be done?');
  const todoListItem = (text: string) => page.getByRole('listitem', { name: text });

  const addTodo = async (text: string) => {
    await todoInput.fill(text);
    await todoInput.press('Enter');
  };

  const isTodoVisible = async (text: string) => {
    return await todoListItem(text).isVisible();
  };

  return {
    addTodo,
    isTodoVisible,
  };
};
