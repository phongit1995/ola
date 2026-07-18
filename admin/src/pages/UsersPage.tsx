import { useState } from 'react'
import {
  App,
  Avatar,
  Button,
  Card,
  Input,
  Select,
  Space,
  Table,
  Tag,
  Tooltip,
  type TableColumnsType,
} from 'antd'
import {
  ClearOutlined,
  CrownOutlined,
  DeleteOutlined,
  EyeOutlined,
  UserOutlined,
} from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { useDeleteUser, useUpdateUserStatus, useUsers } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { UserDetailModal } from './UserDetailModal'
import { GENDER } from './userMeta'
import type { AdminUserListItem } from '@/types'

const PAGE_SIZE = 20

const SORT_OPTIONS = [
  { value: 'newest', label: 'Mới nhất', params: {} as { sortBy?: string; sortDir?: string } },
  { value: 'oldest', label: 'Cũ nhất', params: { sortBy: 'createdAt', sortDir: 'asc' } },
  { value: 'recent_login', label: 'Đăng nhập gần đây', params: { sortBy: 'lastLoginAt', sortDir: 'desc' } },
  { value: 'followers', label: 'Nhiều follower', params: { sortBy: 'followerCount', sortDir: 'desc' } },
  { value: 'name', label: 'Tên A–Z', params: { sortBy: 'username', sortDir: 'asc' } },
]

export function UsersPage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')
  const [ipSearch, setIpSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())
  const ip = useDebounce(ipSearch.trim())

  const [status, setStatus] = useState<'all' | 'active' | 'banned'>('all')
  const [gender, setGender] = useState<string>('all')
  const [vip, setVip] = useState<'all' | 'vip' | 'normal'>('all')
  const [verified, setVerified] = useState<'all' | 'verified' | 'unverified'>('all')
  const [sort, setSort] = useState('newest')

  const [detailId, setDetailId] = useState<string | null>(null)
  const [drawerOpen, setDrawerOpen] = useState(false)

  function resetPage<T>(setter: (v: T) => void) {
    return (v: T) => {
      setter(v)
      setPage(1)
    }
  }

  const hasActiveFilter =
    search !== '' ||
    ipSearch !== '' ||
    status !== 'all' ||
    gender !== 'all' ||
    vip !== 'all' ||
    verified !== 'all' ||
    sort !== 'newest'

  function clearFilters() {
    setSearch('')
    setIpSearch('')
    setStatus('all')
    setGender('all')
    setVip('all')
    setVerified('all')
    setSort('newest')
    setPage(1)
  }

  const sortParams = SORT_OPTIONS.find((o) => o.value === sort)?.params ?? {}

  const { data, isFetching } = useUsers({
    q: q || undefined,
    ip: ip || undefined,
    isActive: status === 'all' ? undefined : status === 'active',
    gender: gender === 'all' ? undefined : gender,
    vip: vip === 'all' ? undefined : vip === 'vip',
    emailVerified: verified === 'all' ? undefined : verified === 'verified',
    ...sortParams,
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
            <div style={{ fontWeight: 600 }}>
              {user.fullName || user.username}
              {user.isVip && (
                <Tooltip title="VIP">
                  <CrownOutlined style={{ color: '#faad14', marginLeft: 6 }} />
                </Tooltip>
              )}
            </div>
            <div style={{ fontSize: 12, color: '#6b7785' }}>@{user.username}</div>
          </div>
        </Space>
      ),
    },
    {
      title: 'Giới tính',
      dataIndex: 'gender',
      width: 100,
      render: (g: string) => {
        const info = GENDER[g] ?? { label: g || '—', color: 'default' }
        return g ? <Tag color={info.color}>{info.label}</Tag> : '—'
      },
    },
    {
      title: 'Ken',
      dataIndex: 'ken',
      width: 100,
      render: (v: number) => (v ?? 0).toLocaleString('vi-VN'),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isActive',
      width: 130,
      render: (isActive: boolean) =>
        isActive ? <Tag color="green">Hoạt động</Tag> : <Tag color="red">Đã khoá</Tag>,
    },
    {
      title: 'Email',
      dataIndex: 'emailVerified',
      width: 130,
      render: (v: boolean) =>
        v ? <Tag color="green">Đã xác thực</Tag> : <Tag>Chưa xác thực</Tag>,
    },
    {
      title: 'Đăng nhập cuối',
      dataIndex: 'lastLoginAt',
      width: 170,
      render: (v) => formatDateTime(v),
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
      width: 240,
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
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          flexWrap: 'wrap',
          gap: 12,
          alignItems: 'center',
        }}
      >
        <Input.Search
          allowClear
          placeholder="Tìm theo tên / email..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
          style={{ width: 280 }}
        />
        <Input.Search
          allowClear
          placeholder="Tìm theo IP đăng nhập..."
          value={ipSearch}
          onChange={(e) => {
            setIpSearch(e.target.value)
            setPage(1)
          }}
          style={{ width: 220 }}
        />
        <Select
          value={status}
          onChange={resetPage(setStatus)}
          style={{ width: 150 }}
          options={[
            { value: 'all', label: 'Mọi trạng thái' },
            { value: 'active', label: 'Hoạt động' },
            { value: 'banned', label: 'Đã khoá' },
          ]}
        />
        <Select
          value={gender}
          onChange={resetPage(setGender)}
          style={{ width: 140 }}
          options={[
            { value: 'all', label: 'Mọi giới tính' },
            { value: 'male', label: 'Nam' },
            { value: 'female', label: 'Nữ' },
            { value: 'other', label: 'Khác' },
          ]}
        />
        <Select
          value={vip}
          onChange={resetPage(setVip)}
          style={{ width: 130 }}
          options={[
            { value: 'all', label: 'VIP: tất cả' },
            { value: 'vip', label: 'VIP' },
            { value: 'normal', label: 'Thường' },
          ]}
        />
        <Select
          value={verified}
          onChange={resetPage(setVerified)}
          style={{ width: 160 }}
          options={[
            { value: 'all', label: 'Email: tất cả' },
            { value: 'verified', label: 'Đã xác thực' },
            { value: 'unverified', label: 'Chưa xác thực' },
          ]}
        />
        <Select
          value={sort}
          onChange={resetPage(setSort)}
          style={{ width: 200 }}
          options={SORT_OPTIONS.map((o) => ({ value: o.value, label: `Sắp xếp: ${o.label}` }))}
        />
        {hasActiveFilter && (
          <Button icon={<ClearOutlined />} onClick={clearFilters}>
            Xoá lọc
          </Button>
        )}
      </div>
      <Table<AdminUserListItem>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 1100 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} người dùng`,
          onChange: setPage,
        }}
      />
      <UserDetailModal
        userId={detailId}
        open={drawerOpen}
        onClose={() => setDrawerOpen(false)}
      />
    </Card>
  )
}
