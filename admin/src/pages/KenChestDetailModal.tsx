import { useState } from 'react'
import {
  Avatar,
  Descriptions,
  Modal,
  Space,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { UserOutlined } from '@ant-design/icons'
import { useKenChestClaims } from '@/hooks/useKenChests'
import { formatDateTime } from '@/lib/format'
import { kenChestRewardText } from '@/lib/kenChest'
import type { KenChest, KenChestClaim } from '@/types'

const PAGE_SIZE = 20

interface KenChestDetailModalProps {
  chest: KenChest | null
  open: boolean
  onClose: () => void
}

function DetailContent({ chest }: { chest: KenChest }) {
  const [page, setPage] = useState(1)
  const { data, isFetching } = useKenChestClaims(chest.id, {
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  const wonCount = chest.claimedRecipients
  const emptyCount = Math.max(0, chest.claimsCount - chest.claimedRecipients)

  const columns: TableColumnsType<KenChestClaim> = [
    {
      title: 'Người dùng',
      key: 'user',
      render: (_, claim) => (
        <Space>
          <Avatar src={claim.user.avatar} icon={<UserOutlined />} size="small" />
          <Typography.Text>{claim.user.fullName || claim.user.username}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Nhận',
      key: 'amount',
      width: 130,
      render: (_, claim) =>
        claim.isEmpty ? (
          <Tag color="default">Rỗng</Tag>
        ) : (
          <Typography.Text strong style={{ color: '#d48806' }}>
            {claim.kenAmount.toLocaleString('vi-VN')} KEN
          </Typography.Text>
        ),
    },
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 170,
      render: (v: string) => formatDateTime(v),
    },
  ]

  return (
    <>
      <Descriptions column={2} size="small" bordered style={{ marginBottom: 16 }}>
        <Descriptions.Item label="Chế độ">
          {chest.rewardMode === 'fixed' ? 'Cố định' : 'Ngẫu nhiên'}
        </Descriptions.Item>
        <Descriptions.Item label="Thưởng">{kenChestRewardText(chest)}</Descriptions.Item>
        <Descriptions.Item label="Người nhận">
          {chest.claimedRecipients}/{chest.maxRecipients}
        </Descriptions.Item>
        <Descriptions.Item label="Lượt mở">
          <Space>
            <Tag color="green">{wonCount} trúng</Tag>
            <Tag color="default">{emptyCount} rỗng</Tag>
          </Space>
        </Descriptions.Item>
        <Descriptions.Item label="Tổng KEN đã phát">
          {chest.totalKenGiven.toLocaleString('vi-VN')}
        </Descriptions.Item>
        <Descriptions.Item label="Thời hạn">{chest.durationSeconds}s</Descriptions.Item>
        <Descriptions.Item label="Tạo lúc">{formatDateTime(chest.createdAt)}</Descriptions.Item>
        <Descriptions.Item label="Hết hạn">{formatDateTime(chest.expiresAt)}</Descriptions.Item>
      </Descriptions>

      <Typography.Title level={5}>Người đã mở</Typography.Title>
      <Table<KenChestClaim>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} lượt`,
          onChange: setPage,
        }}
      />
    </>
  )
}

export function KenChestDetailModal({ chest, open, onClose }: KenChestDetailModalProps) {
  return (
    <Modal
      title="Chi tiết rương Ken"
      open={open}
      onCancel={onClose}
      footer={null}
      width={720}
      centered
      destroyOnHidden
    >
      {chest && <DetailContent key={chest.id} chest={chest} />}
    </Modal>
  )
}
