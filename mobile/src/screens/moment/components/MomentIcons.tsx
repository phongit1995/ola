import type { ReactNode } from 'react';
import Svg, { Circle, G, Path, Rect } from 'react-native-svg';
import type { MomentTextAlign } from '@ola/shared/types';

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

export function MomentPlusIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M12 5v14M5 12h14" />
    </StrokeIcon>
  );
}

export function MomentCheckIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="m5.5 12.5 4 4L18.5 8" strokeWidth={3.2} />
    </StrokeIcon>
  );
}

export function MomentCloseIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M6 6l12 12M18 6L6 18" />
    </StrokeIcon>
  );
}

export function MomentChevronIcon({ direction, ...props }: IconProps & { direction: 'left' | 'right' }) {
  return (
    <StrokeIcon {...props}>
      <Path d={direction === 'left' ? 'M15 6l-6 6 6 6' : 'M9 6l6 6-6 6'} />
    </StrokeIcon>
  );
}

export function MomentMoreIcon(props: IconProps) {
  return (
    <FillIcon {...props}>
      <Circle cx="5" cy="12" r="2" />
      <Circle cx="12" cy="12" r="2" />
      <Circle cx="19" cy="12" r="2" />
    </FillIcon>
  );
}

export function MomentEyeIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7S2 12 2 12z" />
      <Circle cx="12" cy="12" r="3" />
    </StrokeIcon>
  );
}

export function MomentCommentIcon({ color = DEFAULT_COLOR, ...props }: IconProps) {
  return (
    <StrokeIcon {...props} color={color}>
      <Path d="M7.5 4.5h9a4 4 0 0 1 4 4v5a4 4 0 0 1-4 4H10L5.5 21v-3.8a4 4 0 0 1-2-3.5V8.5a4 4 0 0 1 4-4Z" strokeWidth={1.8} />
      <G fill={color} stroke="none">
        <Circle cx="7.8" cy="11" r="1" />
        <Circle cx="12" cy="11" r="1" />
        <Circle cx="16.2" cy="11" r="1" />
      </G>
    </StrokeIcon>
  );
}

export function MomentSendIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M21 3L10 14M21 3l-7 18-4-7-7-4z" />
    </StrokeIcon>
  );
}

export function MomentEyeOffIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M10.6 5.1A10.7 10.7 0 0 1 12 5c6.5 0 10 7 10 7a17.6 17.6 0 0 1-2.6 3.6M6.6 6.6C3.8 8.4 2 12 2 12s3.5 7 10 7a9.7 9.7 0 0 0 5.4-1.6" />
      <Path d="M9.9 9.9a3 3 0 0 0 4.2 4.2M3 3l18 18" />
    </StrokeIcon>
  );
}

export function MomentGlobeIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Circle cx="12" cy="12" r="9" />
      <Path d="M3 12h18M12 3a14 14 0 0 1 0 18M12 3a14 14 0 0 0 0 18" />
    </StrokeIcon>
  );
}

export function MomentFriendsIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Circle cx="9" cy="8" r="3.5" />
      <Path d="M2.5 20a6.5 6.5 0 0 1 13 0M16 4.6a3.5 3.5 0 0 1 0 6.8M18 14.2a6.5 6.5 0 0 1 3.5 5.8" />
    </StrokeIcon>
  );
}

export function MomentClockIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Circle cx="12" cy="12" r="9" />
      <Path d="M12 7v5l3 2" />
    </StrokeIcon>
  );
}

export function MomentPauseIcon(props: IconProps) {
  return (
    <FillIcon {...props}>
      <Rect x="6" y="5" width="4" height="14" rx="1" />
      <Rect x="14" y="5" width="4" height="14" rx="1" />
    </FillIcon>
  );
}

export function MomentPlayIcon(props: IconProps) {
  return (
    <FillIcon {...props}>
      <Path d="M7 5.5v13a1 1 0 0 0 1.5.86l11-6.5a1 1 0 0 0 0-1.72l-11-6.5A1 1 0 0 0 7 5.5z" />
    </FillIcon>
  );
}

export function MomentSoundIcon({ muted, ...props }: IconProps & { muted: boolean }) {
  return (
    <StrokeIcon {...props}>
      <Path d="M4 9h4l5-4v14l-5-4H4z" />
      <Path d={muted ? 'M17 9l4 6M21 9l-4 6' : 'M16.5 8.5a5 5 0 0 1 0 7M19 6a8.5 8.5 0 0 1 0 12'} />
    </StrokeIcon>
  );
}

export function MomentVideoIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Rect x="3" y="4" width="18" height="16" rx="2" />
      <Path d="M7 4v16M17 4v16M3 9h4M3 15h4M17 9h4M17 15h4" />
    </StrokeIcon>
  );
}

export function MomentImageIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Rect x="3" y="4" width="18" height="16" rx="2" />
      <Circle cx="9" cy="10" r="2" />
      <Path d="M21 16l-5-5-9 9" />
    </StrokeIcon>
  );
}

export function MomentTrashIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Path d="M4 7h16M10 11v6M14 11v6M6 7l1 13h10l1-13M9 7V4h6v3" />
    </StrokeIcon>
  );
}

const ALIGN_LINES: Record<MomentTextAlign, string> = {
  left: 'M4 6h16M4 10h10M4 14h16M4 18h10',
  center: 'M4 6h16M7 10h10M4 14h16M7 18h10',
  right: 'M4 6h16M10 10h10M4 14h16M10 18h10',
};

export function MomentAlignIcon({ align, ...props }: IconProps & { align: MomentTextAlign }) {
  return (
    <StrokeIcon {...props}>
      <Path d={ALIGN_LINES[align]} />
    </StrokeIcon>
  );
}

export function MomentTextStyleIcon(props: IconProps) {
  return (
    <StrokeIcon {...props}>
      <Rect x="3" y="5" width="18" height="14" rx="3" />
      <Path d="M9 15l3-7 3 7M10 13h4" />
    </StrokeIcon>
  );
}
