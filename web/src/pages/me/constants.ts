import tabOla from '@/assets/icons/me/ic_action_tab_ola.png';
import tabOlaActive from '@/assets/icons/me/ic_action_tab_ola_selected.png';
import tabTag from '@/assets/icons/me/ic_action_tab_tag.png';
import tabTagActive from '@/assets/icons/me/ic_action_tab_tag_selected.png';
import tabMedia from '@/assets/icons/me/ic_action_tab_media.png';
import tabMediaActive from '@/assets/icons/me/ic_action_tab_media_selected.png';
import tabFollower from '@/assets/icons/me/ic_action_tab_follower.png';
import tabFollowerActive from '@/assets/icons/me/ic_action_tab_follower_selected.png';
import type { MeFeedFilter, PostVisibility } from '@app-types';
import type { MeTab } from './types';

export const MENTION_TOKEN_PATTERN = /(@[A-Za-z0-9_]+|#[A-Za-z0-9_.]+)/g;

export const POST_TOKEN_PATTERN = /(@[A-Za-z0-9_]+|#[A-Za-z0-9_.]+|:ola\d{1,2}:)/g;

export const TAB_FILTER: Record<MeTab, MeFeedFilter | undefined> = {
  feed: undefined,
  tagged: 'tagged',
  media: 'media',
  mentions: 'mentions',
};

export const ME_TABS = [
  { key: 'feed', icon: tabOla, iconActive: tabOlaActive, labelKey: 'me.tabFeed' },
  { key: 'tagged', icon: tabTag, iconActive: tabTagActive, labelKey: 'me.tabTagged' },
  { key: 'media', icon: tabMedia, iconActive: tabMediaActive, labelKey: 'me.tabMedia' },
  { key: 'mentions', icon: tabFollower, iconActive: tabFollowerActive, labelKey: 'me.tabMentions' },
] as const satisfies ReadonlyArray<{
  key: MeTab;
  icon: string;
  iconActive: string;
  labelKey: string;
}>;

export const PRIVACY_OPTIONS: PostVisibility[] = ['public', 'friend', 'private'];

export const ATTACH_BUTTONS = [
  { key: 'local', glyph: '📷', labelKey: 'me.attachLocal' },
  { key: 'smiley', glyph: '😀', labelKey: 'me.attachSmiley' },
  { key: 'tag', glyph: '🏷️', labelKey: 'me.attachTag' },
  { key: 'checkin', glyph: '📍', labelKey: 'me.attachCheckIn' },
  { key: 'sticker', glyph: '😊', labelKey: 'me.attachSticker' },
] as const;

export type AttachButtonKey = (typeof ATTACH_BUTTONS)[number]['key'];
