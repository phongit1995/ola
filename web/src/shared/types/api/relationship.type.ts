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
