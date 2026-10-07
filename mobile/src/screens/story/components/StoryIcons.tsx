import Svg, { Path } from 'react-native-svg';

interface IconProps {
  size?: number;
  color: string;
}

function GlyphIcon({ size = 24, color, d }: IconProps & { d: string }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24" fill={color}>
      <Path d={d} />
    </Svg>
  );
}

export function ChevronLeftIcon(props: IconProps) {
  return <GlyphIcon {...props} d="M15.41 7.41 14 6l-6 6 6 6 1.41-1.41L10.83 12z" />;
}

export function ChevronRightIcon(props: IconProps) {
  return <GlyphIcon {...props} d="M8.59 16.59 10 18l6-6-6-6-1.41 1.41L13.17 12z" />;
}

export function ListIcon(props: IconProps) {
  return (
    <GlyphIcon
      {...props}
      d="M3 13h2v-2H3v2zm0 4h2v-2H3v2zm0-8h2V7H3v2zm4 4h14v-2H7v2zm0 4h14v-2H7v2zM7 7v2h14V7H7z"
    />
  );
}

export function TextSizeIcon(props: IconProps) {
  return <GlyphIcon {...props} d="M9 4v3h5v12h3V7h5V4H9zm-6 8h3v7h3v-7h3V9H3v3z" />;
}

export function SortIcon(props: IconProps) {
  return (
    <GlyphIcon
      {...props}
      d="M16 17.01V10h-2v7.01h-3L15 21l4-3.99h-3zM9 3 5 6.99h3V14h2V6.99h3L9 3z"
    />
  );
}

export function EyeIcon(props: IconProps) {
  return (
    <GlyphIcon
      {...props}
      d="M12 4.5C7 4.5 2.73 7.61 1 12c1.73 4.39 6 7.5 11 7.5s9.27-3.11 11-7.5c-1.73-4.39-6-7.5-11-7.5zM12 17a5 5 0 1 1 0-10 5 5 0 0 1 0 10zm0-8a3 3 0 1 0 0 6 3 3 0 0 0 0-6z"
    />
  );
}

export function CaretDownIcon(props: IconProps) {
  return <GlyphIcon {...props} d="M7 10l5 5 5-5z" />;
}
