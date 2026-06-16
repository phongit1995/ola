import { useState } from 'react'
import {
  App,
  Avatar,
  Button,
  Card,
  Input,
  Space,
  Switch,
  Table,
  Typography,
  type TableColumnsType,
} from 'antd'
import {
  CommentOutlined,
  DeleteOutlined,
  EditOutlined,
  PlusOutlined,
} from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { useDeleteRoom, useRooms, useUpdateRoom } from '@/hooks/useRooms'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { RoomFormModal } from './RoomFormModal'
import type { Room } from '@/types'

const PAGE_SIZE = 20

export function RoomsPage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<Room | null>(null)

  const { data, isFetching } = useRooms({
    q: q || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const updateRoom = useUpdateRoom()
  const deleteRoom = useDeleteRoom()

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
  }

  function openEdit(room: Room) {
    setEditing(room)
    setFormOpen(true)
  }

  async function toggleEnabled(room: Room, enabled: boolean) {
    try {
      await updateRoom.mutateAsync({ id: room.id, payload: { enabled } })
      message.success(enabled ? 'Đã bật phòng' : 'Đã tắt phòng')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
    }
  }

  function removeRoom(room: Room) {
    modal.confirm({
      title: 'Xoá phòng?',
      content: `${room.name} — hành động này không thể hoàn tác.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteRoom.mutateAsync(room.id)
          message.success('Đã xoá phòng')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<Room> = [
    {
      title: 'Phòng',
      dataIndex: 'name',
      render: (_, room) => (
        <Space>
          <Avatar src={room.imageUrl} icon={<CommentOutlined />} shape="square" />
          <div style={{ lineHeight: 1.3, maxWidth: 320 }}>
            <div style={{ fontWeight: 600 }}>{room.name}</div>
            {room.description && (
              <Typography.Text type="secondary" ellipsis style={{ fontSize: 12 }}>
                {room.description}
              </Typography.Text>
            )}
          </div>
        </Space>
      ),
    },
    {
      title: 'Thứ tự',
      dataIndex: 'index',
      width: 90,
      render: (v: number) => v ?? 0,
    },
    {
      title: 'Thành viên',
      dataIndex: 'memberCount',
      width: 130,
      render: (_, room) =>
        `${room.memberCount}${room.maxMembers > 0 ? ` / ${room.maxMembers}` : ''}`,
    },
    {
      title: 'Bật',
      dataIndex: 'enabled',
      width: 90,
      render: (enabled: boolean, room) => (
        <Switch
          checked={enabled}
          loading={updateRoom.isPending}
          onChange={(value) => toggleEnabled(room, value)}
        />
      ),
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'createdAt',
      width: 170,
      render: (v) => formatDateTime(v),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 150,
      render: (_, room) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(room)}>
            Sửa
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => removeRoom(room)}
          />
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
          justifyContent: 'space-between',
          gap: 12,
          flexWrap: 'wrap',
        }}
      >
        <Input.Search
          allowClear
          placeholder="Tìm theo tên phòng..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
          style={{ maxWidth: 360 }}
        />
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Tạo phòng
        </Button>
      </div>
      <Table<Room>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 760 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} phòng`,
          onChange: setPage,
        }}
      />
      <RoomFormModal open={formOpen} room={editing} onClose={() => setFormOpen(false)} />
    </Card>
  )
}
