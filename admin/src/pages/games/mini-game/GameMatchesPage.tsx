import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Avatar,
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
import { useGameMatches } from '@/hooks/useGameMatches'
import { useMiniGames } from '@/hooks/useMiniGames'
import type {
  AdminGameMatch,
  GameMatchMode,
  GameMatchReason,
  GameMatchStatus,
  GameMatchUserBrief,
} from '@/types'
import {
  GAME_ID_LABEL,
  GAME_MATCH_MODE_LABEL,
  GAME_MATCH_REASON_META,
  GAME_MATCH_STATUS_META,
  gameLabel,
} from './gameMatchMeta'

const PAGE_SIZE = 20

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

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function formatTime(iso: string) {
  return new Date(iso).toLocaleString('vi-VN')
}

function PlayerCell({ user, isWinner }: { user?: GameMatchUserBrief; isWinner: boolean }) {
  if (!user) return <Typography.Text type="secondary">—</Typography.Text>
  return (
    <Space size={6}>
      <Avatar size="small" src={user.avatar || undefined}>
        {user.fullName?.[0] ?? user.username?.[0] ?? '?'}
      </Avatar>
      <div>
        <Space size={4}>
          <Typography.Text strong>{user.fullName || user.username}</Typography.Text>
          {isWinner && <TrophyFilled style={{ color: '#faad14' }} />}
        </Space>
        <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
          @{user.username}
        </Typography.Text>
      </div>
    </Space>
  )
}

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

  const params = useMemo(
    () => ({
      gameId,
      status,
      reason,
      mode,
      userId: userId || undefined,
      minBet: minBet ?? undefined,
      maxBet: maxBet ?? undefined,
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
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
      render: (value: string) => formatTime(value),
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
        <PlayerCell user={row.player0} isWinner={!!row.winnerId && row.winnerId === row.player0?.id} />
      ),
    },
    {
      title: 'Người chơi 2',
      key: 'player1',
      render: (_, row) => (
        <PlayerCell user={row.player1} isWinner={!!row.winnerId && row.winnerId === row.player1?.id} />
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
      render: (value: number) => (value > 0 ? `${vn(value)} Ken` : 'Miễn phí'),
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
            +{vn(row.kenDelta)} /{' '}
            <Typography.Text type="success">{vn(row.houseTake)}</Typography.Text>
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
      render: (value: number) => vn(value),
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
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => resetPage(setFrom)(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => resetPage(setTo)(e.target.value)}
            style={DATE_INPUT_STYLE}
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
