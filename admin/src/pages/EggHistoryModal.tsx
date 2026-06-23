import { useMemo, useState } from 'react'
import { Avatar, Button, Input, Modal, Select, Space, Table, Tag, Typography } from 'antd'
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

const CATEGORY_OPTIONS = (Object.keys(CATEGORY_LABEL) as EggCategoryType[]).map((type) => ({
  value: type,
  label: CATEGORY_LABEL[type],
}))

const OUTCOME_OPTIONS = [
  { value: 'win' as const, label: 'Trúng' },
  { value: 'miss' as const, label: 'Trượt' },
]

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
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
  const [categoryType, setCategoryType] = useState<EggCategoryType | undefined>(undefined)
  const [outcome, setOutcome] = useState<'win' | 'miss' | undefined>(undefined)
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)

  const params = useMemo(
    () => ({
      userId: userId || undefined,
      categoryType,
      outcome,
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [userId, categoryType, outcome, from, to, page],
  )
  const { data, isFetching, refetch } = useEggDraws(params, open)

  function applyUserFilter(value: string) {
    setUserId(value.trim())
    setPage(1)
  }

  function changeCategory(value?: EggCategoryType) {
    setCategoryType(value)
    setPage(1)
  }

  function changeOutcome(value?: 'win' | 'miss') {
    setOutcome(value)
    setPage(1)
  }

  function changeFrom(value: string) {
    setFrom(value)
    setPage(1)
  }

  function changeTo(value: string) {
    setTo(value)
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
          style={{ width: 260 }}
        />
        <Select
          allowClear
          placeholder="Loại thưởng"
          value={categoryType}
          onChange={changeCategory}
          options={CATEGORY_OPTIONS}
          style={{ width: 150 }}
        />
        <Select
          allowClear
          placeholder="Kết quả"
          value={outcome}
          onChange={changeOutcome}
          options={OUTCOME_OPTIONS}
          style={{ width: 120 }}
        />
        <input
          type="date"
          aria-label="Từ ngày"
          value={from}
          max={to || undefined}
          onChange={(e) => changeFrom(e.target.value)}
          style={DATE_INPUT_STYLE}
        />
        <span style={{ color: '#8c8c8c' }}>→</span>
        <input
          type="date"
          aria-label="Đến ngày"
          value={to}
          min={from || undefined}
          onChange={(e) => changeTo(e.target.value)}
          style={DATE_INPUT_STYLE}
        />
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
