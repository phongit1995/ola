import lockGold from '../assets/room-list/lock-gold.webp';
import plusGold from '../assets/room-list/plus-gold.webp';
import refreshBlue from '../assets/room-list/refresh-blue.svg';
import lockSolid from '../assets/room-list/lock-solid.svg';
import warningCoral from '../assets/room-list/warning-coral.svg';
import chevronLeft from '../assets/room-list/chevron-left.svg';
import chevronRight from '../assets/room-list/chevron-right.svg';
import chevronLeftDisabled from '../assets/room-list/chevron-left-disabled.svg';
import chevronRightDisabled from '../assets/room-list/chevron-right-disabled.svg';
import closeBold from '../assets/room-list/close-bold.svg';
import closeThin from '../assets/room-list/close-thin.svg';

export const ROOM_ICONS = {
  'lock-gold': { src: lockGold, width: 18, height: 24 },
  'refresh-blue': { src: refreshBlue, width: 28, height: 28 },
  'plus-gold': { src: plusGold, width: 28, height: 28 },
  'lock-solid': { src: lockSolid, width: 24, height: 30 },
  'warning-coral': { src: warningCoral, width: 16, height: 16 },
  'chevron-left': { src: chevronLeft, width: 16, height: 24 },
  'chevron-right': { src: chevronRight, width: 16, height: 24 },
  'chevron-left-disabled': { src: chevronLeftDisabled, width: 16, height: 24 },
  'chevron-right-disabled': { src: chevronRightDisabled, width: 16, height: 24 },
  'close-bold': { src: closeBold, width: 22, height: 22 },
  'close-thin': { src: closeThin, width: 22, height: 22 },
} as const;

export type RoomIconName = keyof typeof ROOM_ICONS;

interface RoomIconProps {
  name: RoomIconName;
  width?: number;
  height?: number;
  className?: string;
}

export function RoomIcon({ name, width, height, className }: RoomIconProps) {
  const icon = ROOM_ICONS[name];
  return (
    <img
      src={icon.src}
      width={width ?? icon.width}
      height={height ?? icon.height}
      className={className}
      style={{ display: 'inline-block', objectFit: 'contain', verticalAlign: 'middle', flexShrink: 0 }}
      alt=""
      aria-hidden="true"
      draggable={false}
    />
  );
}
