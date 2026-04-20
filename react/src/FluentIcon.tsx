import React from 'react';
import iconData from '../../lib/build/data.json';

export interface FluentIconProps extends React.SVGProps<SVGSVGElement> {
  /** Icon name (e.g., 'add', 'delete', 'search') */
  name: string;
  /** Icon style: 'regular' or 'filled' */
  style?: 'regular' | 'filled' | 'color' | 'light' | 'ltr' | 'rtl';
  /** Icon size in pixels */
  size?: number | string;
  /** Additional CSS classes */
  className?: string;
  /** Accessible label for screen readers */
  'aria-label'?: string;
}

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
 * FluentIcon component for rendering Microsoft Fluent UI System Icons
 *
 * @example
 * ```tsx
 * <FluentIcon name="add" size={20} style="regular" />
 * <FluentIcon name="delete" size={24} style="filled" className="text-red-500" />
 * ```
 */
export const FluentIcon: React.FC<FluentIconProps> = ({
  name,
  style = 'regular',
  size = 20,
  className = '',
  'aria-label': ariaLabel,
  ...props
}) => {
  const icon = typedIconData[name];

  if (!icon) {
    console.warn(`[FluentIcon] Icon "${name}" not found`);
    return null;
  }

  const sizeStr = size.toString();
  const pathData = icon.icons?.[style]?.[sizeStr];

  if (!pathData) {
    // Try to find the closest available size
    const availableSizes = Object.keys(icon.icons?.[style] || {});
    const closestSize = availableSizes.length > 0 ? availableSizes[0] : null;

    if (closestSize) {
      const fallbackPath = icon.icons[style][closestSize];
      console.warn(
        `[FluentIcon] Size ${size} not available for "${name}" in style "${style}". Using size ${closestSize} instead.`
      );

      return (
        <svg
          width={size}
          height={size}
          viewBox={`0 0 ${closestSize} ${closestSize}`}
          fill="none"
          xmlns="http://www.w3.org/2000/svg"
          className={`fluent-icon fluent-icon-${name} ${className}`}
          aria-hidden={!ariaLabel}
          aria-label={ariaLabel}
          role={ariaLabel ? 'img' : undefined}
          {...props}
          dangerouslySetInnerHTML={{ __html: fallbackPath }}
        />
      );
    }

    console.error(
      `[FluentIcon] No icons available for "${name}" in style "${style}"`
    );
    return null;
  }

  return (
    <svg
      width={size}
      height={size}
      viewBox={`0 0 ${sizeStr} ${sizeStr}`}
      fill="none"
      xmlns="http://www.w3.org/2000/svg"
      className={`fluent-icon fluent-icon-${name} ${className}`}
      aria-hidden={!ariaLabel}
      aria-label={ariaLabel}
      role={ariaLabel ? 'img' : undefined}
      {...props}
      dangerouslySetInnerHTML={{ __html: pathData }}
    />
  );
};

export default FluentIcon;
