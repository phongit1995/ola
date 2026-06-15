import { useState } from 'react'
import {
  App,
  Avatar,
  Button,
  Card,
  Input,
  Space,
  Table,
  Tag,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, EyeOutlined, UserOutlined } from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { useDeleteUser, useUpdateUserStatus, useUsers } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { UserDetailDrawer } from './UserDetailDrawer'
import type { AdminUserListItem } from '@/types'

const PAGE_SIZE = 20

export function UsersPage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const [detailId, setDetailId] = useState<string | null>(null)
  const [drawerOpen, setDrawerOpen] = useState(false)

  const { data, isFetching } = useUsers({
    q: q || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  const updateStatus = useUpdateUserStatus()
  const deleteUser = useDeleteUser()

  function openDetail(id: string) {
    setDetailId(id)
    setDrawerOpen(true)
  }

  function toggleStatus(user: AdminUserListItem) {
    const next = !user.isActive
    modal.confirm({
      title: next ? 'Mở khoá người dùng?' : 'Khoá người dùng?',
      content: `@${user.username}`,
      okText: next ? 'Mở khoá' : 'Khoá',
      okButtonProps: { danger: !next },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await updateStatus.mutateAsync({ id: user.id, isActive: next })
          message.success(next ? 'Đã mở khoá' : 'Đã khoá người dùng')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
        }
      },
    })
  }

  function removeUser(user: AdminUserListItem) {
    modal.confirm({
      title: 'Xoá người dùng?',
      content: `@${user.username} — hành động này không thể hoàn tác.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteUser.mutateAsync(user.id)
          message.success('Đã xoá người dùng')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<AdminUserListItem> = [
    {
      title: 'Người dùng',
      dataIndex: 'username',
      render: (_, user) => (
        <Space>
          <Avatar src={user.avatar} icon={<UserOutlined />} />
          <div style={{ lineHeight: 1.2 }}>
            <div style={{ fontWeight: 600 }}>{user.fullName || user.username}</div>
            <div style={{ fontSize: 12, color: '#6b7785' }}>@{user.username}</div>
          </div>
        </Space>
      ),
    },
    { title: 'Email', dataIndex: 'email', render: (v) => v || '—' },
    {
      title: 'Trạng thái',
      dataIndex: 'isActive',
      width: 140,
      render: (isActive: boolean) =>
        isActive ? (
          <Tag color="green">Hoạt động</Tag>
        ) : (
          <Tag color="red">Đã khoá</Tag>
        ),
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'createdAt',
      width: 170,
      render: (v) => formatDateTime(v),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 230,
      render: (_, user) => (
        <Space>
          <Button size="small" icon={<EyeOutlined />} onClick={() => openDetail(user.id)}>
            Chi tiết
          </Button>
          <Button size="small" onClick={() => toggleStatus(user)}>
            {user.isActive ? 'Khoá' : 'Mở khoá'}
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => removeUser(user)}
          />
        </Space>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16, maxWidth: 360 }}>
        <Input.Search
          allowClear
          placeholder="Tìm theo tên / email..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
      </div>
      <Table<AdminUserListItem>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 720 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} người dùng`,
          onChange: setPage,
        }}
      />
      <UserDetailDrawer
        userId={detailId}
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
      />
    </Card>
  )
}
