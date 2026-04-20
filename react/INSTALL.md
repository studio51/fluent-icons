# Installation Guide

## For End Users (Installing from npm)

```bash
npm install @fluent-icons/react
# or
yarn add @fluent-icons/react
# or
pnpm add @fluent-icons/react
```

Then use in your React app:

```tsx
import { FluentIcon } from '@fluent-icons/react';

function App() {
  return <FluentIcon name="add" size={20} />;
}
```

---

## For Contributors (Building from Source)

### Prerequisites

- Node.js 16+ and npm/yarn/pnpm
- The main fluent-icons repository cloned

### Setup

1. Navigate to the React package directory:
```bash
cd react
```

2. Install dependencies:
```bash
npm install
# or
yarn install
# or
pnpm install
```

3. Build the package:
```bash
npm run build
# or
yarn build
# or
pnpm build
```

This will:
- Compile TypeScript to JavaScript
- Generate type definitions
- Create both CommonJS and ES Module builds
- Output to `dist/` directory

### Development

To watch for changes and rebuild automatically:

```bash
npm run dev
# or
yarn dev
# or
pnpm dev
```

### Testing Locally

To test the package in a local project before publishing:

1. Build the package:
```bash
npm run build
```

2. Link it globally:
```bash
npm link
```

3. In your test project:
```bash
npm link @fluent-icons/react
```

4. Use it as normal:
```tsx
import { FluentIcon } from '@fluent-icons/react';
```

### Publishing (Maintainers Only)

1. Update version in `package.json`

2. Build the package:
```bash
npm run build
```

3. Publish to npm:
```bash
npm publish
```

---

## Troubleshooting

### Module not found errors

Make sure the parent directory contains `lib/build/data.json`. The React package imports this file.

### TypeScript errors

Ensure you have TypeScript 4.5+ installed in your project:

```bash
npm install --save-dev typescript@latest
```

### Build errors

Try cleaning and rebuilding:

```bash
rm -rf node_modules dist
npm install
npm run build
```

---

## File Structure

After building, your `react/` directory should look like:

```
react/
├── dist/                    # Built files (git-ignored)
│   ├── index.js            # CommonJS build
│   ├── index.esm.js        # ES Module build
│   ├── index.d.ts          # Type definitions
│   └── ...
├── src/                     # Source files
│   ├── FluentIcon.tsx      # Main component
│   ├── utils.ts            # Utility functions
│   └── index.ts            # Entry point
├── package.json
├── tsconfig.json
├── rollup.config.js
└── README.md
```

---

## Next Steps

- Read the [README](./README.md) for usage examples
- Check out [example.tsx](./example.tsx) for more advanced patterns
- Browse icons at the [showcase page](../showcase.html)
