import { useMemo, useState } from 'react'
import { Button, Card, Col, Image, Input, Row, Select, Space, Statistic, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { ArrowRightOutlined, ReloadOutlined } from '@ant-design/icons'
import { useGifts, useGiftTransactions } from './useGiftQueries'
import { GIFT_SOURCE_COLOR, GIFT_SOURCE_LABEL } from './constants'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { UserBriefCell } from '@/components/UserBriefCell'
import { PAGE_SIZE } from '@/lib/constants'
import { toIsoRange } from '@/lib/dateRange'
import { formatCount, formatDateTime } from '@/lib/format'
import type { AdminGiftTransaction } from '@/types'

const GIFT_ROW_THUMB_SIZE = 32

const columns: ColumnsType<AdminGiftTransaction> = [
  {
    title: 'Thời gian',
    dataIndex: 'createdAt',
    width: 160,
    render: (value: string) => formatDateTime(value),
  },
  {
    title: 'Người tặng',
    key: 'sender',
    render: (_, row) => <UserBriefCell user={row.sender} />,
  },
  {
    title: '',
    key: 'arrow',
    width: 40,
    align: 'center',
    render: () => <ArrowRightOutlined style={{ color: '#8c8c8c' }} />,
  },
  {
    title: 'Người nhận',
    key: 'receiver',
    render: (_, row) => <UserBriefCell user={row.receiver} />,
  },
  {
    title: 'Quà',
    key: 'gift',
    render: (_, row) => (
      <Space>
        <Image
          src={row.giftImageUrl}
          width={GIFT_ROW_THUMB_SIZE}
          height={GIFT_ROW_THUMB_SIZE}
          style={{ objectFit: 'contain' }}
          preview={false}
        />
        <Typography.Text>
          {row.giftName} <Typography.Text strong>×{row.quantity}</Typography.Text>
        </Typography.Text>
      </Space>
    ),
  },
  {
    title: 'KEN',
    dataIndex: 'totalKen',
    width: 110,
    align: 'right',
    render: (value: number) => <Typography.Text strong>{formatCount(value)}</Typography.Text>,
  },
  {
    title: 'Sức hút',
    dataIndex: 'charmPoints',
    width: 100,
    align: 'right',
    render: (value: number) => formatCount(value),
  },
  {
    title: 'Sức hút người tặng',
    dataIndex: 'senderCharmPoints',
    width: 150,
    align: 'right',
    render: (value: number) => formatCount(value),
  },
  {
    title: 'Nơi tặng',
    dataIndex: 'source',
    width: 120,
    render: (value: string) => <Tag color={GIFT_SOURCE_COLOR[value]}>{GIFT_SOURCE_LABEL[value] ?? value}</Tag>,
  },
  {
    title: 'Lời nhắn',
    dataIndex: 'note',
    ellipsis: true,
    render: (value?: string) => value || <Typography.Text type="secondary">—</Typography.Text>,
  },
]

export function GiftTransactionsPage() {
  const [userId, setUserId] = useState('')
  const [senderId, setSenderId] = useState('')
  const [receiverId, setReceiverId] = useState('')
  const [giftId, setGiftId] = useState<string | undefined>()
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)
  const { data: gifts } = useGifts()

  const range = useMemo(() => toIsoRange(from, to), [from, to])
  const params = useMemo(
    () => ({
      userId: userId || undefined,
      senderId: senderId || undefined,
      receiverId: receiverId || undefined,
      giftId,
      ...range,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [userId, senderId, receiverId, giftId, range, page],
  )
  const { data, isFetching, refetch } = useGiftTransactions(params)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Input.Search
            allowClear
            placeholder="User ID (tặng hoặc nhận)"
            onSearch={(value) => resetPage(setUserId)(value.trim())}
            style={{ width: 240 }}
          />
          <Input.Search
            allowClear
            placeholder="Người tặng ID"
            onSearch={(value) => resetPage(setSenderId)(value.trim())}
            style={{ width: 220 }}
          />
          <Input.Search
            allowClear
            placeholder="Người nhận ID"
            onSearch={(value) => resetPage(setReceiverId)(value.trim())}
            style={{ width: 220 }}
          />
          <Select
            allowClear
            placeholder="Loại quà"
            value={giftId}
            onChange={resetPage(setGiftId)}
            style={{ width: 180 }}
            options={(gifts ?? []).map((gift) => ({ value: gift.id, label: gift.name }))}
          />
          <DateRangeFilter
            from={from}
            to={to}
            onFromChange={resetPage(setFrom)}
            onToChange={resetPage(setTo)}
          />
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Row gutter={16}>
        <Col xs={24} sm={8}>
          <Card>
            <Statistic title="Lượt tặng" value={data?.total ?? 0} formatter={(v) => formatCount(Number(v))} />
          </Card>
        </Col>
        <Col xs={24} sm={8}>
          <Card>
            <Statistic title="KEN thu về" value={data?.totalKen ?? 0} formatter={(v) => formatCount(Number(v))} />
          </Card>
        </Col>
        <Col xs={24} sm={8}>
          <Card>
            <Statistic title="Sức hút đã trao" value={data?.totalCharm ?? 0} formatter={(v) => formatCount(Number(v))} />
          </Card>
        </Col>
      </Row>

      <Table<AdminGiftTransaction>
        rowKey="id"
        size="small"
        loading={isFetching}
        columns={columns}
        dataSource={data?.items ?? []}
        scroll={{ x: 1100 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          showTotal: (total) => `${formatCount(total)} lượt tặng`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có ai tặng quà' }}
      />
    </Space>
  )
}
