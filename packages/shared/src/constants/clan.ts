import type { ClanRole } from '../types/api/clan.type';

export const CLAN_ROLE = {
  owner: 'owner',
  deputy: 'deputy',
  ambassador: 'ambassador',
  member: 'member',
} as const satisfies Record<string, ClanRole>;
