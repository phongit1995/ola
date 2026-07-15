import { useState } from 'react'
import {
  App,
  Avatar,
  Button,
  Card,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import {
  DeleteOutlined,
  EditOutlined,
  LinkOutlined,
  PlayCircleOutlined,
  PlusOutlined,
} from '@ant-design/icons'
import { useDeleteMiniGame, useMiniGames, useUpdateMiniGame } from '@/hooks/useMiniGames'
import { ApiError } from '@/lib/apiError'
import { MiniGameFormModal } from './MiniGameFormModal'
import type { MiniGame } from '@/types'

export function MiniGamePage() {
  const { message, modal } = App.useApp()

  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<MiniGame | null>(null)

  const { data, isFetching } = useMiniGames()
  const updateGame = useUpdateMiniGame()
  const deleteGame = useDeleteMiniGame()

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
  }

  function openEdit(game: MiniGame) {
    setEditing(game)
    setFormOpen(true)
  }

  function toggleEnabled(game: MiniGame, isEnabled: boolean) {
    modal.confirm({
      title: isEnabled ? 'Bật game này?' : 'Tắt game này?',
      content: isEnabled
        ? `${game.name} sẽ hiển thị trong danh sách mini game của người dùng.`
        : `${game.name} sẽ bị ẩn khỏi danh sách mini game ngay lập tức.`,
      okText: isEnabled ? 'Bật' : 'Tắt',
      okButtonProps: { danger: !isEnabled },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await updateGame.mutateAsync({ id: game.id, payload: { isEnabled } })
          message.success(isEnabled ? 'Đã bật game' : 'Đã tắt game')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
        }
      },
    })
  }

  function removeGame(game: MiniGame) {
    modal.confirm({
      title: 'Xoá mini game?',
      content: `${game.name} — game sẽ biến mất khỏi danh sách của người dùng.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteGame.mutateAsync(game.id)
          message.success('Đã xoá mini game')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<MiniGame> = [
    {
      title: 'Game',
      dataIndex: 'name',
      render: (_, game) => (
        <Space>
          <Avatar
            shape="square"
            size={40}
            src={game.iconUrl || undefined}
            icon={<PlayCircleOutlined />}
          />
          <Space direction="vertical" size={0}>
            <Typography.Text strong>{game.name}</Typography.Text>
            <Tag style={{ marginInlineEnd: 0 }}>{game.slug}</Tag>
          </Space>
        </Space>
      ),
    },
    {
      title: 'Mô tả',
      dataIndex: 'description',
      ellipsis: true,
      render: (v: string) => v || <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'URL game',
      dataIndex: 'gameUrl',
      width: 240,
      ellipsis: true,
      render: (url: string) => (
        <Typography.Link href={url} target="_blank" rel="noreferrer">
          <LinkOutlined /> {url}
        </Typography.Link>
      ),
    },
    {
      title: 'Thứ tự',
      dataIndex: 'sortOrder',
      width: 90,
      render: (v: number) => v ?? 0,
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isEnabled',
      width: 130,
      render: (isEnabled: boolean, game) => (
        <Space>
          <Switch
            checked={isEnabled}
            loading={updateGame.isPending}
            onChange={(value) => toggleEnabled(game, value)}
          />
          <Tag color={isEnabled ? 'green' : 'default'}>{isEnabled ? 'Bật' : 'Tắt'}</Tag>
        </Space>
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 160,
      render: (_, game) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(game)}>
            Sửa
          </Button>
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeGame(game)} />
        </Space>
      ),
    },
  ]

  return (
    <Card>
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          justifyContent: 'flex-end',
        }}
      >
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Tạo mini game
        </Button>
      </div>
      <Table<MiniGame>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 900 }}
        pagination={false}
      />
      <MiniGameFormModal open={formOpen} game={editing} onClose={() => setFormOpen(false)} />
    </Card>
  )
}
