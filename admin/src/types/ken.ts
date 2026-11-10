export interface KenCounterparty {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface KenTransaction {
  id: string
  direction: 'credit' | 'debit'
  type: string
  amount: number
  balanceBefore: number
  balanceAfter: number
  description?: string
  refType?: string
  refId?: string
  actorType?: string
  actorId?: string
  counterparty?: KenCounterparty
  createdAt: string
}

export interface KenAdjustRequest {
  action: 'grant' | 'deduct'
  amount: number
  description?: string
}

export interface KenAdjustResult {
  transactionId: string
  userId: string
  action: string
  direction: string
  type: string
  amount: number
  balanceBefore: number
  balanceAfter: number
}

export interface KenTransferItem {
  id: string
  from: KenCounterparty
  to: KenCounterparty
  amount: number
  description?: string
  createdAt: string
}

export interface KenTransferListParams {
  senderId?: string
  receiverId?: string
  userId?: string
  minAmount?: number
  maxAmount?: number
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export type KenTransferUserStatsSortBy = 'sentTotal' | 'receivedTotal' | 'netKen' | 'transfers'

export interface KenTransferUserStatsItem {
  user: KenCounterparty
  sentCount: number
  sentTotal: number
  receivedCount: number
  receivedTotal: number
  netKen: number
  partners: number
  lastTransferAt: string
}

export interface KenTransferUserStatsParams {
  userId?: string
  minAmount?: number
  maxAmount?: number
  from?: string
  to?: string
  sortBy?: KenTransferUserStatsSortBy
  limit?: number
  offset?: number
}
