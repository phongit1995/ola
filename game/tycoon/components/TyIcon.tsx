import type { CSSProperties } from 'react';
import arrowLeft from '../assets/icons/ic-arrow-left.svg';
import chat from '../assets/icons/ic-chat.svg';
import check from '../assets/icons/ic-check.svg';
import chevronLeft from '../assets/icons/ic-chevron-left.svg';
import chevronRight from '../assets/icons/ic-chevron-right.svg';
import close from '../assets/icons/ic-close.svg';
import coins from '../assets/icons/ic-coins.svg';
import deed from '../assets/icons/ic-deed.svg';
import dice from '../assets/icons/ic-dice.svg';
import exitDoor from '../assets/icons/ic-exit-door.svg';
import flag from '../assets/icons/ic-flag.svg';
import history from '../assets/icons/ic-history.svg';
import house from '../assets/icons/ic-house.svg';
import jailBars from '../assets/icons/ic-jail-bars.svg';
import ken from '../assets/icons/ic-ken.svg';
import key from '../assets/icons/ic-key.svg';
import leaderboard from '../assets/icons/ic-leaderboard.svg';
import lock from '../assets/icons/ic-lock.svg';
import minus from '../assets/icons/ic-minus.svg';
import more from '../assets/icons/ic-more.svg';
import owner from '../assets/icons/ic-owner.svg';
import plus from '../assets/icons/ic-plus.svg';
import reaction from '../assets/icons/ic-reaction.svg';
import refresh from '../assets/icons/ic-refresh.svg';
import send from '../assets/icons/ic-send.svg';
import userMinus from '../assets/icons/ic-user-minus.svg';
import volumeOff from '../assets/icons/ic-volume-off.svg';
import volumeOn from '../assets/icons/ic-volume-on.svg';
import warning from '../assets/icons/ic-warning.svg';
import wifiOff from '../assets/icons/ic-wifi-off.svg';

export type TyIconName =
  | 'arrow-left'
  | 'chat'
  | 'check'
  | 'chevron-left'
  | 'chevron-right'
  | 'close'
  | 'coins'
  | 'deed'
  | 'dice'
  | 'exit-door'
  | 'flag'
  | 'history'
  | 'house'
  | 'jail-bars'
  | 'ken'
  | 'key'
  | 'leaderboard'
  | 'lock'
  | 'minus'
  | 'more'
  | 'owner'
  | 'plus'
  | 'reaction'
  | 'refresh'
  | 'send'
  | 'user-minus'
  | 'volume-off'
  | 'volume-on'
  | 'warning'
  | 'wifi-off';

const ICONS: Record<TyIconName, string> = {
  'arrow-left': arrowLeft,
  chat,
  check,
  'chevron-left': chevronLeft,
  'chevron-right': chevronRight,
  close,
  coins,
  deed,
  dice,
  'exit-door': exitDoor,
  flag,
  history,
  house,
  'jail-bars': jailBars,
  ken,
  key,
  leaderboard,
  lock,
  minus,
  more,
  owner,
  plus,
  reaction,
  refresh,
  send,
  'user-minus': userMinus,
  'volume-off': volumeOff,
  'volume-on': volumeOn,
  warning,
  'wifi-off': wifiOff,
};

interface TyIconProps {
  name: TyIconName;
  size?: number;
  className?: string;
}

export function TyIcon({ name, size = 24, className = '' }: TyIconProps) {
  const style = {
    '--ty-icon-url': `url("${ICONS[name]}")`,
    '--ty-icon-size': `${size}px`,
  } as CSSProperties;

  return <span className={`ty-icon ${className}`.trim()} style={style} aria-hidden="true" />;
}
