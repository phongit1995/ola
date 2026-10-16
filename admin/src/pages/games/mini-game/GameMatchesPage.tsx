import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Button,
  Card,
  Input,
  InputNumber,
  Select,
  Space,
  Table,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { BarChartOutlined, ReloadOutlined, TrophyFilled } from '@ant-design/icons'
import { useGameMatches } from './useGameMatchQueries'
import type {
  AdminGameMatch,
  GameMatchMode,
  GameMatchReason,
  GameMatchStatus,
} from '@/types'
import {
  GAME_MATCH_MODE_LABEL,
  GAME_MATCH_REASON_META,
  GAME_MATCH_STATUS_META,
  gameLabel,
} from './gameMatchMeta'
import { formatCount, formatDateTime } from '@/lib/format'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { toIsoRange } from '@/lib/dateRange'
import { UserBriefCell } from '@/components/UserBriefCell'
import { useGameOptions } from './useGameOptions'

const PAGE_SIZE = 20

const WINNER_BADGE = <TrophyFilled style={{ color: '#faad14' }} />

const STATUS_OPTIONS = [
  { value: 'playing' as const, label: 'Đang chơi' },
  { value: 'finished' as const, label: 'Đã kết thúc' },
]

const REASON_OPTIONS = (
  Object.keys(GAME_MATCH_REASON_META) as GameMatchReason[]
).map((reason) => ({ value: reason, label: GAME_MATCH_REASON_META[reason].label }))

const MODE_OPTIONS = (Object.keys(GAME_MATCH_MODE_LABEL) as GameMatchMode[]).map((mode) => ({
  value: mode,
  label: GAME_MATCH_MODE_LABEL[mode],
}))

export function GameMatchesPage() {
  const navigate = useNavigate()
  const [gameId, setGameId] = useState<string | undefined>(undefined)
  const [status, setStatus] = useState<GameMatchStatus | undefined>(undefined)
  const [reason, setReason] = useState<GameMatchReason | undefined>(undefined)
  const [mode, setMode] = useState<GameMatchMode | undefined>(undefined)
  const [userId, setUserId] = useState('')
  const [minBet, setMinBet] = useState<number | null>(null)
  const [maxBet, setMaxBet] = useState<number | null>(null)
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')
  const [page, setPage] = useState(1)

  const { gameNames, gameOptions } = useGameOptions()

  const params = useMemo(
    () => ({
      gameId,
      status,
      reason,
      mode,
      userId: userId || undefined,
      minBet: minBet ?? undefined,
      maxBet: maxBet ?? undefined,
      ...toIsoRange(from, to),
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [gameId, status, reason, mode, userId, minBet, maxBet, from, to, page],
  )

  const { data, isFetching, refetch } = useGameMatches(params)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: ColumnsType<AdminGameMatch> = [
    {
      title: 'Bắt đầu',
      dataIndex: 'startedAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Game',
      dataIndex: 'gameId',
      width: 110,
      render: (value: string) => <Tag color="purple">{gameLabel(value, gameNames)}</Tag>,
    },
    {
      title: 'Người chơi 1',
      key: 'player0',
      render: (_, row) => (
        <UserBriefCell
          user={row.player0}
          badge={!!row.winnerId && row.winnerId === row.player0?.id && WINNER_BADGE}
        />
      ),
    },
    {
      title: 'Người chơi 2',
      key: 'player1',
      render: (_, row) => (
        <UserBriefCell
          user={row.player1}
          badge={!!row.winnerId && row.winnerId === row.player1?.id && WINNER_BADGE}
        />
      ),
    },
    {
      title: 'Chế độ',
      dataIndex: 'mode',
      width: 130,
      render: (value: GameMatchMode) => GAME_MATCH_MODE_LABEL[value] ?? value,
    },
    {
      title: 'Cược/người',
      dataIndex: 'bet',
      width: 110,
      align: 'right',
      render: (value: number) => (value > 0 ? `${formatCount(value)} Ken` : 'Miễn phí'),
    },
    {
      title: 'Trạng thái',
      key: 'status',
      width: 180,
      render: (_, row) => (
        <Space size={4} wrap>
          <Tag color={GAME_MATCH_STATUS_META[row.status].color} style={{ margin: 0 }}>
            {GAME_MATCH_STATUS_META[row.status].label}
          </Tag>
          {row.reason && GAME_MATCH_REASON_META[row.reason] && (
            <Tag color={GAME_MATCH_REASON_META[row.reason].color} style={{ margin: 0 }}>
              {GAME_MATCH_REASON_META[row.reason].label}
            </Tag>
          )}
        </Space>
      ),
    },
    {
      title: 'Thắng ròng / HH',
      key: 'money',
      width: 150,
      align: 'right',
      render: (_, row) =>
        row.status === 'finished' && row.winnerId ? (
          <Typography.Text>
            +{formatCount(row.kenDelta)} /{' '}
            <Typography.Text type="success">{formatCount(row.houseTake)}</Typography.Text>
          </Typography.Text>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'Nước',
      dataIndex: 'moveCount',
      width: 70,
      align: 'right',
      render: (value: number) => formatCount(value),
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <Select
            allowClear
            placeholder="Game"
            value={gameId}
            onChange={resetPage(setGameId)}
            options={gameOptions}
            style={{ width: 140 }}
          />
          <Input.Search
            allowClear
            placeholder="Lọc theo User ID"
            defaultValue={userId}
            onSearch={resetPage(setUserId)}
            style={{ width: 240 }}
          />
          <Select
            allowClear
            placeholder="Trạng thái"
            value={status}
            onChange={resetPage(setStatus)}
            options={STATUS_OPTIONS}
            style={{ width: 130 }}
          />
          <Select
            allowClear
            placeholder="Kết thúc do"
            value={reason}
            onChange={resetPage(setReason)}
            options={REASON_OPTIONS}
            style={{ width: 170 }}
          />
          <Select
            allowClear
            placeholder="Chế độ"
            value={mode}
            onChange={resetPage(setMode)}
            options={MODE_OPTIONS}
            style={{ width: 150 }}
          />
          <InputNumber
            placeholder="Cược từ"
            min={0}
            value={minBet}
            onChange={resetPage(setMinBet)}
            style={{ width: 110 }}
          />
          <InputNumber
            placeholder="Cược đến"
            min={0}
            value={maxBet}
            onChange={resetPage(setMaxBet)}
            style={{ width: 110 }}
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
          <Button
            type="primary"
            icon={<BarChartOutlined />}
            onClick={() => navigate('/games/matches/stats')}
          >
            Thống kê
          </Button>
        </Space>
      </Card>

      <Table<AdminGameMatch>
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
    </Space>
  )
}
