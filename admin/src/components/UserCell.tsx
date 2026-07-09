import { Avatar, Space, Typography } from 'antd'
import { UserOutlined } from '@ant-design/icons'

interface UserCellUser {
  username: string
  fullName?: string
  avatar?: string
}

export function UserCell({ user }: { user: UserCellUser }) {
  return (
    <Space>
      <Avatar src={user.avatar} icon={<UserOutlined />} size="small" />
      <Space direction="vertical" size={0}>
        {user.fullName && <Typography.Text>{user.fullName}</Typography.Text>}
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          @{user.username}
        </Typography.Text>
      </Space>
    </Space>
  )
}
