import type { ClanRole } from '@app-types';
import leaderIcon from '@/assets/icons/clan/ic_clan_role_leader.png';
import viceIcon from '@/assets/icons/clan/ic_clan_role_vice_leader.png';
import supporterIcon from '@/assets/icons/clan/ic_clan_role_supporter.png';

export const CLAN_ROLE_ICONS: Record<Exclude<ClanRole, 'member'>, string> = {
  owner: leaderIcon,
  deputy: viceIcon,
  ambassador: supporterIcon,
};
