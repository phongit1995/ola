export interface RelationshipUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface RelationshipStatsParams {
  from?: string
  to?: string
}

export interface RelationshipStats {
  relationships: {
    total: number
    pending: number
    accepted: number
    rejected: number
    blocked: number
  }
  follows: {
    total: number
  }
}

export type RelationshipStatus = 'pending' | 'accepted' | 'rejected' | 'blocked'

export interface RelationshipItem {
  id: string
  requester: RelationshipUser
  addressee: RelationshipUser
  status: RelationshipStatus
  createdAt: string
  actionedAt?: string
}

export interface RelationshipListParams {
  status?: RelationshipStatus
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface FollowItem {
  id: string
  follower: RelationshipUser
  followee: RelationshipUser
  createdAt: string
}

export interface FollowListParams {
  followerId?: string
  followeeId?: string
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export type RelationshipUserStatsSortBy = 'friends' | 'blocked' | 'followers' | 'following'

export interface RelationshipUserStatsItem {
  user: RelationshipUser
  friends: number
  blocked: number
  followers: number
  following: number
}

export interface RelationshipUserStatsParams {
  userId?: string
  from?: string
  to?: string
  sortBy?: RelationshipUserStatsSortBy
  limit?: number
  offset?: number
}
