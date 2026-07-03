import { createBdd } from 'playwright-bdd';
import { todoPage } from '../page-objects/todoPage';

const { Given, When, Then } = createBdd();

Given('I am on the TodoMVC page', async ({ page }) => {
  await page.goto('https://demo.playwright.dev/todomvc');
});

When('I add a todo item with text {string}', async ({ page }, text) => {
  const todo = todoPage(page);
  await todo.addTodo(text);
});

Then('I should see {string} in the todo list', async ({ page }, text) => {
  const todo = todoPage(page);
  expect(await todo.isTodoVisible(text)).toBeTruthy();
});
