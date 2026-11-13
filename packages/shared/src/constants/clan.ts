import type { ClanPolicy, ClanRole } from '../types/api/clan.type';

export const CLAN_ROLE = {
  owner: 'owner',
  deputy: 'deputy',
  ambassador: 'ambassador',
  member: 'member',
} as const satisfies Record<string, ClanRole>;

export const CLAN_POLICY_OPTION_ORDER: readonly ClanPolicy[] = [0, 1, 2, 4, 3];
