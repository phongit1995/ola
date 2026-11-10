export interface MarriageUser {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface MarriageStatsParams {
  from?: string
  to?: string
}

export interface MarriageStats {
  proposals: {
    total: number
    pending: number
    accepted: number
    rejected: number
    cancelled: number
  }
  marriages: {
    total: number
    active: number
    divorced: number
  }
}

export type MarriageStatus = 'active' | 'divorced'

export interface MarriageItem {
  id: string
  userA: MarriageUser
  userB: MarriageUser
  status: MarriageStatus
  marriedAt: string
  divorcedAt?: string
  divorcedBy?: string
}

export interface MarriageListParams {
  status?: MarriageStatus
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export type MarriageProposalStatus = 'pending' | 'accepted' | 'rejected' | 'cancelled'

export interface MarriageProposalItem {
  id: string
  proposer: MarriageUser
  addressee: MarriageUser
  message?: string
  status: MarriageProposalStatus
  createdAt: string
  respondedAt?: string
}

export interface MarriageProposalListParams {
  status?: MarriageProposalStatus
  userId?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}
