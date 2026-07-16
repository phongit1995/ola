import i18n from 'i18next';
import type { ImageSourcePropType } from 'react-native';
import { toApiError } from '@ola/shared/lib';
import type { Clan, ClanPolicy, ClanRole } from '@ola/shared/types';

const translate = i18n.t.bind(i18n) as (key: string, options?: Record<string, unknown>) => string;

export const CLAN_HANDLE_PATTERN = /^[a-z0-9]{5,32}$/;

export const CLAN_ROLE_ICONS: Record<Exclude<ClanRole, 'member'>, ImageSourcePropType> = {
  owner: require('@assets/icons/clan/ic_clan_role_leader.png'),
  deputy: require('@assets/icons/clan/ic_clan_role_vice_leader.png'),
  ambassador: require('@assets/icons/clan/ic_clan_role_supporter.png'),
};

export function normalizeClanHandle(input: string): string {
  return input.trim().replace(/^#/, '').toLowerCase();
}

export function clanPolicyLabel(policy: ClanPolicy): string {
  return translate(`clan.policy${policy}`);
}

export function clanRoleLabel(role: ClanRole): string {
  const key = {
    owner: 'clan.roleOwner',
    deputy: 'clan.roleDeputy',
    ambassador: 'clan.roleAmbassador',
    member: 'clan.roleMember',
  }[role];
  return translate(key);
}

export function clanErrorText(error: unknown): string {
  const message = toApiError(error).message;
  const key = `clan.errors.${message}`;
  return i18n.exists(key) ? translate(key) : message;
}

export function clanFeedErrorText(message: string): string {
  const key = `clan.errors.${message}`;
  return i18n.exists(key) ? translate(key) : message;
}

export function isClanStaff(clan: Clan): boolean {
  return clan.myRole === 'owner' || clan.myRole === 'deputy';
}

export function canPostPublicInClan(clan: Clan): boolean {
  return isClanStaff(clan) || (clan.memberPublicPost && clan.isMember);
}
