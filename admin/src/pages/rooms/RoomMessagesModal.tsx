import { useEffect, useRef } from 'react'
import { App, Avatar, Button, Empty, Image, Modal, Skeleton, Tag, Typography } from 'antd'
import { DeleteOutlined, ReloadOutlined, UserOutlined } from '@ant-design/icons'
import { useDeleteRoomMessage, useRoomMessages } from '@/hooks/useRooms'
import { formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import type { RoomMessage } from '@/types'

interface RoomMessagesModalProps {
  roomId: string | null
  roomName?: string
  open: boolean
  onClose: () => void
}

const REACTION_EMOJI: Record<string, string> = {
  like: '👍',
  love: '❤️',
  haha: '😆',
  wow: '😮',
  sad: '😢',
  angry: '😡',
}

function reactionLabel(type: string) {
  return REACTION_EMOJI[type] ?? type
}

function isImageMessage(m: RoomMessage) {
  return m.type === 'image' || (m.imageUrl != null && m.imageUrl !== '')
}

export function RoomMessagesModal({ roomId, roomName, open, onClose }: RoomMessagesModalProps) {
  const { message: toast, modal } = App.useApp()
  const { data, isLoading, isFetching, refetch } = useRoomMessages(open ? roomId : null)
  const deleteMessage = useDeleteRoomMessage(roomId)
  const messages = data ? [...data.items].reverse() : []
  const bottomRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (!open || !data || data.items.length === 0) return
    const frame = requestAnimationFrame(() => bottomRef.current?.scrollIntoView())
    return () => cancelAnimationFrame(frame)
  }, [open, data])

  function confirmDelete(m: RoomMessage) {
    modal.confirm({
      title: 'Xoá tin nhắn này?',
      content: 'Tin nhắn sẽ bị xoá khỏi phòng cho tất cả mọi người và không thể hoàn tác.',
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteMessage.mutateAsync(m.id)
          toast.success('Đã xoá tin nhắn')
        } catch (err) {
          toast.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  return (
    <Modal
      title={roomName ? `Tin nhắn — ${roomName}` : 'Tin nhắn phòng'}
      open={open}
      onCancel={onClose}
      centered
      width={860}
      styles={{ body: { height: '74vh', overflowY: 'auto', background: '#f5f7fa', padding: 20 } }}
      footer={[
        <Button
          key="refresh"
          size="large"
          icon={<ReloadOutlined />}
          loading={isFetching}
          onClick={() => void refetch()}
        >
          Làm mới
        </Button>,
        <Button key="close" size="large" onClick={onClose}>
          Đóng
        </Button>,
      ]}
    >
      {isLoading ? (
        <Skeleton active avatar paragraph={{ rows: 8 }} />
      ) : messages.length > 0 ? (
        <>
          <Typography.Text type="secondary" style={{ fontSize: 13 }}>
            Hiển thị tối đa 100 tin nhắn gần nhất. Di chuột vào tin nhắn để xoá.
          </Typography.Text>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 18, marginTop: 16 }}>
            {messages.map((m) => {
              const reactions = m.reactions ? Object.entries(m.reactions).filter(([, list]) => list.length > 0) : []
              return (
                <div key={m.id} className="admin-room-msg" style={{ display: 'flex', gap: 14, alignItems: 'flex-start' }}>
                  <Avatar src={m.senderAvatar} icon={<UserOutlined />} size={44} />
                  <div style={{ minWidth: 0, flex: 1 }}>
                    <div style={{ marginBottom: 6, display: 'flex', alignItems: 'center', gap: 8 }}>
                      <span style={{ fontWeight: 600, fontSize: 15 }}>{m.senderName || m.senderId}</span>
                      {m.senderVip != null && m.senderVip !== '' && <Tag color="gold" style={{ margin: 0 }}>VIP</Tag>}
                      <span style={{ fontSize: 12, color: '#9aa4b0' }}>{formatDateTime(m.createdAt)}</span>
                      <Button
                        className="admin-room-msg-del"
                        size="small"
                        type="text"
                        danger
                        icon={<DeleteOutlined />}
                        loading={deleteMessage.isPending}
                        onClick={() => confirmDelete(m)}
                      >
                        Xoá
                      </Button>
                    </div>

                    {m.replyTo != null && (
                      <div
                        style={{
                          borderLeft: '3px solid #d0d5dd',
                          paddingLeft: 10,
                          margin: '0 0 6px',
                          color: '#667085',
                          fontSize: 13,
                        }}
                      >
                        <span style={{ fontWeight: 600 }}>{m.replyTo.senderName || m.replyTo.senderId}</span>
                        {': '}
                        {m.replyTo.type === 'image' && (m.replyTo.excerpt == null || m.replyTo.excerpt === '')
                          ? '[Hình ảnh]'
                          : m.replyTo.excerpt}
                      </div>
                    )}

                    <div
                      style={{
                        display: 'inline-block',
                        background: '#fff',
                        border: '1px solid #e6e9ef',
                        borderRadius: 14,
                        padding: isImageMessage(m) ? 6 : '12px 16px',
                        fontSize: 15,
                        lineHeight: 1.5,
                        color: 'rgba(0,0,0,0.88)',
                        whiteSpace: 'pre-wrap',
                        wordBreak: 'break-word',
                        maxWidth: '100%',
                      }}
                    >
                      {isImageMessage(m) ? (
                        <Image
                          src={m.imageUrl}
                          alt=""
                          style={{ maxWidth: 260, maxHeight: 260, borderRadius: 8, objectFit: 'cover' }}
                        />
                      ) : (
                        m.content
                      )}
                      {isImageMessage(m) && m.content != null && m.content !== '' && (
                        <div style={{ padding: '8px 10px 4px' }}>{m.content}</div>
                      )}
                    </div>

                    {reactions.length > 0 && (
                      <div style={{ marginTop: 6, display: 'flex', flexWrap: 'wrap', gap: 6 }}>
                        {reactions.map(([type, list]) => (
                          <Tag key={type} style={{ margin: 0, borderRadius: 12 }}>
                            {reactionLabel(type)} {list.length}
                          </Tag>
                        ))}
                      </div>
                    )}
                  </div>
                </div>
              )
            })}
          </div>
          <div ref={bottomRef} />
        </>
      ) : (
        <div style={{ paddingTop: 80 }}>
          <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có tin nhắn" />
        </div>
      )}
    </Modal>
  )
}
