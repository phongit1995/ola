import { useState } from 'react'
import {
  App,
  Button,
  Card,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, EditOutlined, LinkOutlined, PlusOutlined } from '@ant-design/icons'
import {
  useAnnouncements,
  useDeleteAnnouncement,
  useUpdateAnnouncement,
} from '@/hooks/useAnnouncements'
import { ApiError } from '@/lib/apiError'
import { AnnouncementFormModal } from './AnnouncementFormModal'
import type { Announcement } from '@/types'

export function AnnouncementPage() {
  const { message, modal } = App.useApp()

  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<Announcement | null>(null)

  const { data, isFetching } = useAnnouncements()
  const updateAnnouncement = useUpdateAnnouncement()
  const deleteAnnouncement = useDeleteAnnouncement()

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
  }

  function openEdit(item: Announcement) {
    setEditing(item)
    setFormOpen(true)
  }

  function toggleActive(item: Announcement, isActive: boolean) {
    modal.confirm({
      title: isActive ? 'Bật thông báo này?' : 'Tắt thông báo này?',
      content: isActive
        ? `"${item.title}" sẽ hiển thị trên banner của người dùng nếu là thông báo mới nhất.`
        : `"${item.title}" sẽ không còn hiển thị trên banner của người dùng.`,
      okText: isActive ? 'Bật' : 'Tắt',
      okButtonProps: { danger: !isActive },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await updateAnnouncement.mutateAsync({ id: item.id, payload: { isActive } })
          message.success(isActive ? 'Đã bật thông báo' : 'Đã tắt thông báo')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
        }
      },
    })
  }

  function removeAnnouncement(item: Announcement) {
    modal.confirm({
      title: 'Xoá thông báo?',
      content: `"${item.title}" sẽ bị xoá khỏi danh sách thông báo.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteAnnouncement.mutateAsync(item.id)
          message.success('Đã xoá thông báo')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<Announcement> = [
    {
      title: 'Tiêu đề',
      dataIndex: 'title',
      width: 260,
      render: (v: string) => <Typography.Text strong>{v}</Typography.Text>,
    },
    {
      title: 'Nội dung',
      dataIndex: 'content',
      ellipsis: true,
      render: (v: string) => v || <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'Liên kết',
      dataIndex: 'link',
      width: 200,
      ellipsis: true,
      render: (url: string) =>
        url ? (
          <Typography.Link href={url} target="_blank" rel="noreferrer">
            <LinkOutlined /> {url}
          </Typography.Link>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'Thời gian hiển thị',
      key: 'schedule',
      width: 200,
      render: (_, item) =>
        item.startsAt || item.endsAt ? (
          <Space direction="vertical" size={0}>
            <Typography.Text>
              Từ: {item.startsAt ? new Date(item.startsAt).toLocaleString('vi-VN') : '—'}
            </Typography.Text>
            <Typography.Text>
              Đến: {item.endsAt ? new Date(item.endsAt).toLocaleString('vi-VN') : '—'}
            </Typography.Text>
          </Space>
        ) : (
          <Typography.Text type="secondary">Không giới hạn</Typography.Text>
        ),
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'createdAt',
      width: 160,
      render: (v: string) => new Date(v).toLocaleString('vi-VN'),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isActive',
      width: 130,
      render: (isActive: boolean, item) => (
        <Space>
          <Switch
            checked={isActive}
            loading={updateAnnouncement.isPending}
            onChange={(value) => toggleActive(item, value)}
          />
          <Tag color={isActive ? 'green' : 'default'}>{isActive ? 'Bật' : 'Tắt'}</Tag>
        </Space>
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 160,
      render: (_, item) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(item)}>
            Sửa
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => removeAnnouncement(item)}
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
          justifyContent: 'flex-end',
        }}
      >
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Tạo thông báo
        </Button>
      </div>
      <Table<Announcement>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 1000 }}
        pagination={false}
      />
      <AnnouncementFormModal
        open={formOpen}
        announcement={editing}
        onClose={() => setFormOpen(false)}
      />
    </Card>
  )
}
