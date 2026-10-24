import type { ReactNode } from 'react';
import Svg, { Circle, G, Path, Rect } from 'react-native-svg';
import type { ReelTextAlign } from '@ola/shared/types';

interface IconProps {
  size?: number;
  color?: string;
}

const DEFAULT_SIZE = 20;
const DEFAULT_COLOR = '#ffffff';

function StrokeIcon({
  size = DEFAULT_SIZE,
  color = DEFAULT_COLOR,
  children,
}: IconProps & { children: ReactNode }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24">
      <G fill="none" stroke={color} strokeWidth={2} strokeLinecap="round" strokeLinejoin="round">
        {children}
      </G>
    </Svg>
  );
}

function FillIcon({
  size = DEFAULT_SIZE,
  color = DEFAULT_COLOR,
  children,
}: IconProps & { children: ReactNode }) {
  return (
    <Svg width={size} height={size} viewBox="0 0 24 24">
      <G fill={color}>{children}</G>
    </Svg>
  );
}

export function ReelPlusIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M12 5v14M5 12h14" />
    </StrokeIcon>
  );
}

export function ReelCloseIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M6 6l12 12M18 6L6 18" />
    </StrokeIcon>
  );
}

export function ReelMoreIcon(props: IconProps) {
  return (
    <FillIcon {...props}>
      <Circle cx="5" cy="12" r="2" />
      <Circle cx="12" cy="12" r="2" />
      <Circle cx="19" cy="12" r="2" />
    </FillIcon>
  );
}

export function ReelEyeIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
      <Circle cx="12" cy="12" r="3" />
    </StrokeIcon>
  );
}

export function ReelPauseIcon(props: IconProps) {
  return (
    <FillIcon {...props}>
      <Rect x="6" y="5" width="4" height="14" rx="1" />
      <Rect x="14" y="5" width="4" height="14" rx="1" />
    </FillIcon>
  );
}

export function ReelPlayIcon(props: IconProps) {
  return (
    <FillIcon {...props}>
      <Path d="M7 5.5v13a1 1 0 0 0 1.5.86l11-6.5a1 1 0 0 0 0-1.72l-11-6.5A1 1 0 0 0 7 5.5z" />
    </FillIcon>
  );
}

export function ReelSoundIcon({ muted, ...props }: IconProps & { muted: boolean }) {
  return (
    <StrokeIcon {...props}>
      <Path d="M4 9h4l5-4v14l-5-4H4z" />
      <Path d={muted ? 'M17 9l4 6M21 9l-4 6' : 'M16.5 8.5a5 5 0 0 1 0 7M19 6a8.5 8.5 0 0 1 0 12'} />
    </StrokeIcon>
  );
}

export function ReelVideoIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Rect x="3" y="4" width="18" height="16" rx="2" />
      <Path d="M7 4v16M17 4v16M3 9h4M3 15h4M17 9h4M17 15h4" />
    </StrokeIcon>
  );
}

export function ReelImageIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Rect x="3" y="4" width="18" height="16" rx="2" />
      <Circle cx="9" cy="10" r="2" />
      <Path d="M21 16l-5-5-9 9" />
    </StrokeIcon>
  );
}

export function ReelTrashIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3" />
    </StrokeIcon>
  );
}

const ALIGN_LINES: Record<ReelTextAlign, string> = {
  left: 'M4 6h16M4 10h10M4 14h16M4 18h10',
  center: 'M4 6h16M7 10h10M4 14h16M7 18h10',
  right: 'M4 6h16M10 10h10M4 14h16M10 18h10',
};

export function ReelAlignIcon({ align, ...props }: IconProps & { align: ReelTextAlign }) {
  return (
    <StrokeIcon {...props}>
      <Path d={ALIGN_LINES[align]} />
    </StrokeIcon>
  );
}

export function ReelTextStyleIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Rect x="3" y="5" width="18" height="14" rx="3" />
      <Path d="M9 15l3-7 3 7M10 13h4" />
    </StrokeIcon>
  );
}
