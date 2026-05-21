import { createBdd } from 'playwright-bdd';
import { expect } from '@playwright/test';
import { todoMvcPage } from '../pages/todoMvcPage';

const { Given, When, Then } = createBdd();

Given('I am on the TodoMVC page', async ({ page }) => {
  await todoMvcPage(page).goto();
});

When('I add a todo item with text {string}', async ({ page }, text: string) => {
  await todoMvcPage(page).addTodo(text);
});

Then('I should see the todo item {string} in the list', async ({ page }, text: string) => {
  expect(await todoMvcPage(page).isTodoVisible(text)).toBeTruthy();
});
