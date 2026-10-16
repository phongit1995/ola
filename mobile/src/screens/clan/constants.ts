import type { ImageSourcePropType } from 'react-native';
import type { ClanRole } from '@ola/shared/types';

export const CLAN_AVATAR_OUTPUT = { width: 512, height: 512 };

export const CLAN_COVER_OUTPUT = { width: 1024, height: 512 };

export const MEMBERS_PAGE_SIZE = 50;

export const BANS_PAGE_SIZE = 100;

export const CLAN_ROLE_ICONS: Record<Exclude<ClanRole, 'member'>, ImageSourcePropType> = {
  owner: require('@assets/icons/clan/ic_clan_role_leader.png'),
  deputy: require('@assets/icons/clan/ic_clan_role_vice_leader.png'),
  ambassador: require('@assets/icons/clan/ic_clan_role_supporter.png'),
};
