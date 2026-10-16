import { useMemo, useState } from 'react'
import { Avatar, Button, Card, Input, Select, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { ReloadOutlined } from '@ant-design/icons'
import { useGameLevels } from '@/hooks/useGameMatches'
import { useMiniGames } from '@/hooks/useMiniGames'
import type { AdminGameLevel } from '@/types'
import { GAME_ID_LABEL, gameLabel } from './gameMatchMeta'

const PAGE_SIZE = 20

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function formatTime(iso: string) {
  return new Date(iso).toLocaleString('vi-VN')
}

export function GameLevelsTab() {
  const [gameId, setGameId] = useState<string | undefined>(undefined)
  const [search, setSearch] = useState('')
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
      search: search || undefined,
      limit: PAGE_SIZE,
      offset: (page - 1) * PAGE_SIZE,
    }),
    [gameId, search, page],
  )

  const { data, isFetching, refetch } = useGameLevels(params)

  function resetPage<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      setPage(1)
    }
  }

  const columns: ColumnsType<AdminGameLevel> = [
    {
      title: '#',
      key: 'rank',
      width: 60,
      align: 'right',
      render: (_, __, index) => (page - 1) * PAGE_SIZE + index + 1,
    },
    {
      title: 'Người chơi',
      key: 'user',
      render: (_, row) => (
        <Space size={6}>
          <Avatar size="small" src={row.user.avatar || undefined}>
            {row.user.fullName?.[0] ?? row.user.username?.[0] ?? '?'}
          </Avatar>
          <div>
            <Typography.Text strong>{row.user.fullName || row.user.username}</Typography.Text>
            <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
              @{row.user.username}
            </Typography.Text>
          </div>
        </Space>
      ),
    },
    {
      title: 'Game',
      dataIndex: 'gameId',
      width: 140,
      render: (value: string) => <Tag color="purple">{gameLabel(value, gameNames)}</Tag>,
    },
    {
      title: 'Level',
      dataIndex: 'level',
      width: 90,
      align: 'right',
      render: (value: number) => <Tag color="gold">Lv.{value}</Tag>,
    },
    {
      title: 'EXP',
      dataIndex: 'exp',
      width: 120,
      align: 'right',
      render: (value: number) => vn(value),
    },
    {
      title: 'Cập nhật',
      dataIndex: 'updatedAt',
      width: 150,
      render: (value: string) => formatTime(value),
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card size="small">
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
            placeholder="Tìm username hoặc tên hiển thị"
            defaultValue={search}
            onSearch={resetPage(setSearch)}
            style={{ width: 260 }}
          />
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Table<AdminGameLevel>
        rowKey={(row) => `${row.user.id}:${row.gameId}`}
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
