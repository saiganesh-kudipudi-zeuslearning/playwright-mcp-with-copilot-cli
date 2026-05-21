# .github/instructions/playwright-bdd-generator.instructions.md

# Project: Playwright BDD Test Suite

## Stack
- playwright-bdd (BDD layer)
- @playwright/test (runner)
- TypeScript

---

# Your job when asked to generate tests for a URL

## Phase 1 — Explore with Playwright MCP

1. Use MCP tools to interact with the browser:
   - Launch browser and navigate to URL
   - Inspect page structure and elements
   - Capture screenshots for reference

2. Identify all interactive elements:
   - forms and inputs
   - buttons and links
   - navigation components

3. Document stable selectors:
   - ARIA roles and labels
   - data-testid attributes
   - semantic HTML elements
   - text content

4. Test key user flows:
   - Form submissions
   - Navigation paths
   - State changes
   - Error scenarios

---

## Phase 2 — Write Feature Files

- Create:
  `features/<page-name>.feature`

- Write realistic Gherkin scenarios

- Cover:
  - happy paths
  - edge cases
  - error states

- Use human-readable business language

---

## Phase 3 — Write Step Definitions

- Create:
  `steps/<page-name>.steps.ts`

- Import:
  `createBdd` from `playwright-bdd`

- Map all Given/When/Then steps

- Use exact locators discovered from snapshots

- Prefer:
  - page.getByRole()
  - page.getByLabel()
  - page.getByText()

- Prefer ARIA selectors over CSS selectors

---

## Phase 4 — Verify

Run:

```bash
npx bddgen
npx playwright test --reporter=list