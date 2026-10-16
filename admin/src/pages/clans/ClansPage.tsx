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
  Typography,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, FlagOutlined, TeamOutlined } from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { useClans, useDeleteClan } from '@/hooks/useClans'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { ClanMembersModal } from './ClanMembersModal'
import type { Clan } from '@/types'

const PAGE_SIZE = 20

const POLICY_LABELS: Record<number, string> = {
  0: 'Tự do post Me',
  1: 'Tự do gia nhập',
  2: 'Chứng thực để post Me',
  3: 'Đóng cửa',
  4: 'Chứng thực mới xem và post',
}

export function ClansPage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const [membersOpen, setMembersOpen] = useState(false)
  const [membersClan, setMembersClan] = useState<Clan | null>(null)

  const { data, isFetching } = useClans({
    q: q || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const deleteClan = useDeleteClan()

  function openMembers(clan: Clan) {
    setMembersClan(clan)
    setMembersOpen(true)
  }

  function removeClan(clan: Clan) {
    modal.confirm({
      title: 'Xoá clan?',
      content: `${clan.handle} — hành động này không thể hoàn tác.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteClan.mutateAsync(clan.id)
          message.success('Đã xoá clan')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<Clan> = [
    {
      title: 'Clan',
      dataIndex: 'handle',
      render: (_, clan) => (
        <Space>
          <Avatar src={clan.avatar} icon={<FlagOutlined />} shape="square" />
          <div style={{ lineHeight: 1.3, maxWidth: 320 }}>
            <div style={{ fontWeight: 600 }}>{clan.handle}</div>
            {clan.description && (
              <Typography.Text type="secondary" ellipsis style={{ fontSize: 12 }}>
                {clan.description}
              </Typography.Text>
            )}
          </div>
        </Space>
      ),
    },
    {
      title: 'Bang chủ',
      key: 'owner',
      width: 180,
      render: (_, clan) =>
        clan.owner ? (
          <span>
            <span style={{ fontWeight: 500 }}>{clan.owner.username}</span>
            {clan.owner.fullName ? (
              <Typography.Text type="secondary"> · {clan.owner.fullName}</Typography.Text>
            ) : null}
          </span>
        ) : (
          '—'
        ),
    },
    {
      title: 'Chính sách',
      dataIndex: 'policy',
      width: 200,
      render: (policy: number) => <Tag>{POLICY_LABELS[policy] ?? policy}</Tag>,
    },
    {
      title: 'Thành viên',
      dataIndex: 'memberCount',
      width: 110,
    },
    {
      title: 'Lượt ghé',
      dataIndex: 'visitCount',
      width: 100,
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
      width: 190,
      render: (_, clan) => (
        <Space>
          <Button size="small" icon={<TeamOutlined />} onClick={() => openMembers(clan)}>
            Thành viên
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => removeClan(clan)}
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
          justifyContent: 'space-between',
          gap: 12,
          flexWrap: 'wrap',
        }}
      >
        <Input.Search
          allowClear
          placeholder="Tìm theo tên clan..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
          style={{ maxWidth: 360 }}
        />
      </div>
      <Table<Clan>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 980 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} clan`,
          onChange: setPage,
        }}
      />
      <ClanMembersModal
        clanId={membersClan?.id ?? null}
        clanHandle={membersClan?.handle}
        open={membersOpen}
        onClose={() => setMembersOpen(false)}
      />
    </Card>
  )
}
