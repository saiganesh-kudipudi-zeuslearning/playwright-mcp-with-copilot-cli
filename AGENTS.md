# Project: Playwright BDD Test Suite

## Stack
- playwright-bdd (BDD layer)
- @playwright/test (runner)
- TypeScript

## Your job when asked to generate tests for a URL:

### Phase 1 — Explore with playwright-cli
1. Open the URL: `playwright-cli open <url> --headed`
2. Take a snapshot: `playwright-cli snapshot`
3. Read the YAML snapshot file to understand the page structure
4. Navigate through all key flows (forms, buttons, nav links)
5. Take a screenshot after each major interaction
6. Note all interactive elements, their refs, labels, and roles

### Phase 2 — Write the Feature file
- Create `features/<page-name>.feature`
- Write Gherkin scenarios for every flow you discovered
- Use realistic, human-readable step language
- Cover: happy path, edge cases, error states

### Phase 3 — Write Step Definitions
- Create `steps/<page-name>.steps.ts`
- Import `createBdd` from `playwright-bdd`
- Map every Given/When/Then from the feature file
- Use exact Playwright locators discovered via playwright-cli snapshots
- Use `page.getByRole()`, `page.getByLabel()`, `page.getByText()` — prefer ARIA over CSS

### Phase 4 — Verify
- Run `npx bddgen && npx playwright test --reporter=list`
- Fix any failures using playwright-cli to re-inspect the page
- Re-run until green

## Conventions
- One .feature file per page/flow
- Step defs colocated in steps/ with matching name
- No hardcoded timeouts — use Playwright auto-waiting
- Screenshots on failure via Playwright config