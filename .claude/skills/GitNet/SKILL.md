```markdown
# GitNet Development Patterns

> Auto-generated skill from repository analysis

## Overview
This skill teaches you the core development patterns and conventions used in the GitNet TypeScript codebase. You'll learn how to structure files, write imports and exports, follow commit message standards, and organize tests. These patterns ensure consistency and maintainability across the project.

## Coding Conventions

### File Naming
- Use **kebab-case** for all file names.
  - Example: `user-service.ts`, `api-handler.test.ts`

### Import Style
- Use **relative imports** for modules within the project.
  - Example:
    ```typescript
    import { fetchData } from './utils/fetch-data';
    ```

### Export Style
- Use **named exports** for all exported functions, types, or constants.
  - Example:
    ```typescript
    // In utils/fetch-data.ts
    export function fetchData() { ... }
    ```

### Commit Messages
- Follow **conventional commit** style.
- Use the `chore` prefix for maintenance and non-feature commits.
  - Example:  
    ```
    chore: update dependencies and fix minor lint issues
    ```

## Workflows

### Code Maintenance
**Trigger:** When making non-feature changes (e.g., updating dependencies, refactoring, fixing lint issues)
**Command:** `/chore`

1. Make your code changes.
2. Write a commit message starting with `chore:`.
3. Push your changes to the repository.

### Adding New Modules
**Trigger:** When creating new functionality or utilities
**Command:** `/add-module`

1. Create a new file using kebab-case (e.g., `new-feature.ts`).
2. Use relative imports to include dependencies.
3. Export functions or types using named exports.
4. Write corresponding tests in a `*.test.ts` file.

## Testing Patterns

- Test files use the `*.test.*` naming convention (e.g., `api-handler.test.ts`).
- The testing framework is not explicitly specified; follow the project's existing test file patterns.
- Place test files alongside the modules they test or in a dedicated test directory.

  Example:
  ```typescript
  // api-handler.test.ts
  import { handleApi } from './api-handler';

  describe('handleApi', () => {
    it('should process API requests correctly', () => {
      // test implementation
    });
  });
  ```

## Commands
| Command      | Purpose                                                |
|--------------|--------------------------------------------------------|
| /chore       | Use for maintenance commits (dependencies, refactoring)|
| /add-module  | Add a new module following project conventions         |
```
