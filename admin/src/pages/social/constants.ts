import type {
  MarriageProposalStatus,
  MarriageStatus,
  RelationshipStatus,
  RelationshipUserStatsSortBy,
} from '@/types'

export const MARRIAGE_STATUS_META: Record<MarriageStatus, { label: string; color: string }> = {
  active: { label: 'Đang bên nhau', color: 'green' },
  divorced: { label: 'Đã ly hôn', color: 'red' },
}

export const PROPOSAL_STATUS_META: Record<MarriageProposalStatus, { label: string; color: string }> = {
  pending: { label: 'Đang chờ', color: 'gold' },
  accepted: { label: 'Được nhận', color: 'green' },
  rejected: { label: 'Từ chối', color: 'red' },
  cancelled: { label: 'Đã hủy', color: 'default' },
}

export const USER_STATS_SORTS: RelationshipUserStatsSortBy[] = [
  'friends',
  'blocked',
  'followers',
  'following',
]

export const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i

export const RELATIONSHIP_STATUS_META: Record<RelationshipStatus, { label: string; color: string }> = {
  pending: { label: 'Đang chờ', color: 'gold' },
  accepted: { label: 'Bạn bè', color: 'green' },
  rejected: { label: 'Từ chối', color: 'default' },
  blocked: { label: 'Chặn', color: 'red' },
}
