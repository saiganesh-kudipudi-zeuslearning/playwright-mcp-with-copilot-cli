import { createBdd } from 'playwright-bdd';

const { Given, When, Then } = createBdd();

Given('I am on the login page', async ({ page }) => {
  await page.goto('/login');
});

When('I enter username {string} and password {string}', async ({ page }, username, password) => {
  await page.fill('#username', username);
  await page.fill('#password', password);
  await page.click('button[type="submit"]');
});

Then('I should see the dashboard', async ({ page }) => {
  await page.waitForURL('**/dashboard');
});