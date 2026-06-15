import { Avatar, Descriptions, Drawer, Skeleton, Tag } from 'antd'
import { UserOutlined } from '@ant-design/icons'
import { useUserDetail } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'

interface UserDetailDrawerProps {
  userId: string | null
  open: boolean
  onClose: () => void
}

export function UserDetailDrawer({ userId, open, onClose }: UserDetailDrawerProps) {
  const { data, isLoading } = useUserDetail(open ? userId : null)

  return (
    <Drawer title="Chi tiết người dùng" open={open} onClose={onClose} width={420}>
      {isLoading || !data ? (
        <Skeleton active avatar paragraph={{ rows: 6 }} />
      ) : (
        <>
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: 12,
              marginBottom: 20,
            }}
          >
            <Avatar src={data.avatar} icon={<UserOutlined />} size={56} />
            <div>
              <div style={{ fontSize: 16, fontWeight: 600 }}>
                {data.fullName || data.username}
              </div>
              <div style={{ color: '#6b7785' }}>@{data.username}</div>
            </div>
          </div>
          <Descriptions column={1} size="small" bordered>
            <Descriptions.Item label="Trạng thái">
              {data.isActive ? (
                <Tag color="green">Đang hoạt động</Tag>
              ) : (
                <Tag color="red">Đã khoá</Tag>
              )}
            </Descriptions.Item>
            <Descriptions.Item label="Email">{data.email || '—'}</Descriptions.Item>
            <Descriptions.Item label="Số điện thoại">{data.phone || '—'}</Descriptions.Item>
            <Descriptions.Item label="Giới thiệu">{data.bio || '—'}</Descriptions.Item>
            <Descriptions.Item label="IP đăng nhập cuối">
              {data.lastLoginIp || '—'}
            </Descriptions.Item>
            <Descriptions.Item label="Đăng nhập cuối">
              {formatDateTime(data.lastLoginAt)}
            </Descriptions.Item>
            <Descriptions.Item label="Ngày tạo">
              {formatDateTime(data.createdAt)}
            </Descriptions.Item>
          </Descriptions>
        </>
      )}
    </Drawer>
  )
}
