import type { ClanMember } from '@/types'

export const ROLE_LABELS: Record<ClanMember['role'], { label: string; color?: string }> = {
  owner: { label: 'Bang chủ', color: 'gold' },
  deputy: { label: 'Phó bang chủ', color: 'blue' },
  ambassador: { label: 'Đại sứ', color: 'purple' },
  member: { label: 'Thành viên' },
}

export const POLICY_LABELS: Record<number, string> = {
  0: 'Tự do post Me',
  1: 'Tự do gia nhập',
  2: 'Chứng thực để post Me',
  3: 'Đóng cửa',
  4: 'Chứng thực mới xem và post',
}
