import type { ReactNode } from 'react'
import {
  App,
  Avatar,
  Button,
  Divider,
  Empty,
  Image,
  List,
  Modal,
  Skeleton,
  Space,
  Switch,
  Tag,
  Typography,
} from 'antd'
import { DeleteOutlined, EnvironmentOutlined, UserOutlined } from '@ant-design/icons'
import {
  useDeleteMeComment,
  useMeComments,
  useMeDetail,
  useUpdateMeStatus,
} from '@/hooks/useMe'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { VISIBILITY } from './meVisibility'

interface MeDetailModalProps {
  postId: string | null
  open: boolean
  onClose: () => void
}

const labelStyle: React.CSSProperties = {
  fontSize: 12,
  fontWeight: 600,
  color: '#8c98a4',
  textTransform: 'uppercase',
  letterSpacing: 0.4,
  marginBottom: 8,
}

function Section({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div style={{ marginTop: 20 }}>
      <div style={labelStyle}>{title}</div>
      {children}
    </div>
  )
}

function StatBox({ label, value, color }: { label: string; value: number; color: string }) {
  return (
    <div
      style={{
        flex: 1,
        textAlign: 'center',
        padding: '12px 8px',
        background: '#f6f8fa',
        borderRadius: 10,
      }}
    >
      <div style={{ fontSize: 22, fontWeight: 700, color }}>{value}</div>
      <div style={{ fontSize: 12, color: '#6b7785' }}>{label}</div>
    </div>
  )
}

