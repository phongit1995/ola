import { useState } from 'react'
import { Button, Card, Col, DatePicker, Input, Row, Segmented, Statistic, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { ReloadOutlined } from '@ant-design/icons'
import type { Dayjs } from 'dayjs'
import { UserCell } from '@/components/UserCell'
import { useDebounce } from '@/hooks/useDebounce'
import { formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { WordChainPurchase, WordChainPurchaseType } from '@/types'
import { useWordChainPurchases } from './useWordChainQueries'

type TypeFilter = WordChainPurchaseType | 'all'

const TYPE_TAG: Record<WordChainPurchaseType, { label: string; color: string }> = {
  hint: { label: 'Gợi ý', color: 'blue' },
  guess: { label: 'Mua lượt', color: 'purple' },
}

function formatKen(value: number) {
  return value.toLocaleString('vi-VN')
}

export function WordChainPurchasesTab() {
  const [type, setType] = useState<TypeFilter>('all')
  const [search, setSearch] = useState('')
  const [range, setRange] = useState<[Dayjs, Dayjs] | null>(null)
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const { data, isLoading, isFetching, refetch } = useWordChainPurchases({
    type: type === 'all' ? undefined : type,
    search: q || undefined,
    from: range ? range[0].startOf('day').toISOString() : undefined,
    to: range ? range[1].endOf('day').toISOString() : undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const summary = data?.summary

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: TableColumnsType<WordChainPurchase> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 160,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Người mua',
      key: 'user',
      width: 220,
      render: (_, purchase) => <UserCell user={purchase.user} />,
    },
    {
      title: 'Loại',
      dataIndex: 'type',
      width: 100,
      render: (value: WordChainPurchaseType) => <Tag color={TYPE_TAG[value].color}>{TYPE_TAG[value].label}</Tag>,
    },
    {
      title: 'Từ đang nối',
      dataIndex: 'word',
      width: 140,
      render: (word?: string) => (word ? <Typography.Text strong>{word}</Typography.Text> : '—'),
    },
    {
      title: 'Chi tiết',
      key: 'detail',
      render: (_, purchase) =>
        purchase.type === 'guess'
          ? `+${purchase.guesses ?? 0} lượt đoán`
          : purchase.hints && purchase.hints.length > 0
            ? purchase.hints.join(', ')
            : '—',
    },
    {
      title: 'KEN',
      dataIndex: 'amount',
      width: 110,
      align: 'right',
      render: (value: number) => <Typography.Text type="danger">-{formatKen(value)}</Typography.Text>,
    },
  ]

  return (
    <>
      <Row gutter={12} style={{ marginBottom: 16 }}>
        <Col xs={24} md={8}>
          <Card size="small">
            <Statistic
              title="Tổng KEN thu được"
              value={summary ? formatKen(summary.hintKen + summary.guessKen) : '—'}
              suffix={summary ? `· ${formatKen(summary.hintCount + summary.guessCount)} lần mua` : undefined}
            />
          </Card>
        </Col>
        <Col xs={12} md={8}>
          <Card size="small">
            <Statistic
              title="Gợi ý"
              value={summary ? formatKen(summary.hintKen) : '—'}
              suffix={summary ? `KEN · ${formatKen(summary.hintCount)} lần` : undefined}
            />
          </Card>
        </Col>
        <Col xs={12} md={8}>
          <Card size="small">
            <Statistic
              title="Mua lượt"
              value={summary ? formatKen(summary.guessKen) : '—'}
              suffix={summary ? `KEN · ${formatKen(summary.guessCount)} lần` : undefined}
            />
          </Card>
        </Col>
      </Row>

      <div style={{ marginBottom: 12, display: 'flex', gap: 12, flexWrap: 'wrap', alignItems: 'center' }}>
        <Segmented<TypeFilter>
          value={type}
          onChange={resetPage(setType)}
          options={[
            { label: 'Tất cả', value: 'all' },
            { label: 'Gợi ý', value: 'hint' },
            { label: 'Mua lượt', value: 'guess' },
          ]}
        />
        <DatePicker.RangePicker
          value={range}
          onChange={(value) => resetPage(setRange)(value as [Dayjs, Dayjs] | null)}
          placeholder={['Từ ngày', 'Đến ngày']}
        />
        <Input.Search
          allowClear
          placeholder="Tìm theo username / tên người mua..."
          value={search}
          onChange={(event) => resetPage(setSearch)(event.target.value)}
          style={{ maxWidth: 320 }}
        />
        <Button
          icon={<ReloadOutlined />}
          loading={isFetching && !isLoading}
          onClick={() => void refetch()}
          style={{ marginLeft: 'auto' }}
        >
          Làm mới
        </Button>
      </div>

      <Table<WordChainPurchase>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 900 }}
        locale={{ emptyText: 'Chưa có lượt mua nào' }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showSizeChanger: false,
          showTotal: (total) => `${formatKen(total)} lượt mua`,
          onChange: setPage,
        }}
      />
    </>
  )
}
