import type { ImageSourcePropType } from 'react-native';
import type { ClanRole } from '@ola/shared/types';

export {
  CLAN_HANDLE_PATTERN,
  normalizeClanHandle,
  clanPolicyLabel,
  clanRoleLabel,
  clanErrorText,
  clanFeedErrorText,
  isClanStaff,
  canPostPublicInClan,
} from '@ola/shared/lib';

export const CLAN_ROLE_ICONS: Record<Exclude<ClanRole, 'member'>, ImageSourcePropType> = {
  owner: require('@assets/icons/clan/ic_clan_role_leader.png'),
  deputy: require('@assets/icons/clan/ic_clan_role_vice_leader.png'),
  ambassador: require('@assets/icons/clan/ic_clan_role_supporter.png'),
};