export function MeDetailModal({ postId, open, onClose }: MeDetailModalProps) {
  const { message, modal } = App.useApp()
  const id = open ? postId : null
  const { data, isLoading } = useMeDetail(id)
  const { data: comments, isLoading: commentsLoading } = useMeComments(id)
  const updateStatus = useUpdateMeStatus()
  const deleteComment = useDeleteMeComment()

  async function toggleEnabled(enabled: boolean) {
    if (!postId) return
    try {
      await updateStatus.mutateAsync({ id: postId, enabled })
      message.success(enabled ? 'Đã hiện bài' : 'Đã ẩn bài')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
    }
  }

  function removeComment(commentId: string) {
    if (!postId) return
    modal.confirm({
      title: 'Xoá bình luận?',
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteComment.mutateAsync({ id: postId, commentId })
          message.success('Đã xoá bình luận')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const visibility = data
    ? VISIBILITY[data.visibility] ?? { label: data.visibility, color: 'default' }
    : null

  return (
    <Modal
      title="Chi tiết bài đăng"
      open={open}
      onCancel={onClose}
      centered
      width={640}
      styles={{ body: { maxHeight: '72vh', overflowY: 'auto', paddingRight: 8 } }}
      footer={[
        <Button key="close" onClick={onClose}>
          Đóng
        </Button>,
      ]}
    >
      {isLoading || !data ? (
        <Skeleton active avatar paragraph={{ rows: 6 }} />
      ) : (
        <>
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: 12,
              padding: '14px 16px',
              background: '#fafbfc',
              border: '1px solid #eef1f4',
              borderRadius: 12,
            }}
          >
            <Avatar src={data.author?.avatar} icon={<UserOutlined />} size={48} />
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 16, fontWeight: 600 }}>
                {data.author?.fullName || data.author?.username || '—'}
              </div>
              {data.author?.username && (
                <div style={{ color: '#6b7785' }}>@{data.author.username}</div>
              )}
            </div>
            <Space style={{ marginLeft: 'auto' }} direction="vertical" align="end" size={6}>
              {visibility && <Tag color={visibility.color}>{visibility.label}</Tag>}
              <Switch
                checked={data.enabled}
                checkedChildren="Hiện"
                unCheckedChildren="Ẩn"
                loading={updateStatus.isPending}
                onChange={toggleEnabled}
              />
            </Space>
          </div>

          {data.content && (
            <Section title="Nội dung">
              <Typography.Paragraph style={{ whiteSpace: 'pre-wrap', marginBottom: 0 }}>
                {data.content}
              </Typography.Paragraph>
            </Section>
          )}

          {data.images.length > 0 && (
            <Section title={`Ảnh (${data.images.length})`}>
              <Image.PreviewGroup>
                <Space wrap size={8}>
                  {data.images.map((img) => (
                    <Image
                      key={img.url}
                      src={img.url}
                      width={104}
                      height={104}
                      style={{ objectFit: 'cover', borderRadius: 10 }}
                    />
                  ))}
                </Space>
              </Image.PreviewGroup>
            </Section>
          )}

          {data.checkIn && (
            <Section title="Check-in">
              <div
                style={{
                  background: '#fff7e6',
                  border: '1px solid #ffe7ba',
                  borderRadius: 10,
                  padding: '10px 14px',
                }}
              >
                <div style={{ fontWeight: 600 }}>
                  <EnvironmentOutlined style={{ color: '#fa8c16', marginRight: 6 }} />
                  {data.checkIn.actionIcon ? `${data.checkIn.actionIcon} ` : ''}
                  {data.checkIn.name}
                </div>
                {data.checkIn.action && (
                  <div style={{ color: '#6b7785', marginTop: 2 }}>{data.checkIn.action}</div>
                )}
                {data.checkIn.address && (
                  <div style={{ color: '#6b7785', marginTop: 2 }}>{data.checkIn.address}</div>
                )}
                {data.checkIn.lat != null && data.checkIn.lng != null && (
                  <div style={{ color: '#9aa4b0', fontSize: 12, marginTop: 2 }}>
                    {data.checkIn.lat}, {data.checkIn.lng}
                  </div>
                )}
              </div>
            </Section>
          )}

          {data.sticker && (
            <Section title="Sticker">
              <Tag color="purple">{data.sticker}</Tag>
            </Section>
          )}

          {data.mentions && data.mentions.length > 0 && (
            <Section title="Nhắc đến">
              <Space wrap size={4}>
                {data.mentions.map((m) => (
                  <Tag key={m}>{m}</Tag>
                ))}
              </Space>
            </Section>
          )}

          <Section title="Tương tác">
            <div style={{ display: 'flex', gap: 12 }}>
              <StatBox label="Thích" value={data.likeCount} color="#16a34a" />
              <StatBox label="Không thích" value={data.dislikeCount} color="#dc2626" />
              <StatBox label="Bình luận" value={data.commentCount} color="#2563eb" />
            </div>
          </Section>

          <Section title="Thông tin">
            <div style={{ fontSize: 13, color: '#4b5563', lineHeight: 1.9 }}>
              <div>
                Ngày tạo: <b>{formatDateTime(data.createdAt)}</b>
              </div>
              <div>
                Cập nhật: <b>{formatDateTime(data.updatedAt)}</b>
              </div>
              <div>
                ID:{' '}
                <Typography.Text copyable style={{ fontSize: 12 }}>
                  {data.id}
                </Typography.Text>
              </div>
            </div>
          </Section>

          <Divider style={{ marginTop: 24, marginBottom: 12 }}>
            Bình luận ({data.commentCount})
          </Divider>

          {commentsLoading ? (
            <Skeleton active paragraph={{ rows: 3 }} />
          ) : comments && comments.items.length > 0 ? (
            <List
              dataSource={comments.items}
              renderItem={(comment) => (
                <List.Item
                  actions={[
                    <Button
                      key="del"
                      size="small"
                      danger
                      type="text"
                      icon={<DeleteOutlined />}
                      onClick={() => removeComment(comment.id)}
                    />,
                  ]}
                >
                  <List.Item.Meta
                    avatar={<Avatar src={comment.author?.avatar} icon={<UserOutlined />} />}
                    title={comment.author?.fullName || comment.author?.username || '—'}
                    description={
                      <>
                        <div style={{ color: 'rgba(0,0,0,0.85)' }}>{comment.content}</div>
                        <div style={{ fontSize: 12, color: '#9aa4b0' }}>
                          {formatDateTime(comment.createdAt)}
                        </div>
                      </>
                    }
                  />
                </List.Item>
              )}
            />
          ) : (
            <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có bình luận" />
          )}
        </>
      )}
    </Modal>
  )
}
