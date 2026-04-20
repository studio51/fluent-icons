import React from 'react';
import { FluentIcon, searchIcons, getIconMetadata } from '@fluent-icons/react';

// Basic usage
export function BasicExample() {
  return (
    <div className="flex gap-4">
      <FluentIcon name="add" size={20} style="regular" />
      <FluentIcon name="delete" size={24} style="filled" />
      <FluentIcon name="search" size={32} />
    </div>
  );
}

// Button with icon
export function IconButton() {
  return (
    <button className="flex items-center gap-2 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600">
      <FluentIcon name="add" size={20} className="text-white" />
      Add Item
    </button>
  );
}

// Icon with accessibility
export function AccessibleIcon() {
  return (
    <button>
      <FluentIcon
        name="close"
        size={24}
        aria-label="Close dialog"
      />
    </button>
  );
}

// Dynamic icon selection
export function DynamicIcon({ iconName }: { iconName: string }) {
  const metadata = getIconMetadata(iconName);

  if (!metadata) {
    return <div>Icon not found</div>;
  }

  return (
    <div>
      <FluentIcon name={iconName} size={32} />
      <div className="text-sm mt-2">
        <p>Available styles: {metadata.styles.join(', ')}</p>
        <p>Available sizes: {metadata.sizes.join(', ')}</p>
      </div>
    </div>
  );
}

// Icon picker with search
export function IconPicker() {
  const [query, setQuery] = React.useState('');
  const [selectedIcon, setSelectedIcon] = React.useState<string | null>(null);

  const icons = searchIcons(query);

  return (
    <div className="p-4">
      <input
        type="text"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        placeholder="Search icons..."
        className="w-full px-4 py-2 border rounded mb-4"
      />

      {selectedIcon && (
        <div className="mb-4 p-4 bg-gray-100 rounded">
          <p className="text-sm font-medium mb-2">Selected: {selectedIcon}</p>
          <FluentIcon name={selectedIcon} size={48} />
        </div>
      )}

      <div className="grid grid-cols-6 gap-4">
        {icons.slice(0, 24).map((name) => (
          <button
            key={name}
            onClick={() => setSelectedIcon(name)}
            className="flex flex-col items-center p-2 hover:bg-gray-100 rounded"
          >
            <FluentIcon name={name} size={32} />
            <span className="text-xs mt-1 truncate w-full text-center">
              {name}
            </span>
          </button>
        ))}
      </div>
    </div>
  );
}

// Icon with different styles
export function StyledIcons() {
  return (
    <div className="space-y-4">
      <div className="flex gap-4 items-center">
        <FluentIcon name="heart" size={32} style="regular" />
        <FluentIcon name="heart" size={32} style="filled" />
        <span className="text-sm">Regular vs Filled</span>
      </div>

      <div className="flex gap-4 items-center">
        <FluentIcon name="star" size={24} className="text-yellow-500" />
        <FluentIcon name="star" size={32} className="text-yellow-500" />
        <FluentIcon name="star" size={40} className="text-yellow-500" />
        <span className="text-sm">Different sizes</span>
      </div>

      <div className="flex gap-4 items-center">
        <FluentIcon name="home" size={32} className="text-blue-500" />
        <FluentIcon name="home" size={32} className="text-green-500" />
        <FluentIcon name="home" size={32} className="text-red-500" />
        <span className="text-sm">Different colors</span>
      </div>
    </div>
  );
}

// Loading indicator
export function LoadingSpinner() {
  return (
    <div className="flex items-center gap-2">
      <FluentIcon
        name="arrow_sync"
        size={24}
        className="animate-spin text-blue-500"
      />
      <span>Loading...</span>
    </div>
  );
}

// Navigation menu with icons
export function NavigationMenu() {
  const menuItems = [
    { icon: 'home', label: 'Home', href: '/' },
    { icon: 'search', label: 'Search', href: '/search' },
    { icon: 'person', label: 'Profile', href: '/profile' },
    { icon: 'settings', label: 'Settings', href: '/settings' },
  ];

  return (
    <nav className="flex gap-4">
      {menuItems.map((item) => (
        <a
          key={item.href}
          href={item.href}
          className="flex items-center gap-2 px-3 py-2 rounded hover:bg-gray-100"
        >
          <FluentIcon name={item.icon} size={20} />
          <span>{item.label}</span>
        </a>
      ))}
    </nav>
  );
}

// Icon with tooltip
export function IconWithTooltip() {
  const [showTooltip, setShowTooltip] = React.useState(false);

  return (
    <div className="relative inline-block">
      <button
        onMouseEnter={() => setShowTooltip(true)}
        onMouseLeave={() => setShowTooltip(false)}
        className="p-2 hover:bg-gray-100 rounded"
      >
        <FluentIcon name="info" size={20} />
      </button>
      {showTooltip && (
        <div className="absolute bottom-full left-1/2 transform -translate-x-1/2 mb-2 px-3 py-1 bg-gray-900 text-white text-sm rounded whitespace-nowrap">
          More information
        </div>
      )}
    </div>
  );
}
