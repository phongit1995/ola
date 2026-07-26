import { useMemo, useState } from 'react'
import {
  Avatar,
  Card,
  Col,
  Empty,
  InputNumber,
  Row,
  Select,
  Space,
  Spin,
  Statistic,
  Table,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import {
  Bar,
  CartesianGrid,
  Cell,
  ComposedChart,
  Legend,
  Line,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip as RTooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { useGameMatchStats, useGameMatchSuspects } from '@/hooks/useGameMatches'
import { useMiniGames } from '@/hooks/useMiniGames'
import type {
  GameMatchMode,
  GameMatchStatsGameRow,
  GameMatchStatsPlayer,
  GameMatchSuspectPair,
  GameMatchUserBrief,
} from '@/types'
import {
  GAME_ID_LABEL,
  GAME_MATCH_MODE_LABEL,
  GAME_MATCH_REASON_META,
  gameLabel,
} from './gameMatchMeta'

const REASON_COLOR: Record<string, string> = {
  win: '#52c41a',
  forfeit: '#fa8c16',
  timeout: '#fa541c',
  draw: '#2f54eb',
  disconnect: '#f5222d',
  void: '#8c8c8c',
}

const MODE_OPTIONS = (Object.keys(GAME_MATCH_MODE_LABEL) as GameMatchMode[]).map((mode) => ({
  value: mode,
  label: GAME_MATCH_MODE_LABEL[mode],
}))

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

function isoDate(d: Date) {
  return d.toISOString().slice(0, 10)
}

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function UserCell({ user }: { user: GameMatchUserBrief }) {
  return (
    <Space>
      <Avatar size="small" src={user.avatar || undefined}>
        {user.username?.[0] ?? '?'}
      </Avatar>
      <Typography.Text strong>@{user.username}</Typography.Text>
    </Space>
  )
}

function NetKenText({ value }: { value: number }) {
  if (value > 0) return <Typography.Text type="success">+{vn(value)}</Typography.Text>
  if (value < 0) return <Typography.Text type="danger">{vn(value)}</Typography.Text>
  return <Typography.Text>0</Typography.Text>
}

const playerColumns: ColumnsType<GameMatchStatsPlayer> = [
  {
    title: 'Người chơi',
    key: 'user',
    render: (_, row) => <UserCell user={row.user} />,
  },
  { title: 'Trận', dataIndex: 'matches', width: 80, align: 'right', render: (v: number) => vn(v) },
  { title: 'Thắng', dataIndex: 'wins', width: 80, align: 'right', render: (v: number) => vn(v) },
  {
    title: 'Tỉ lệ thắng',
    dataIndex: 'winRate',
    width: 100,
    align: 'right',
    render: (v: number) => `${v.toFixed(1)}%`,
  },
  {
    title: 'Tổng cược',
    dataIndex: 'staked',
    width: 120,
    align: 'right',
    render: (v: number) => vn(v),
  },
  {
    title: 'Ken ròng',
    dataIndex: 'netKen',
    width: 120,
    align: 'right',
    render: (v: number) => <NetKenText value={v} />,
  },
]

const pairColumns: ColumnsType<GameMatchSuspectPair> = [
  {
    title: 'Cặp đấu',
    key: 'pair',
    render: (_, row) => (
      <Space direction="vertical" size={2}>
        <UserCell user={row.userA} />
        <UserCell user={row.userB} />
      </Space>
    ),
  },
  { title: 'Trận', dataIndex: 'matches', width: 80, align: 'right', render: (v: number) => vn(v) },
  {
    title: 'Thắng A - B',
    key: 'wins',
    width: 110,
    align: 'right',
    render: (_, row) => `${vn(row.aWins)} - ${vn(row.bWins)}`,
  },
  {
    title: 'Độ một chiều',
    dataIndex: 'oneSidedRate',
    width: 120,
    align: 'right',
    render: (v: number, row) =>
      row.decided > 0 ? (
        <Typography.Text type={v >= 80 ? 'danger' : undefined}>{v.toFixed(1)}%</Typography.Text>
      ) : (
        <Typography.Text type="secondary">—</Typography.Text>
      ),
  },
  {
    title: 'Tổng cược',
    dataIndex: 'totalBet',
    width: 110,
    align: 'right',
    render: (v: number) => vn(v),
  },
  {
    title: 'Ken ròng về A',
    dataIndex: 'netA',
    width: 120,
    align: 'right',
    render: (v: number) => <NetKenText value={v} />,
  },
]

export function GameMatchStatsPage() {
  const [gameId, setGameId] = useState<string | undefined>(undefined)
  const [mode, setMode] = useState<GameMatchMode | undefined>(undefined)
  const [from, setFrom] = useState(() => isoDate(new Date(Date.now() - 29 * 24 * 60 * 60 * 1000)))
  const [to, setTo] = useState(() => isoDate(new Date()))
  const [minMatches, setMinMatches] = useState(10)
  const [minPairMatches, setMinPairMatches] = useState(5)

  const { data: games } = useMiniGames()

  const gameNames = useMemo(() => {
    const names: Record<string, string> = {}
    for (const game of games?.items ?? []) {
      names[game.slug] = game.name
    }
    return names
  }, [games])

  const gameOptions = useMemo(() => {
    const slugs = new Set([
      ...Object.keys(GAME_ID_LABEL),
      ...(games?.items ?? []).map((game) => game.slug),
    ])
    return [...slugs].map((slug) => ({ value: slug, label: gameLabel(slug, gameNames) }))
  }, [games, gameNames])

  const range = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )

  const statsParams = useMemo(() => ({ gameId, mode, ...range }), [gameId, mode, range])
  const suspectsParams = useMemo(
    () => ({ gameId, ...range, minMatches, minPairMatches }),
    [gameId, range, minMatches, minPairMatches],
  )

  const { data, isFetching } = useGameMatchStats(statsParams)
  const { data: suspects, isFetching: suspectsFetching } = useGameMatchSuspects(suspectsParams)

  const hasData = (data?.overview.totalMatches ?? 0) > 0

  const reasonPie = (data?.byReason ?? []).map((row) => ({
    name: GAME_MATCH_REASON_META[row.reason]?.label ?? row.reason,
    value: row.count,
    color: REASON_COLOR[row.reason] ?? '#8c8c8c',
  }))

  const gameColumns: ColumnsType<GameMatchStatsGameRow> = [
    {
      title: 'Game',
      dataIndex: 'gameId',
      render: (value: string) => <Tag color="purple">{gameLabel(value, gameNames)}</Tag>,
    },
    { title: 'Trận', dataIndex: 'matches', align: 'right', render: (v: number) => vn(v) },
    { title: 'Đã xong', dataIndex: 'finished', align: 'right', render: (v: number) => vn(v) },
    { title: 'Ken qua kèo', dataIndex: 'volume', align: 'right', render: (v: number) => vn(v) },
    {
      title: 'Hoa hồng',
      dataIndex: 'houseTake',
      align: 'right',
      render: (v: number) => <Typography.Text type="success">{vn(v)}</Typography.Text>,
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Select
            allowClear
            placeholder="Tất cả game"
            value={gameId}
            onChange={setGameId}
            options={gameOptions}
            style={{ width: 150 }}
          />
          <Select
            allowClear
            placeholder="Chế độ"
            value={mode}
            onChange={setMode}
            options={MODE_OPTIONS}
            style={{ width: 150 }}
          />
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => setFrom(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => setTo(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
        </Space>
      </Card>

      {isFetching && !data ? (
        <Card>
          <div style={{ textAlign: 'center', padding: 60 }}>
            <Spin />
          </div>
        </Card>
      ) : !data || !hasData ? (
        <Card>
          <Empty description="Chưa có trận nào trong khoảng đã chọn" />
        </Card>
      ) : (
        <>
          <Row gutter={[16, 16]}>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Tổng trận" value={data.overview.totalMatches} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Đã kết thúc" value={data.overview.finishedMatches} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="."
                  title="Hoa hồng nhà cái (Ken)"
                  value={data.overview.houseTake}
                  valueStyle={{ color: '#3f8600' }}
                />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Ken qua kèo" value={data.overview.totalVolume} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Trả về người chơi (Ken)" value={data.overview.totalPayout} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Người chơi" value={data.overview.uniquePlayers} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Hòa" value={data.overview.drawMatches} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={6}>
              <Card>
                <Statistic groupSeparator="." title="Hủy (hoàn cược)" value={data.overview.voidMatches} />
              </Card>
            </Col>
          </Row>

          <Card title={`Trận & Ken theo ${data.bucket === 'month' ? 'tháng' : 'ngày'}`}>
            <ResponsiveContainer width="100%" height={320}>
              <ComposedChart data={data.timeseries} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="date" fontSize={12} />
                <YAxis yAxisId="left" fontSize={12} />
                <YAxis yAxisId="right" orientation="right" fontSize={12} />
                <RTooltip formatter={(value) => vn(Number(value))} />
                <Legend />
                <Bar yAxisId="left" dataKey="volume" name="Ken qua kèo" fill="#2563eb" radius={[4, 4, 0, 0]} />
                <Bar yAxisId="left" dataKey="houseTake" name="Hoa hồng" fill="#52c41a" radius={[4, 4, 0, 0]} />
                <Line yAxisId="right" type="monotone" dataKey="matches" name="Trận" stroke="#fa541c" strokeWidth={2} />
              </ComposedChart>
            </ResponsiveContainer>
          </Card>

          <Row gutter={[16, 16]}>
            <Col xs={24} lg={10}>
              <Card title="Kết thúc do">
                <ResponsiveContainer width="100%" height={300}>
                  <PieChart>
                    <Pie
                      data={reasonPie}
                      dataKey="value"
                      nameKey="name"
                      innerRadius={60}
                      outerRadius={105}
                      paddingAngle={2}
                    >
                      {reasonPie.map((entry) => (
                        <Cell key={entry.name} fill={entry.color} />
                      ))}
                    </Pie>
                    <RTooltip formatter={(value, name) => [`${vn(Number(value))} trận`, name]} />
                    <Legend />
                  </PieChart>
                </ResponsiveContainer>
              </Card>
            </Col>
            <Col xs={24} lg={14}>
              <Space direction="vertical" size={16} style={{ width: '100%' }}>
                <Card title="Theo game">
                  <Table<GameMatchStatsGameRow>
                    rowKey="gameId"
                    size="small"
                    columns={gameColumns}
                    dataSource={data.byGame}
                    pagination={false}
                  />
                </Card>
                <Card title="Top người chơi (theo Ken ròng)">
                  <Table<GameMatchStatsPlayer>
                    rowKey={(row) => row.user.id}
                    size="small"
                    columns={playerColumns}
                    dataSource={data.topPlayers}
                    pagination={false}
                    locale={{ emptyText: 'Chưa có người chơi nào' }}
                  />
                </Card>
              </Space>
            </Col>
          </Row>

          <Card
            title="Nghi vấn thắng bất thường"
            extra={
              <Space>
                <Typography.Text type="secondary">Tối thiểu trận/user</Typography.Text>
                <InputNumber
                  min={1}
                  value={minMatches}
                  onChange={(v) => setMinMatches(v ?? 10)}
                  style={{ width: 70 }}
                />
                <Typography.Text type="secondary">trận/cặp</Typography.Text>
                <InputNumber
                  min={1}
                  value={minPairMatches}
                  onChange={(v) => setMinPairMatches(v ?? 5)}
                  style={{ width: 70 }}
                />
              </Space>
            }
          >
            <Row gutter={[16, 16]}>
              <Col xs={24} xl={12}>
                <Typography.Title level={5}>User lãi Ken nhiều nhất</Typography.Title>
                <Table<GameMatchStatsPlayer>
                  rowKey={(row) => row.user.id}
                  size="small"
                  loading={suspectsFetching}
                  columns={playerColumns}
                  dataSource={suspects?.players ?? []}
                  pagination={false}
                  locale={{ emptyText: `Không có user nào đủ ${minMatches} trận cược` }}
                />
              </Col>
              <Col xs={24} xl={12}>
                <Typography.Title level={5}>Cặp đấu lặp lại / một chiều</Typography.Title>
                <Table<GameMatchSuspectPair>
                  rowKey={(row) => `${row.userA.id}-${row.userB.id}`}
                  size="small"
                  loading={suspectsFetching}
                  columns={pairColumns}
                  dataSource={suspects?.pairs ?? []}
                  pagination={false}
                  locale={{ emptyText: `Không có cặp nào đủ ${minPairMatches} trận cược` }}
                />
              </Col>
            </Row>
          </Card>
        </>
      )}
    </Space>
  )
}
