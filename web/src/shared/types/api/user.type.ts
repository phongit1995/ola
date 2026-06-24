import type { Gender } from './auth.type';

export type Marriage = 'single' | 'married';

export type RelationshipStatus =
  | 'self'
  | 'none'
  | 'friend'
  | 'pending_outgoing'
  | 'pending_incoming'
  | 'blocked_by_me'
  | 'blocked_by_them';

export interface RelationshipInfo {
  status: RelationshipStatus;
  requestId?: string;
  since?: string;
  isFollowing: boolean;
  followsMe: boolean;
}

export interface PublicProfile {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  coverPhoto?: string;
  bio?: string;
  gender: Gender;
  dateOfBirth?: string;
  marriage: Marriage;
  verified: boolean;
  kisses: number;
  vipUsed?: string | null;
  vipEndTime?: string | null;
  followerCount: number;
  followingCount: number;
  isOnline: boolean;
  lastActiveAt?: string;
  createdAt: string;
  relationship?: RelationshipInfo;
}

export type SearchRelationship =
  | 'friend'
  | 'pending_outgoing'
  | 'pending_incoming'
  | 'blocked_by_me'
  | 'blocked_by_them';

export interface UserSearchResult {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  bio?: string;
  isOnline: boolean;
  relationship?: SearchRelationship;
  requestId?: string;
}

export interface SearchUsersResult {
  users: UserSearchResult[];
  total: number;
}

export interface KissResult {
  kisses: number;
}

export interface FollowResult {
  following: boolean;
  followerCount: number;
}

export interface FollowUser {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  bio?: string;
  isOnline: boolean;
  lastActiveAt?: string;
}

export interface FollowListResult {
  users: FollowUser[];
  total: number;
  limit: number;
  offset: number;
}

export interface FollowListParams {
  limit?: number;
  offset?: number;
}
