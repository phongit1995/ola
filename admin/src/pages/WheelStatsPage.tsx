import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { Button, Card, Col, DatePicker, Row, Select, Space, Statistic, Table, Tag } from 'antd'
import { ArrowLeftOutlined } from '@ant-design/icons'
import type { ColumnsType } from 'antd/es/table'
import type { Dayjs } from 'dayjs'
import { useWheelStats, useWheels } from '@/hooks/useWheel'
import type { WheelStatsKind, WheelStatsPlayer, WheelStatsReward, WheelStatsWheel } from '@/types'
import { kindMeta } from './wheel/wheelHelpers'

export function WheelStatsPage() {
  const navigate = useNavigate()
  const { data: wheels } = useWheels()
  const [wheelId, setWheelId] = useState<string | undefined>(undefined)
  const [range, setRange] = useState<[Dayjs, Dayjs] | null>(null)

  const params = useMemo(
    () => ({
      ...(wheelId ? { wheelId } : {}),
      ...(range ? { from: range[0].startOf('day').toISOString(), to: range[1].endOf('day').toISOString() } : {}),
    }),
    [wheelId, range]
  )

  const { data, isFetching } = useWheelStats(params)
  const overview = data?.overview

  const kindColumns: ColumnsType<WheelStatsKind> = [
    {
      title: 'Loại ô',
      dataIndex: 'segmentKind',
      render: (value) => <Tag color={kindMeta(value).color}>{kindMeta(value).label}</Tag>,
    },
    { title: 'Lượt', dataIndex: 'spins', align: 'right' },
    { title: '%', dataIndex: 'percent', align: 'right', render: (v: number) => `${v.toFixed(1)}%` },
  ]

  const rewardColumns: ColumnsType<WheelStatsReward> = [
    { title: 'Phần thưởng', dataIndex: 'rewardLabel' },
    {
      title: 'Loại',
      dataIndex: 'segmentKind',
      render: (value) => <Tag color={kindMeta(value).color}>{kindMeta(value).label}</Tag>,
    },
    { title: 'Số lần', dataIndex: 'count', align: 'right' },
  ]

  const wheelColumns: ColumnsType<WheelStatsWheel> = [
    { title: 'Vòng quay', dataIndex: 'wheelName' },
    { title: 'Lượt', dataIndex: 'spins', align: 'right' },
    { title: 'Ken thu', dataIndex: 'kenIn', align: 'right', render: (v: number) => v.toLocaleString('vi-VN') },
    { title: 'Ken trả', dataIndex: 'kenOut', align: 'right', render: (v: number) => v.toLocaleString('vi-VN') },
    {
      title: 'RTP',
      dataIndex: 'rtp',
      align: 'right',
      render: (v: number) => {
        const color = v > 100 ? '#c0392b' : v > 70 ? '#d4a017' : '#1f8a3b'
        return <span style={{ color }}>{v.toFixed(1)}%</span>
      },
    },
  ]

  const playerColumns: ColumnsType<WheelStatsPlayer> = [
    { title: 'Người chơi', key: 'user', render: (_, p) => p.user?.fullName || p.user?.username || '—' },
    { title: 'Lượt', dataIndex: 'spins', align: 'right' },
    {
      title: 'Ken chi',
      dataIndex: 'kenSpent',
      align: 'right',
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card
        title={
          <Space>
            <Button type="text" icon={<ArrowLeftOutlined />} onClick={() => navigate('/games/wheel')} />
            Thống kê vòng quay
          </Space>
        }
        extra={
          <Space>
            <Select
              allowClear
              placeholder="Tất cả vòng quay"
              style={{ width: 200 }}
              value={wheelId}
              onChange={setWheelId}
              options={(wheels ?? []).map((w) => ({ value: w.id, label: w.name }))}
            />
            <DatePicker.RangePicker value={range} onChange={(v) => setRange(v as [Dayjs, Dayjs] | null)} />
          </Space>
        }
        loading={isFetching && !data}
      >
        <Row gutter={16}>
          <Col span={6}>
            <Statistic groupSeparator="." title="Tổng lượt quay" value={overview?.totalSpins ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Người chơi" value={overview?.uniquePlayers ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Tỉ lệ trúng" value={overview?.winRate ?? 0} precision={1} suffix="%" />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Lượt miễn phí" value={overview?.freeSpins ?? 0} />
          </Col>
        </Row>
        <Row gutter={16} style={{ marginTop: 16 }}>
          <Col span={6}>
            <Statistic groupSeparator="." title="Ken thu" value={overview?.kenIn ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Ken trả thưởng" value={overview?.kenOut ?? 0} />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="."
              title="Ken ròng"
              value={overview?.netKen ?? 0}
              valueStyle={{ color: (overview?.netKen ?? 0) >= 0 ? '#1f8a3b' : '#c0392b' }}
            />
          </Col>
          <Col span={6}>
            <Statistic groupSeparator="." title="Ngày VIP trao" value={overview?.vipDaysOut ?? 0} />
          </Col>
        </Row>
      </Card>

      <Row gutter={16}>
        <Col span={12}>
          <Card title="Theo loại ô" size="small">
            <Table<WheelStatsKind>
              rowKey="segmentKind"
              size="small"
              columns={kindColumns}
              dataSource={data?.byKind ?? []}
              pagination={false}
            />
          </Card>
        </Col>
        <Col span={12}>
          <Card title="Phần thưởng phổ biến" size="small">
            <Table<WheelStatsReward>
              rowKey={(r) => `${r.segmentKind}-${r.rewardLabel}`}
              size="small"
              columns={rewardColumns}
              dataSource={data?.topRewards ?? []}
              pagination={false}
            />
          </Card>
        </Col>
      </Row>

      <Row gutter={16}>
        <Col span={12}>
          <Card title="Theo vòng quay (RTP)" size="small">
            <Table<WheelStatsWheel>
              rowKey="wheelId"
              size="small"
              columns={wheelColumns}
              dataSource={data?.byWheel ?? []}
              pagination={false}
            />
          </Card>
        </Col>
        <Col span={12}>
          <Card title="Người chơi chi nhiều nhất" size="small">
            <Table<WheelStatsPlayer>
              rowKey={(p) => p.user?.id ?? Math.random().toString()}
              size="small"
              columns={playerColumns}
              dataSource={data?.topPlayers ?? []}
              pagination={false}
            />
          </Card>
        </Col>
      </Row>
    </Space>
  )
}
