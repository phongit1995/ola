import type { ReactNode } from 'react'
import { Avatar, Space, Typography } from 'antd'

interface UserBrief {
  username: string
  fullName?: string | null
  avatar?: string | null
}

export function UserBriefCell({ user, badge }: { user?: UserBrief | null; badge?: ReactNode }) {
  if (!user) return <Typography.Text type="secondary">—</Typography.Text>
  const name = <Typography.Text strong>{user.fullName || user.username}</Typography.Text>
  return (
    <Space>
      <Avatar size="small" src={user.avatar || undefined}>
        {user.fullName?.[0] ?? user.username?.[0] ?? '?'}
      </Avatar>
      <div>
        {badge ? (
          <Space size={4}>
            {name}
            {badge}
          </Space>
        ) : (
          name
        )}
        <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
          @{user.username}
        </Typography.Text>
      </div>
    </Space>
  )
}
