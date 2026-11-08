import { useMemo, useState } from 'react'
import {
  App,
  Avatar,
  Button,
  Card,
  Input,
  Space,
  Switch,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import {
  ClearOutlined,
  CommentOutlined,
  DeleteOutlined,
  EditOutlined,
  MessageOutlined,
  PlusOutlined,
} from '@ant-design/icons'
import { useDeleteRoom, useRoomOrder, useRooms, useUpdateRoom } from './useRoomQueries'
import { MoveToTopButton, RenumberButton } from '@/components/ListOrderButtons'
import { SortableTable } from '@/components/SortableTable'
import { formatDateTime } from '@/lib/format'
import { errorMessage } from '@/lib/apiError'
import { RoomFormModal } from './RoomFormModal'
import { RoomMessagesModal } from './RoomMessagesModal'
import { RoomImagePurgeModal } from './RoomImagePurgeModal'
import type { Room } from '@/types'

export function RoomsPage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')

  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<Room | null>(null)
  const [msgOpen, setMsgOpen] = useState(false)
  const [msgRoom, setMsgRoom] = useState<Room | null>(null)
  const [purgeOpen, setPurgeOpen] = useState(false)

  const { data, isFetching } = useRooms()
  const rooms = useMemo(() => data ?? [], [data])
  const order = useRoomOrder(rooms)
  const query = search.trim().toLowerCase()
  const visibleRooms = useMemo(
    () => (query ? rooms.filter((room) => room.name.toLowerCase().includes(query)) : rooms),
    [rooms, query],
  )
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

  function openMessages(room: Room) {
    setMsgRoom(room)
    setMsgOpen(true)
  }

  function toggleEnabled(room: Room, enabled: boolean) {
    modal.confirm({
      title: enabled ? 'Bật phòng này?' : 'Tắt phòng này?',
      content: enabled
        ? 'Phòng sẽ hoạt động trở lại với người dùng.'
        : 'Phòng sẽ bị tắt, người dùng không vào được.',
      okText: enabled ? 'Bật' : 'Tắt',
      okButtonProps: { danger: !enabled },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await updateRoom.mutateAsync({ id: room.id, payload: { enabled } })
          message.success(enabled ? 'Đã bật phòng' : 'Đã tắt phòng')
        } catch (err) {
          message.error(errorMessage(err, 'Thao tác thất bại'))
        }
      },
    })
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
          message.error(errorMessage(err, 'Xoá thất bại'))
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
      title: 'VIP',
      dataIndex: 'vipRequired',
      width: 130,
      render: (_, room) =>
        room.vipRequired ? (
          <Tag color="gold">
            {room.vipMinMembers > 0 ? `VIP từ ${room.vipMinMembers} người` : 'VIP'}
          </Tag>
        ) : (
          '—'
        ),
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
      width: 280,
      render: (_, room) => (
        <Space>
          <MoveToTopButton
            name={room.name}
            disabled={order.isFirst(room) || order.saving}
            onClick={() => order.moveToTop(room)}
          />
          <Button
            size="small"
            icon={<MessageOutlined />}
            onClick={() => openMessages(room)}
          >
            Tin nhắn
          </Button>
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
          onChange={(e) => setSearch(e.target.value)}
          style={{ maxWidth: 360 }}
        />
        <Space wrap>
          <RenumberButton disabled={order.numbered || order.saving} onClick={order.renumber} />
          <Button icon={<ClearOutlined />} onClick={() => setPurgeOpen(true)}>
            Xoá ảnh cũ
          </Button>
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Tạo phòng
          </Button>
        </Space>
      </div>
      <SortableTable<Room>
        items={visibleRooms}
        columns={columns}
        loading={isFetching}
        scroll={{ x: 1100 }}
        pagination={false}
        footer={() =>
          query
            ? `${visibleRooms.length} phòng. Xoá ô tìm kiếm để kéo đổi thứ tự.`
            : `${rooms.length} phòng. Kéo biểu tượng đầu dòng để đổi thứ tự.`
        }
        reorderDisabled={order.saving || query !== ''}
        onReorder={order.save}
      />
      <RoomFormModal
        open={formOpen}
        room={editing}
        nextPosition={order.nextPosition}
        onClose={() => setFormOpen(false)}
      />
      <RoomMessagesModal
        roomId={msgRoom?.id ?? null}
        roomName={msgRoom?.name}
        open={msgOpen}
        onClose={() => setMsgOpen(false)}
      />
      <RoomImagePurgeModal open={purgeOpen} onClose={() => setPurgeOpen(false)} />
    </Card>
  )
}
