# @fluent-icons/react

React components for [Microsoft Fluent UI System Icons](https://github.com/microsoft/fluentui-system-icons).

## Installation

```bash
npm install @fluent-icons/react
# or
yarn add @fluent-icons/react
# or
pnpm add @fluent-icons/react
```

## Usage

### Basic Example

```tsx
import { FluentIcon } from '@fluent-icons/react';

function App() {
  return (
    <div>
      <FluentIcon name="add" size={20} style="regular" />
      <FluentIcon name="delete" size={24} style="filled" />
      <FluentIcon name="search" size={32} />
    </div>
  );
}
```

### With Tailwind CSS

```tsx
import { FluentIcon } from '@fluent-icons/react';

function Button() {
  return (
    <button className="flex items-center gap-2">
      <FluentIcon
        name="add"
        size={20}
        className="text-blue-500"
      />
      Add Item
    </button>
  );
}
```

### Accessibility

```tsx
<FluentIcon
  name="close"
  size={24}
  aria-label="Close dialog"
/>
```

## API

### FluentIcon Props

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `name` | `string` | **required** | Icon name (e.g., 'add', 'delete', 'search') |
| `style` | `'regular' \| 'filled' \| 'color' \| 'light' \| 'ltr' \| 'rtl'` | `'regular'` | Icon style variant |
| `size` | `number \| string` | `20` | Icon size in pixels |
| `className` | `string` | `''` | Additional CSS classes |
| `aria-label` | `string` | `undefined` | Accessible label for screen readers |
| `...props` | `SVGProps` | | All other SVG element props |

## Utility Functions

The package also exports utility functions to help you work with icons:

```tsx
import {
  getAllIconNames,
  iconExists,
  getIconStyles,
  getIconSizes,
  getIconMetadata,
  searchIcons
} from '@fluent-icons/react';

// Get all available icon names
const allIcons = getAllIconNames();
// ['add', 'delete', 'search', ...]

// Check if an icon exists
const exists = iconExists('add');
// true

// Get available styles for an icon
const styles = getIconStyles('add');
// ['regular', 'filled']

// Get available sizes for an icon
const sizes = getIconSizes('add', 'regular');
// [16, 20, 24, 28, 32]

// Get complete metadata
const metadata = getIconMetadata('add');
// { name: 'ic_fluent_add', styles: [...], sizes: [...] }

// Search icons
const results = searchIcons('arrow');
// ['arrow_up', 'arrow_down', 'arrow_left', 'arrow_right', ...]
```

## Examples

### Icon Picker Component

```tsx
import { useState } from 'react';
import { FluentIcon, searchIcons } from '@fluent-icons/react';

function IconPicker() {
  const [query, setQuery] = useState('');
  const icons = searchIcons(query);

  return (
    <div>
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Search icons..."
      />
      <div className="grid grid-cols-6 gap-4">
        {icons.slice(0, 24).map((name) => (
          <div key={name} className="flex flex-col items-center">
            <FluentIcon name={name} size={32} />
            <span className="text-xs">{name}</span>
          </div>
        ))}
      </div>
    </div>
  );
}
```

### Dynamic Icon Component

```tsx
import { FluentIcon } from '@fluent-icons/react';

interface IconButtonProps {
  icon: string;
  label: string;
  onClick: () => void;
}

function IconButton({ icon, label, onClick }: IconButtonProps) {
  return (
    <button
      onClick={onClick}
      className="flex items-center gap-2 px-4 py-2 rounded hover:bg-gray-100"
    >
      <FluentIcon name={icon} size={20} />
      {label}
    </button>
  );
}

// Usage
<IconButton icon="add" label="Add Item" onClick={() => {}} />
<IconButton icon="delete" label="Delete" onClick={() => {}} />
```

### With Animation

```tsx
import { FluentIcon } from '@fluent-icons/react';

function AnimatedIcon() {
  return (
    <FluentIcon
      name="loading"
      size={24}
      className="animate-spin"
    />
  );
}
```

## TypeScript

The package is written in TypeScript and includes full type definitions.

```tsx
import { FluentIcon, FluentIconProps } from '@fluent-icons/react';

const iconProps: FluentIconProps = {
  name: 'add',
  size: 20,
  style: 'regular',
  className: 'text-blue-500',
};

<FluentIcon {...iconProps} />
```

## Available Icons

This package includes **2,998 icons** from Microsoft Fluent UI System Icons.

Browse all available icons at: [https://aka.ms/fluentui-system-icons](https://aka.ms/fluentui-system-icons)

## Styling

Icons inherit the current text color by default. You can style them using CSS:

```css
.fluent-icon {
  color: #0078d4; /* Sets icon color */
}

.fluent-icon path {
  fill: currentColor; /* Uses current text color */
}
```

Or with Tailwind CSS:

```tsx
<FluentIcon name="add" className="text-blue-500 hover:text-blue-700" />
```

## Performance

- **Tree-shakeable**: Only the icons you use are included in your bundle
- **Small bundle size**: ~2KB base + icon data
- **Optimized SVG**: Clean, optimized SVG paths
- **TypeScript**: Full type safety and autocomplete

## License

MIT

## Credits

Icons provided by [Microsoft Fluent UI System Icons](https://github.com/microsoft/fluentui-system-icons)
