import kulTabIcon from '@/assets/icons/chat/ic_tab_kul.png';
import tabOla from '@/assets/icons/me/ic_action_tab_ola.png';
import tabOlaActive from '@/assets/icons/me/ic_action_tab_ola_selected.png';
import tabFollower from '@/assets/icons/me/ic_action_tab_follower.png';
import tabFollowerActive from '@/assets/icons/me/ic_action_tab_follower_selected.png';
import tabClan from '@/assets/icons/clan/ic_menu_clan.png';
import type { MeFeedFilter, PostVisibility } from '@app-types';
import type { MeTab } from './types';

export const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  community: undefined,
  personal: 'following',
  clan: 'clan',
};

export const ME_TABS = [
  { key: 'community', icon: tabOla, iconActive: tabOlaActive, labelKey: 'me.tabCommunity' },
  { key: 'personal', icon: tabFollower, iconActive: tabFollowerActive, labelKey: 'me.tabPersonal' },
  { key: 'clan', icon: tabClan, iconActive: tabClan, labelKey: 'me.tabClan', invert: true },
] as const satisfies ReadonlyArray<{
  key: MeTab;
  icon: string;
  iconActive: string;
  labelKey: string;
  invert?: boolean;
}>;

export const PRIVACY_OPTIONS: PostVisibility[] = ['public', 'friend', 'private'];

export { EDIT_WINDOW_MS } from '@ola/shared/constants';

export const ATTACH_BUTTONS = [
  { key: 'local', glyph: '📷', labelKey: 'me.attachLocal' },
  { key: 'smiley', glyph: '😀', labelKey: 'me.attachSmiley' },
  { key: 'tag', glyph: '🏷️', labelKey: 'me.attachTag' },
  { key: 'checkin', glyph: '📍', labelKey: 'me.attachCheckIn' },
  { key: 'sticker', icon: kulTabIcon, labelKey: 'me.attachSticker' },
] as const;

export type AttachButtonKey = (typeof ATTACH_BUTTONS)[number]['key'];

export const PAGE_SIZE = 30;

export const MAX_IMAGES = 5;

export const CLOSE_ANIMATION_MS = 200;
