import { createBdd } from 'playwright-bdd';
import { expect } from '@playwright/test';
import { todoPage } from '../pageObjects/todoPage';

const { Given, When, Then } = createBdd();

Given('I am on the TodoMVC page', async ({ page }) => {
  await todoPage(page).goto();
});

When('I add a todo item with text {string}', async ({ page }, text: string) => {
  await todoPage(page).addTodo(text);
});

Then('I should see the todo item {string} in the list', async ({ page }, text: string) => {
  expect(await todoPage(page).isTodoVisible(text)).toBeTruthy();
});
