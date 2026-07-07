import { useMemo, useState } from 'react'
import { Modal, Select, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { useWheelSpins } from '@/hooks/useWheel'
import type { AdminWheelSpin, WheelSegmentKind } from '@/types'
import { WHEEL_KINDS, kindMeta } from './wheel/wheelHelpers'

const PAGE_SIZE = 20

interface WheelHistoryModalProps {
  open: boolean
  onClose: () => void
}

const OUTCOME_OPTIONS = [
  { value: '', label: 'Tất cả' },
  { value: 'win', label: 'Trúng' },
  { value: 'miss', label: 'Trượt' },
]

function rewardText(spin: AdminWheelSpin): string {
  if (spin.segmentKind === 'miss') return 'Trượt'
  if (spin.kenAmount) return `+${spin.kenAmount.toLocaleString('vi-VN')} Ken`
  if (spin.vipDays) return `${spin.vipDays} ngày VIP`
  return spin.rewardLabel ?? 'Trúng'
}

export function WheelHistoryModal({ open, onClose }: WheelHistoryModalProps) {
  const [page, setPage] = useState(1)
  const [kind, setKind] = useState<WheelSegmentKind | ''>('')
  const [outcome, setOutcome] = useState<'' | 'win' | 'miss'>('')

  const params = useMemo(
    () => ({
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
      ...(kind ? { segmentKind: kind } : {}),
      ...(outcome ? { outcome } : {}),
    }),
    [page, kind, outcome]
  )

  const { data, isFetching } = useWheelSpins(params, open)
  const spins = data?.items ?? []
  const total = data?.total ?? 0

  const columns: ColumnsType<AdminWheelSpin> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 160,
      render: (value: string) => new Date(value).toLocaleString('vi-VN'),
    },
    {
      title: 'Người chơi',
      key: 'user',
      render: (_, spin) => spin.user?.fullName || spin.user?.username || '—',
    },
    {
      title: 'Ô',
      dataIndex: 'segmentKind',
      width: 140,
      render: (value: WheelSegmentKind) => {
        const meta = kindMeta(value)
        return <Tag color={meta.color}>{meta.label}</Tag>
      },
    },
    {
      title: 'Kết quả',
      key: 'reward',
      render: (_, spin) => (
        <Space>
          <span style={{ color: spin.segmentKind === 'miss' ? '#999' : '#1f8a3b' }}>
            {rewardText(spin)}
          </span>
          {spin.isSuperLucky && <Tag color="magenta">⭐</Tag>}
        </Space>
      ),
    },
    {
      title: 'Chi phí',
      dataIndex: 'kenCost',
      width: 110,
      align: 'right',
      render: (value: number, spin) =>
        spin.isFree ? <Tag color="blue">Miễn phí</Tag> : `${value.toLocaleString('vi-VN')} Ken`,
    },
  ]

  return (
    <Modal title="Lịch sử quay" open={open} onCancel={onClose} footer={null} width={860} destroyOnHidden>
      <Space style={{ marginBottom: 12 }}>
        <Typography.Text type="secondary">Loại ô</Typography.Text>
        <Select
          size="small"
          style={{ width: 160 }}
          value={kind}
          onChange={(v) => {
            setKind(v)
            setPage(1)
          }}
          options={[{ value: '', label: 'Tất cả' }, ...WHEEL_KINDS.map((k) => ({ value: k.kind, label: k.label }))]}
        />
        <Typography.Text type="secondary">Kết quả</Typography.Text>
        <Select
          size="small"
          style={{ width: 120 }}
          value={outcome}
          onChange={(v) => {
            setOutcome(v)
            setPage(1)
          }}
          options={OUTCOME_OPTIONS}
        />
      </Space>
      <Table<AdminWheelSpin>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={columns}
        dataSource={spins}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total,
          onChange: setPage,
          showSizeChanger: false,
        }}
      />
    </Modal>
  )
}
