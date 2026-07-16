import type { Post } from './me.type';

export type ClanRole = 'owner' | 'deputy' | 'ambassador' | 'member';

export type ClanPolicy = 0 | 1 | 2 | 3 | 4;

export interface ClanUser {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
}

export interface Clan {
  id: string;
  handle: string;
  description?: string;
  avatar?: string;
  cover?: string;
  policy: ClanPolicy;
  memberPublicPost: boolean;
  memberCount: number;
  visitCount: number;
  meTopPostId?: string;
  owner?: ClanUser;
  deputy?: ClanUser;
  ambassador?: ClanUser;
  myRole?: ClanRole;
  myVerified: boolean;
  isMember: boolean;
  isBanned: boolean;
  kenBalance?: number;
  createdAt: string;
}

export interface ClanPreview {
  handle: string;
  owner?: string;
  deputy?: string;
  ambassador?: string;
  memberCount: number;
  visitCount: number;
}

export interface ClanCheckNameResult {
  name: string;
  available: boolean;
  cost: number;
  clan?: ClanPreview;
}

export interface CreateClanRequest {
  name: string;
  description?: string;
}

export interface UpdateClanRequest {
  description?: string;
  policy?: ClanPolicy;
  memberPublicPost?: boolean;
}

export interface ClanMember {
  user: ClanUser | null;
  role: ClanRole;
  verified: boolean;
  joinedAt: string;
}

export interface ClanMemberListResult {
  items: ClanMember[];
  total: number;
  limit: number;
  offset: number;
}

export interface ClanBan {
  user: ClanUser | null;
  bannedAt: string;
}

export interface ClanBanListResult {
  items: ClanBan[];
  total: number;
  limit: number;
  offset: number;
}

export interface ClanPostsResult {
  pinned?: Post | null;
  items: Post[];
  nextCursor?: string | null;
}

export interface ClanAssignRoleRequest {
  username: string;
  role: 'deputy' | 'ambassador';
}

export interface ClanUploadImageResult {
  url: string;
}
