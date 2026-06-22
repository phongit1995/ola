import { useState } from 'react'
import { Image, Modal, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { useUserPosts } from '@/hooks/useMe'
import { formatDateTime } from '@/lib/format'
import { VISIBILITY } from './meVisibility'
import { MeDetailModal } from './MeDetailModal'
import type { MeListItem } from '@/types'

const PAGE_SIZE = 10

interface UserMeModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

export function UserMeModal({ open, userId, username, onClose }: UserMeModalProps) {
  const [page, setPage] = useState(1)
  const [detailId, setDetailId] = useState<string | null>(null)
  const [detailOpen, setDetailOpen] = useState(false)

  const { data, isFetching } = useUserPosts(open ? userId : null, {
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  function openDetail(id: string) {
    setDetailId(id)
    setDetailOpen(true)
  }

  const columns: TableColumnsType<MeListItem> = [
    {
      title: 'Nội dung',
      dataIndex: 'content',
      render: (_, post) =>
        post.content ? (
          <Typography.Paragraph ellipsis={{ rows: 2 }} style={{ marginBottom: 0 }}>
            {post.content}
          </Typography.Paragraph>
        ) : (
          <Typography.Text type="secondary">(không có chữ)</Typography.Text>
        ),
    },
    {
      title: 'Ảnh',
      dataIndex: 'images',
      width: 70,
      align: 'center',
      render: (_, post) =>
        post.images.length > 0 ? (
          <Space size={2}>
            <Image
              src={post.images[0].url}
              width={36}
              height={36}
              style={{ objectFit: 'cover', borderRadius: 6 }}
            />
            {post.images.length > 1 && (
              <span style={{ color: '#6b7785', fontSize: 12 }}>+{post.images.length - 1}</span>
            )}
          </Space>
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
      title: 'Trạng thái',
      dataIndex: 'enabled',
      width: 100,
      render: (enabled: boolean) =>
        enabled ? <Tag color="green">Hiện</Tag> : <Tag color="red">Đã ẩn</Tag>,
    },
    {
      title: 'Bình luận',
      dataIndex: 'commentCount',
      width: 90,
      align: 'right',
      render: (v: number) => (v ?? 0).toLocaleString('vi-VN'),
    },
    {
      title: 'Ngày tạo',
      dataIndex: 'createdAt',
      width: 160,
      render: (v: string) => formatDateTime(v),
    },
  ]

  return (
    <>
      <Modal
        title={`Bài đăng (Me)${username ? ` — @${username}` : ''}`}
        open={open}
        onCancel={onClose}
        footer={null}
        width={860}
        destroyOnHidden
      >
        <Table<MeListItem>
          rowKey="id"
          size="small"
          columns={columns}
          dataSource={data?.items ?? []}
          loading={isFetching}
          onRow={(post) => ({
            onClick: () => openDetail(post.id),
            style: { cursor: 'pointer' },
          })}
          pagination={{
            current: page,
            pageSize: PAGE_SIZE,
            total: data?.total ?? 0,
            showTotal: (total) => `${total} bài đăng`,
            onChange: setPage,
          }}
        />
      </Modal>
      <MeDetailModal postId={detailId} open={detailOpen} onClose={() => setDetailOpen(false)} />
    </>
  )
}
