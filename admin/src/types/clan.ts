export interface ClanUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface Clan {
  id: string
  handle: string
  description?: string
  avatar?: string
  cover?: string
  policy: number
  memberPublicPost: boolean
  memberCount: number
  visitCount: number
  roomId?: string
  owner?: ClanUser
  createdAt: string
}

export interface ClanMember {
  user?: ClanUser
  role: 'owner' | 'deputy' | 'ambassador' | 'member'
  verified: boolean
  joinedAt: string
}
