import { useEffect, useRef } from 'react'
import { Avatar, Button, Empty, Modal, Skeleton, Typography } from 'antd'
import { ReloadOutlined, UserOutlined } from '@ant-design/icons'
import { useRoomMessages } from '@/hooks/useRooms'
import { formatDateTime } from '@/lib/format'

interface RoomMessagesModalProps {
  roomId: string | null
  roomName?: string
  open: boolean
  onClose: () => void
}

export function RoomMessagesModal({ roomId, roomName, open, onClose }: RoomMessagesModalProps) {
  const { data, isLoading, isFetching, refetch } = useRoomMessages(open ? roomId : null)
  const messages = data ? [...data.items].reverse() : []
  const bottomRef = useRef<HTMLDivElement>(null)

  useEffect(() => {
    if (!open || !data || data.items.length === 0) return
    const frame = requestAnimationFrame(() => bottomRef.current?.scrollIntoView())
    return () => cancelAnimationFrame(frame)
  }, [open, data])

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
            Hiển thị tối đa 100 tin nhắn gần nhất.
          </Typography.Text>
          <div style={{ display: 'flex', flexDirection: 'column', gap: 18, marginTop: 16 }}>
            {messages.map((m) => (
              <div key={m.id} style={{ display: 'flex', gap: 14, alignItems: 'flex-start' }}>
                <Avatar src={m.senderAvatar} icon={<UserOutlined />} size={44} />
                <div style={{ minWidth: 0, flex: 1 }}>
                  <div style={{ marginBottom: 6 }}>
                    <span style={{ fontWeight: 600, fontSize: 15 }}>
                      {m.senderName || m.senderId}
                    </span>
                    <span style={{ marginLeft: 10, fontSize: 12, color: '#9aa4b0' }}>
                      {formatDateTime(m.createdAt)}
                    </span>
                  </div>
                  <div
                    style={{
                      display: 'inline-block',
                      background: '#fff',
                      border: '1px solid #e6e9ef',
                      borderRadius: 14,
                      padding: '12px 16px',
                      fontSize: 15,
                      lineHeight: 1.5,
                      color: 'rgba(0,0,0,0.88)',
                      whiteSpace: 'pre-wrap',
                      wordBreak: 'break-word',
                      maxWidth: '100%',
                    }}
                  >
                    {m.content}
                  </div>
                </div>
              </div>
            ))}
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
