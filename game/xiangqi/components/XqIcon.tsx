import type { CSSProperties } from 'react';
import arrowLeft from '../assets/icons/ic-arrow-left.svg';
import chat from '../assets/icons/ic-chat.svg';
import check from '../assets/icons/ic-check.svg';
import chevronLeft from '../assets/icons/ic-chevron-left.svg';
import chevronRight from '../assets/icons/ic-chevron-right.svg';
import close from '../assets/icons/ic-close.svg';
import exitDoor from '../assets/icons/ic-exit-door.svg';
import flag from '../assets/icons/ic-flag.svg';
import ken from '../assets/icons/ic-ken.svg';
import lock from '../assets/icons/ic-lock.svg';
import owner from '../assets/icons/ic-owner.svg';
import reaction from '../assets/icons/ic-reaction.svg';
import refresh from '../assets/icons/ic-refresh.svg';
import send from '../assets/icons/ic-send.svg';
import volumeOff from '../assets/icons/ic-volume-off.svg';
import volumeOn from '../assets/icons/ic-volume-on.svg';
import warning from '../assets/icons/ic-warning.svg';
import wifiOff from '../assets/icons/ic-wifi-off.svg';

export type XqIconName =
  | 'arrow-left'
  | 'chat'
  | 'check'
  | 'chevron-left'
  | 'chevron-right'
  | 'close'
  | 'exit-door'
  | 'flag'
  | 'ken'
  | 'lock'
  | 'owner'
  | 'reaction'
  | 'refresh'
  | 'send'
  | 'volume-off'
  | 'volume-on'
  | 'warning'
  | 'wifi-off';

const ICONS: Record<XqIconName, string> = {
  'arrow-left': arrowLeft,
  chat,
  check,
  'chevron-left': chevronLeft,
  'chevron-right': chevronRight,
  close,
  'exit-door': exitDoor,
  flag,
  ken,
  lock,
  owner,
  reaction,
  refresh,
  send,
  'volume-off': volumeOff,
  'volume-on': volumeOn,
  warning,
  'wifi-off': wifiOff,
};

interface XqIconProps {
  name: XqIconName;
  size?: number;
  className?: string;
}

export function XqIcon({ name, size = 24, className = '' }: XqIconProps) {
  const style = {
    '--xq-icon-url': `url("${ICONS[name]}")`,
    '--xq-icon-size': `${size}px`,
  } as CSSProperties;

  return <span className={`xq-icon ${className}`.trim()} style={style} aria-hidden="true" />;
}
