import { useState } from 'react'
import { Avatar, Modal, Table, Tag, type TableColumnsType } from 'antd'
import { UserOutlined } from '@ant-design/icons'
import { useClanMembers } from '@/hooks/useClans'
import { formatDateTime } from '@/lib/format'
import type { ClanMember } from '@/types'

const PAGE_SIZE = 20

const ROLE_LABELS: Record<ClanMember['role'], { label: string; color?: string }> = {
  owner: { label: 'Bang chủ', color: 'gold' },
  deputy: { label: 'Phó bang chủ', color: 'blue' },
  ambassador: { label: 'Đại sứ', color: 'purple' },
  member: { label: 'Thành viên' },
}

interface ClanMembersModalProps {
  clanId: string | null
  clanHandle?: string
  open: boolean
  onClose: () => void
}

export function ClanMembersModal({ clanId, clanHandle, open, onClose }: ClanMembersModalProps) {
  const [page, setPage] = useState(1)
  const { data, isFetching } = useClanMembers(open ? clanId : null, {
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  const columns: TableColumnsType<ClanMember> = [
    {
      title: 'Thành viên',
      key: 'user',
      render: (_, member) => (
        <span style={{ display: 'inline-flex', alignItems: 'center', gap: 8 }}>
          <Avatar src={member.user?.avatar} icon={<UserOutlined />} size="small" />
          <span>
            <span style={{ fontWeight: 600 }}>{member.user?.username ?? '—'}</span>
            {member.user?.fullName ? (
              <span style={{ color: 'rgba(0,0,0,0.45)' }}> · {member.user.fullName}</span>
            ) : null}
          </span>
        </span>
      ),
    },
    {
      title: 'Vai trò',
      dataIndex: 'role',
      width: 140,
      render: (role: ClanMember['role']) => (
        <Tag color={ROLE_LABELS[role]?.color}>{ROLE_LABELS[role]?.label ?? role}</Tag>
      ),
    },
    {
      title: 'Chứng thực',
      dataIndex: 'verified',
      width: 110,
      render: (verified: boolean) =>
        verified ? <Tag color="green">Đã chứng thực</Tag> : <Tag>Chưa</Tag>,
    },
    {
      title: 'Ngày vào',
      dataIndex: 'joinedAt',
      width: 170,
      render: (v: string) => formatDateTime(v),
    },
  ]

  return (
    <Modal
      title={clanHandle ? `Thành viên clan "${clanHandle}"` : 'Thành viên clan'}
      open={open}
      onCancel={() => {
        setPage(1)
        onClose()
      }}
      footer={null}
      width={720}
    >
      <Table<ClanMember>
        rowKey={(member) => member.user?.id ?? `${member.role}-${member.joinedAt}`}
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        size="small"
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} thành viên`,
          onChange: setPage,
        }}
      />
    </Modal>
  )
}
