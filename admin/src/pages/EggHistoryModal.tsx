import { useMemo, useState } from 'react'
import { Avatar, Button, Input, Modal, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { ReloadOutlined } from '@ant-design/icons'
import { useEggDraws } from '@/hooks/useEgg'
import type { AdminEggDraw, EggCategoryType } from '@/types'

const PAGE_SIZE = 20

const CATEGORY_LABEL: Record<EggCategoryType, string> = {
  nothing: 'Không trúng',
  vip_icon: 'VIP Icon',
  ken: 'Ken',
  vip_days: 'Ngày VIP',
}

interface EggHistoryModalProps {
  open: boolean
  onClose: () => void
}

function formatTime(iso: string) {
  return new Date(iso).toLocaleString('vi-VN')
}

export function EggHistoryModal({ open, onClose }: EggHistoryModalProps) {
  const [userId, setUserId] = useState('')
  const [page, setPage] = useState(1)

  const params = useMemo(
    () => ({ userId: userId || undefined, limit: PAGE_SIZE, offset: (page - 1) * PAGE_SIZE }),
    [userId, page],
  )
  const { data, isFetching, refetch } = useEggDraws(params, open)

  function applyUserFilter(value: string) {
    setUserId(value.trim())
    setPage(1)
  }

  const columns: ColumnsType<AdminEggDraw> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 170,
      render: (value: string) => formatTime(value),
    },
    {
      title: 'Người chơi',
      key: 'user',
      render: (_, row) => (
        <Space>
          <Avatar size="small" src={row.user.avatar || undefined}>
            {row.user.fullName?.[0] ?? row.user.username?.[0] ?? '?'}
          </Avatar>
          <button
            type="button"
            onClick={() => applyUserFilter(row.user.id)}
            style={{ border: 'none', background: 'none', padding: 0, cursor: 'pointer', textAlign: 'left' }}
          >
            <Typography.Text strong>{row.user.fullName || row.user.username}</Typography.Text>
            <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
              @{row.user.username}
            </Typography.Text>
          </button>
        </Space>
      ),
    },
    {
      title: 'Gói',
      dataIndex: 'packName',
      width: 150,
    },
    {
      title: 'Kết quả',
      key: 'result',
      render: (_, row) => {
        if (!row.rewardType) return <Tag>Trượt</Tag>
        return (
          <Space size={4} wrap>
            <Tag color="blue">{CATEGORY_LABEL[row.categoryType]}</Tag>
            <span>{row.rewardLabel}</span>
            {row.kenAmount ? <Tag color="gold">+{row.kenAmount.toLocaleString('vi-VN')} Ken</Tag> : null}
            {row.vipDays ? <Tag color="purple">{row.vipDays} ngày VIP</Tag> : null}
            {row.isSuperLucky ? <Tag color="magenta">⭐ Siêu may mắn</Tag> : null}
          </Space>
        )
      },
    },
    {
      title: 'Giá/lượt',
      dataIndex: 'kenCost',
      width: 110,
      align: 'right',
      render: (value: number) => `${value.toLocaleString('vi-VN')} Ken`,
    },
  ]

  return (
    <Modal title="Lịch sử đập trứng" open={open} onCancel={onClose} footer={null} width={900}>
      <Space style={{ marginBottom: 12 }} wrap>
        <Input.Search
          allowClear
          placeholder="Lọc theo User ID (trống = tất cả)"
          defaultValue={userId}
          onSearch={applyUserFilter}
          style={{ width: 360 }}
        />
        {userId ? (
          <Button onClick={() => applyUserFilter('')}>Xem tất cả</Button>
        ) : null}
        <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
          Tải lại
        </Button>
      </Space>
      <Table<AdminEggDraw>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={columns}
        dataSource={data?.items ?? []}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          onChange: setPage,
        }}
      />
    </Modal>
  )
}
