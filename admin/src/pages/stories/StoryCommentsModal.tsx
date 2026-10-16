import { useState } from 'react'
import {
  Alert,
  App,
  Avatar,
  Button,
  Empty,
  List,
  Modal,
  Popconfirm,
  Space,
  Tag,
  Typography,
  theme,
} from 'antd'
import { DeleteOutlined, LikeOutlined, ReloadOutlined, UserOutlined } from '@ant-design/icons'
import { useDeleteStoryComment, useStoryComments } from './useStoryQueries'
import { formatCount, formatDateTime } from '@/lib/format'
import { errorMessage } from '@/lib/apiError'
import type { AdminStory, AdminStoryComment } from '@/types'
import { COMMENT_PAGE_SIZE } from './constants'
import { authorName } from './utils'

interface StoryCommentsModalProps {
  story: AdminStory | null
  open: boolean
  onClose: () => void
}

export function StoryCommentsModal({ story, open, onClose }: StoryCommentsModalProps) {
  const { message } = App.useApp()
  const { token } = theme.useToken()
  const storyId = open && story ? story.id : null
  const [page, setPage] = useState(1)
  const [visibleCount, setVisibleCount] = useState<number | null>(null)

  const { data, isFetching, isError, error, refetch } = useStoryComments(storyId, {
    limit: COMMENT_PAGE_SIZE,
    offset: (page - 1) * COMMENT_PAGE_SIZE,
  })
  const deleteComment = useDeleteStoryComment()

  const total = data?.total ?? 0
  const loadFailed = isError && data === undefined
  const shownCount = visibleCount ?? story?.commentCount

  function close() {
    setPage(1)
    setVisibleCount(null)
    onClose()
  }

  async function removeComment(comment: AdminStoryComment) {
    if (!storyId) return
    try {
      const result = await deleteComment.mutateAsync({ id: storyId, commentId: comment.id })
      setVisibleCount(result.commentCount)
      message.success('Đã xoá bình luận')
    } catch (err) {
      message.error(errorMessage(err, 'Xoá thất bại'))
      void refetch()
    }
  }

  return (
    <Modal
      open={open}
      onCancel={close}
      footer={null}
      width={720}
      title={story ? `Bình luận — ${story.title}` : 'Bình luận'}
      styles={{ body: { maxHeight: '72vh', overflowY: 'auto', paddingRight: 8 } }}
      destroyOnHidden
    >
      <div
        style={{
          marginBottom: 8,
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          gap: 12,
        }}
      >
        <Typography.Text type="secondary">
          {loadFailed
            ? 'Chưa tải được danh sách bình luận.'
            : `${formatCount(total)} bình luận, gồm cả bình luận đã xoá${
                shownCount != null ? ` · đang hiện ${formatCount(shownCount)}` : ''
              }`}
        </Typography.Text>
        <Button icon={<ReloadOutlined />} loading={isFetching} onClick={() => void refetch()} />
      </div>
      {isError && (
        <Alert
          type={loadFailed ? 'error' : 'warning'}
          showIcon
          style={{ marginBottom: 12 }}
          title={
            loadFailed
              ? 'Không tải được bình luận'
              : 'Không tải lại được bình luận, đang hiện dữ liệu lần trước'
          }
          description={errorMessage(error, 'Lỗi không xác định, thử lại sau')}
          action={
            <Button size="small" loading={isFetching} onClick={() => void refetch()}>
              Thử lại
            </Button>
          }
        />
      )}
      {!loadFailed && (
        <List<AdminStoryComment>
          rowKey="id"
          dataSource={data?.items ?? []}
          loading={isFetching}
          locale={{
            emptyText: (
              <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có bình luận" />
            ),
          }}
          pagination={{
            current: page,
            pageSize: COMMENT_PAGE_SIZE,
            total,
            showSizeChanger: false,
            hideOnSinglePage: true,
            size: 'small',
            onChange: setPage,
          }}
          renderItem={(comment) => {
            const deleted = comment.deletedAt != null
            return (
              <List.Item
                actions={
                  deleted
                    ? []
                    : [
                        <Popconfirm
                          key="del"
                          title="Xoá bình luận này?"
                          description="Người dùng sẽ không còn thấy bình luận. Truyện đã mở khoá nhờ bình luận này vẫn giữ nguyên."
                          okText="Xoá"
                          okButtonProps={{ danger: true }}
                          cancelText="Huỷ"
                          placement="topRight"
                          onConfirm={() => removeComment(comment)}
                        >
                          <Button
                            size="small"
                            danger
                            type="text"
                            icon={<DeleteOutlined />}
                            aria-label="Xoá bình luận"
                          />
                        </Popconfirm>,
                      ]
                }
              >
                <List.Item.Meta
                  avatar={<Avatar src={comment.author?.avatar} icon={<UserOutlined />} />}
                  title={
                    <Space size={6} wrap>
                      <span>{authorName(comment)}</span>
                      {comment.author?.fullName && comment.author.username && (
                        <Typography.Text type="secondary" style={{ fontSize: 12, fontWeight: 400 }}>
                          @{comment.author.username}
                        </Typography.Text>
                      )}
                      {deleted && <Tag color="red">Đã xoá</Tag>}
                    </Space>
                  }
                  description={
                    <div style={{ opacity: deleted ? 0.6 : 1 }}>
                      {comment.replyTo && (
                        <div
                          style={{
                            margin: '2px 0 6px',
                            padding: '4px 10px',
                            borderLeft: `3px solid ${token.colorBorder}`,
                            background: token.colorFillQuaternary,
                            borderRadius: 4,
                            fontSize: 12,
                          }}
                        >
                          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                            Trả lời <b>{comment.replyTo.authorName}</b>: {comment.replyTo.excerpt}
                          </Typography.Text>
                        </div>
                      )}
                      <Typography.Paragraph style={{ whiteSpace: 'pre-wrap', marginBottom: 4 }}>
                        {comment.content}
                      </Typography.Paragraph>
                      <Space size={12} style={{ fontSize: 12 }}>
                        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                          {formatDateTime(comment.createdAt)}
                        </Typography.Text>
                        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                          <LikeOutlined /> {formatCount(comment.likeCount)}
                        </Typography.Text>
                        {deleted && (
                          <Typography.Text type="danger" style={{ fontSize: 12 }}>
                            Xoá lúc {formatDateTime(comment.deletedAt)}
                          </Typography.Text>
                        )}
                      </Space>
                    </div>
                  }
                />
              </List.Item>
            )
          }}
        />
      )}
    </Modal>
  )
}
