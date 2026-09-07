import kulTabIcon from '@/assets/icons/chat/ic_tab_kul.png';
import voiceIcon from '@/assets/icons/chat/ic_voice.png';
import tabCommunity from '@/assets/icons/me/header/ic_header_community.png';
import tabPersonal from '@/assets/icons/me/header/ic_header_personal.png';
import tabClan from '@/assets/icons/me/header/ic_header_clan.png';
import type { MeFeedFilter, PostVisibility } from '@app-types';
import type { MeTab } from './types';

export const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  community: undefined,
  personal: 'following',
  clan: 'clan',
};

export const ME_TABS = [
  {
    key: 'community',
    icon: tabCommunity,
    iconActive: tabCommunity,
    labelKey: 'me.tabCommunity',
    invert: true,
    opticalSize: 28,
    opticalOffsetY: 0,
  },
  {
    key: 'personal',
    icon: tabPersonal,
    iconActive: tabPersonal,
    labelKey: 'me.tabPersonal',
    invert: true,
    opticalSize: 28,
    opticalOffsetY: 0,
  },
  {
    key: 'clan',
    icon: tabClan,
    iconActive: tabClan,
    labelKey: 'me.tabClan',
    invert: true,
    opticalSize: 32,
    opticalOffsetY: 1,
  },
] as const satisfies ReadonlyArray<{
  key: MeTab;
  icon: string;
  iconActive: string;
  labelKey: string;
  invert?: boolean;
  opticalSize: number;
  opticalOffsetY: number;
}>;

export const PRIVACY_OPTIONS: PostVisibility[] = [
  'public',
  'friend',
  'private',
];

export { EDIT_WINDOW_MS } from '@ola/shared/constants';

export const ATTACH_BUTTONS = [
  { key: 'local', glyph: '📷', labelKey: 'me.attachLocal' },
  { key: 'voice', icon: voiceIcon, labelKey: 'me.attachVoice' },
  { key: 'smiley', glyph: '😀', labelKey: 'me.attachSmiley' },
  { key: 'tag', glyph: '🏷️', labelKey: 'me.attachTag' },
  { key: 'checkin', glyph: '📍', labelKey: 'me.attachCheckIn' },
  { key: 'sticker', icon: kulTabIcon, labelKey: 'me.attachSticker' },
] as const;

export type AttachButtonKey = (typeof ATTACH_BUTTONS)[number]['key'];

export const PAGE_SIZE = 30;

export const MAX_IMAGES = 5;

export const CLOSE_ANIMATION_MS = 200;
