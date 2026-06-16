import { useState } from 'react'
import {
  App,
  Avatar,
  Button,
  Card,
  Image,
  Input,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import {
  EnvironmentOutlined,
  EyeOutlined,
  LikeOutlined,
  MessageOutlined,
  UserOutlined,
} from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { useMeList, useUpdateMeStatus } from '@/hooks/useMe'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { MeDetailModal } from './MeDetailModal'
import { VISIBILITY } from './meVisibility'
import type { MeListItem } from '@/types'

const PAGE_SIZE = 20

export function MePage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const [detailId, setDetailId] = useState<string | null>(null)
  const [modalOpen, setModalOpen] = useState(false)

  const { data, isFetching } = useMeList({
    q: q || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const updateStatus = useUpdateMeStatus()

  function openDetail(id: string) {
    setDetailId(id)
    setModalOpen(true)
  }

  function toggleEnabled(post: MeListItem, enabled: boolean) {
    modal.confirm({
      title: enabled ? 'Hiện bài đăng này?' : 'Ẩn bài đăng này?',
      content: enabled
        ? 'Bài sẽ hiển thị lại với người dùng.'
        : 'Bài sẽ bị ẩn khỏi người dùng.',
      okText: enabled ? 'Hiện' : 'Ẩn',
      okButtonProps: { danger: !enabled },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await updateStatus.mutateAsync({ id: post.id, enabled })
          message.success(enabled ? 'Đã hiện bài' : 'Đã ẩn bài')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<MeListItem> = [
    {
      title: 'Tác giả',
      dataIndex: 'author',
      width: 190,
      fixed: 'left',
      render: (_, post) => (
        <Space>
          <Avatar src={post.author?.avatar} icon={<UserOutlined />} />
          <div style={{ lineHeight: 1.2 }}>
            <div style={{ fontWeight: 600 }}>
              {post.author?.fullName || post.author?.username || '—'}
            </div>
            {post.author?.username && (
              <div style={{ fontSize: 12, color: '#6b7785' }}>@{post.author.username}</div>
            )}
          </div>
        </Space>
      ),
    },
    {
      title: 'Nội dung',
      dataIndex: 'content',
      width: 300,
      render: (_, post) => (
        <div style={{ maxWidth: 300 }}>
          {post.content ? (
            <Typography.Paragraph ellipsis={{ rows: 2 }} style={{ marginBottom: post.sticker ? 4 : 0 }}>
              {post.content}
            </Typography.Paragraph>
          ) : (
            <Typography.Text type="secondary">(không có chữ)</Typography.Text>
          )}
          {post.sticker && <Tag color="purple">sticker</Tag>}
        </div>
      ),
    },
    {
      title: 'Ảnh',
      dataIndex: 'images',
      width: 90,
      align: 'center',
      render: (_, post) =>
        post.images.length > 0 ? (
          <Space size={4}>
            <Image.PreviewGroup>
              <Image
                src={post.images[0].url}
                width={40}
                height={40}
                style={{ objectFit: 'cover', borderRadius: 6, cursor: 'pointer' }}
              />
              {post.images.slice(1).map((img) => (
                <Image key={img.url} src={img.url} style={{ display: 'none' }} />
              ))}
            </Image.PreviewGroup>
            {post.images.length > 1 && (
              <span style={{ color: '#6b7785', fontSize: 12 }}>+{post.images.length - 1}</span>
            )}
          </Space>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'Check-in',
      dataIndex: 'checkIn',
      width: 190,
      render: (_, post) =>
        post.checkIn ? (
          <div style={{ lineHeight: 1.3 }}>
            <div style={{ fontWeight: 500 }}>
              <EnvironmentOutlined style={{ color: '#fa8c16', marginRight: 4 }} />
              {post.checkIn.name}
            </div>
            {post.checkIn.address && (
              <div style={{ fontSize: 12, color: '#6b7785' }}>{post.checkIn.address}</div>
            )}
          </div>
        ) : (
          <Typography.Text type="secondary">—</Typography.Text>
        ),
    },
    {
      title: 'Hiển thị',
      dataIndex: 'visibility',
      width: 100,
      render: (v: string) => {
        const info = VISIBILITY[v] ?? { label: v, color: 'default' }
        return <Tag color={info.color}>{info.label}</Tag>
      },
    },
    {
      title: 'Tương tác',
      key: 'stats',
      width: 110,
      render: (_, post) => (
        <Space size={12}>
          <span>
            <LikeOutlined style={{ color: '#8c8c8c' }} /> {post.likeCount}
          </span>
          <span>
            <MessageOutlined style={{ color: '#8c8c8c' }} /> {post.commentCount}
          </span>
        </Space>
      ),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'enabled',
      width: 110,
      render: (enabled: boolean, post) => (
        <Switch
          checked={enabled}
          checkedChildren="Hiện"
          unCheckedChildren="Ẩn"
          loading={updateStatus.isPending}
          onChange={(value) => toggleEnabled(post, value)}
        />
      ),
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'createdAt',
      width: 160,
      render: (v) => formatDateTime(v),
    },
    {
      title: '',
      key: 'actions',
      width: 110,
      fixed: 'right',
      render: (_, post) => (
        <Button size="small" icon={<EyeOutlined />} onClick={() => openDetail(post.id)}>
          Chi tiết
        </Button>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16, maxWidth: 360 }}>
        <Input.Search
          allowClear
          placeholder="Tìm theo nội dung..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
      </div>
      <Table<MeListItem>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 1260 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} bài đăng`,
          onChange: setPage,
        }}
      />
      <MeDetailModal postId={detailId} open={modalOpen} onClose={() => setModalOpen(false)} />
    </Card>
  )
}
