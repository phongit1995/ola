export const METHOD_META: Record<string, { label: string; color: string }> = {
  POST: { label: 'Tạo', color: 'green' },
  PUT: { label: 'Cập nhật', color: 'blue' },
  PATCH: { label: 'Cập nhật', color: 'blue' },
  DELETE: { label: 'Xoá', color: 'red' },
}

export const RESOURCE_LABELS: Record<string, string> = {
  users: 'Người dùng',
  rooms: 'Phòng chat',
  vip: 'VIP',
  egg: 'Đập trứng',
  wheel: 'Vòng quay',
  pen: 'Sút Pen',
  ken: 'Ken / Rương',
  me: 'Me',
  settings: 'Cài đặt',
  upload: 'Tải lên',
}

export const RESOURCE_OPTIONS = Object.entries(RESOURCE_LABELS).map(([value, label]) => ({ value, label }))

export const METHOD_OPTIONS = [
  { value: 'POST', label: 'Tạo' },
  { value: 'PATCH', label: 'Cập nhật' },
  { value: 'DELETE', label: 'Xoá' },
]

export const KEN_ADJUST_ROUTE = '/ken/users/:userId/adjust'

export const ACTION_OPTIONS = [
  { value: KEN_ADJUST_ROUTE, label: 'Tặng / Trừ Ken' },
  { value: '/users/:id/vips', label: 'Tặng VIP' },
  { value: '/users/:id/username', label: 'Đổi username' },
  { value: '/users/:id/password', label: 'Reset mật khẩu' },
  { value: '/users/:id/status', label: 'Đổi trạng thái tài khoản' },
  { value: '/users/:id', label: 'Xoá người dùng' },
]
