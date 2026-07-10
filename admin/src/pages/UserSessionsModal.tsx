import { useState } from 'react'
import { Modal, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { useUserSessions } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'
import type { AdminUserSession } from '@/types'

const PAGE_SIZE = 10

interface UserSessionsModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

const PLATFORM_LABEL: Record<string, string> = {
  web: 'Web',
  ios: 'iOS',
  android: 'Android',
}

export function UserSessionsModal({ open, userId, username, onClose }: UserSessionsModalProps) {
  const [page, setPage] = useState(1)
  const { data, isFetching } = useUserSessions(open ? userId : null, {
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  const columns: TableColumnsType<AdminUserSession> = [
    {
      title: 'Thời gian',
      dataIndex: 'lastActiveAt',
      width: 170,
      render: (v?: string) => formatDateTime(v),
    },
    {
      title: 'Thiết bị',
      dataIndex: 'deviceName',
      width: 280,
      render: (v: string | undefined, r) => (
        <div style={{ maxWidth: 260 }}>
          <Typography.Text
            style={{ display: 'block' }}
            ellipsis={{ tooltip: v }}
            copyable={v ? { text: v } : false}
          >
            {v || '—'}
          </Typography.Text>
          {r.userAgent && (
            <Typography.Text
              type="secondary"
              style={{ display: 'block', fontSize: 11 }}
              ellipsis={{ tooltip: r.userAgent }}
              copyable={{ text: r.userAgent }}
            >
              {r.userAgent}
            </Typography.Text>
          )}
        </div>
      ),
    },
    {
      title: 'Nền tảng',
      dataIndex: 'platform',
      width: 100,
      render: (v?: string) => (v ? PLATFORM_LABEL[v] ?? v : '—'),
    },
    {
      title: 'IP',
      dataIndex: 'ipAddress',
      width: 160,
      render: (v?: string) =>
        v ? <Typography.Text copyable={{ text: v }}>{v}</Typography.Text> : '—',
    },
    {
      title: 'Phiên bản',
      dataIndex: 'appVersion',
      width: 120,
      render: (v?: string) =>
        v ? <Typography.Text copyable={{ text: v }}>{v}</Typography.Text> : '—',
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isActive',
      width: 130,
      render: (v: boolean) =>
        v ? <Tag color="green">Đang hoạt động</Tag> : <Tag>Đã thu hồi</Tag>,
    },
  ]

  return (
    <Modal
      title={`Lịch sử đăng nhập${username ? ` — @${username}` : ''}`}
      open={open}
      onCancel={onClose}
      footer={null}
      width={1000}
      style={{ maxWidth: '95vw', top: 32 }}
      styles={{ body: { maxHeight: '72vh', overflowY: 'auto' } }}
      destroyOnHidden
    >
      <Table<AdminUserSession>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 'max-content' }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} phiên`,
          onChange: setPage,
        }}
      />
    </Modal>
  )
}
