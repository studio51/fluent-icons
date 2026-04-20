import iconData from '../../lib/build/data.json';

interface IconDataStructure {
  [key: string]: {
    name: string;
    weights: string[];
    styles: string[];
    icons: {
      [style: string]: {
        [weight: string]: string;
      };
    };
  };
}

const typedIconData = iconData as IconDataStructure;

/**
 * Get all available icon names
 * @returns Array of icon names
 */
export function getAllIconNames(): string[] {
  return Object.keys(typedIconData);
}

/**
 * Check if an icon exists
 * @param name - Icon name to check
 * @returns true if icon exists, false otherwise
 */
export function iconExists(name: string): boolean {
  return name in typedIconData;
}

/**
 * Get available styles for an icon
 * @param name - Icon name
 * @returns Array of available styles
 */
export function getIconStyles(name: string): string[] {
  const icon = typedIconData[name];
  if (!icon) return [];

  // Remove duplicates
  return [...new Set(icon.styles)];
}

/**
 * Get available sizes for an icon in a specific style
 * @param name - Icon name
 * @param style - Icon style (default: 'regular')
 * @returns Array of available sizes as numbers
 */
export function getIconSizes(name: string, style: string = 'regular'): number[] {
  const icon = typedIconData[name];
  if (!icon || !icon.icons[style]) return [];

  return Object.keys(icon.icons[style])
    .map(Number)
    .filter(n => !isNaN(n))
    .sort((a, b) => a - b);
}

/**
 * Get icon metadata
 * @param name - Icon name
 * @returns Icon metadata or null if not found
 */
export function getIconMetadata(name: string) {
  const icon = typedIconData[name];
  if (!icon) return null;

  return {
    name: icon.name,
    styles: getIconStyles(name),
    sizes: getIconSizes(name),
  };
}

/**
 * Search icons by name
 * @param query - Search query
 * @returns Array of matching icon names
 */
export function searchIcons(query: string): string[] {
  const lowerQuery = query.toLowerCase();
  return getAllIconNames().filter(name =>
    name.toLowerCase().includes(lowerQuery)
  );
}
