export type FriendStatus = 'pending' | 'accepted' | 'rejected' | 'blocked';

export type RespondAction = 'accept' | 'reject';

export interface RelationshipUserInfo {
  id: string;
  username: string;
  email?: string;
  avatar?: string;
  fullName?: string;
}

export interface Relationship {
  id: string;
  requesterId: string;
  addresseeId: string;
  status: FriendStatus;
  actionedAt?: string;
  createdAt: string;
  requester?: RelationshipUserInfo;
  addressee?: RelationshipUserInfo;
}

export interface Friend {
  id: string;
  username: string;
  email?: string;
  avatar?: string;
  fullName?: string;
  friendAt: string;
  isOnline: boolean;
  lastActiveAt?: string;
}

export interface FriendListParams {
  limit?: number;
  offset?: number;
}

export interface FriendListResult {
  friends: Friend[];
  total: number;
  limit: number;
  offset: number;
}
