import { useEffect, useRef } from 'react'
import { Alert, Avatar, Button, Empty, Image, Skeleton, Tag, Typography } from 'antd'
import { UserOutlined } from '@ant-design/icons'
import { formatDateTime } from '@/lib/format'
import { errorMessage } from '@/lib/apiError'
import { reactionLabel } from '@/pages/rooms/utils'
import type { AdminConversationMessage } from '@/types'
import { useConversationMessages } from './useConversationQueries'
import { callLabel, messageMeta } from './utils'

interface ConversationMessagesProps {
  conversationId: string
  around?: string
  viewerId?: string
  onShowLatest?: () => void
}

function MessageBody({ message }: { message: AdminConversationMessage }) {
  const meta = messageMeta(message)
  switch (message.type) {
    case 'image':
      return (
        <>
          {meta.url && (
            <Image src={meta.url} alt="" style={{ maxWidth: 260, maxHeight: 260, borderRadius: 8, objectFit: 'cover' }} />
          )}
          {message.content && <div style={{ padding: '8px 4px 0' }}>{message.content}</div>}
        </>
      )
    case 'audio':
      return meta.url ? <audio controls src={meta.url} style={{ width: 260 }} /> : <span>🎤 Tin nhắn thoại</span>
    case 'video':
      return meta.url ? <video controls src={meta.url} style={{ maxWidth: 320, borderRadius: 8 }} /> : <span>🎬 Video</span>
    case 'file':
      return meta.url ? (
        <Typography.Link href={meta.url} target="_blank" rel="noreferrer">
          📎 {meta.fileName || 'Tệp đính kèm'}
        </Typography.Link>
      ) : (
        <span>📎 {meta.fileName || 'Tệp đính kèm'}</span>
      )
    case 'call':
      return <span>{callLabel(meta)}</span>
    default:
      return <>{message.content}</>
  }
}

export function ConversationMessages({ conversationId, around, viewerId, onShowLatest }: ConversationMessagesProps) {
  const { data, isLoading, error, fetchNextPage, hasNextPage, isFetchingNextPage } = useConversationMessages(
    conversationId,
    around,
  )
  const messages = data ? data.pages.flatMap((page) => page.messages).reverse() : []
  const hasNewer = data?.pages[0]?.hasNewer ?? false
  const anchorRef = useRef<HTMLDivElement>(null)
  const bottomRef = useRef<HTMLDivElement>(null)
  const firstPageLoaded = data != null

  useEffect(() => {
    if (!firstPageLoaded) return
    const frame = requestAnimationFrame(() =>
      (anchorRef.current ?? bottomRef.current)?.scrollIntoView({ block: anchorRef.current ? 'center' : 'end' }),
    )
    return () => cancelAnimationFrame(frame)
  }, [firstPageLoaded, conversationId, around])

  if (isLoading) return <Skeleton active avatar paragraph={{ rows: 8 }} />
  if (error) return <Alert type="error" showIcon message={errorMessage(error, 'Không tải được tin nhắn')} />
  if (messages.length === 0) {
    return (
      <div style={{ paddingTop: 80 }}>
        <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chưa có tin nhắn" />
      </div>
    )
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 14 }}>
      {hasNextPage && (
        <Button size="small" style={{ alignSelf: 'center' }} loading={isFetchingNextPage} onClick={() => void fetchNextPage()}>
          Tải tin cũ hơn
        </Button>
      )}
      {messages.map((m) => {
        const mine = viewerId != null && m.sender.id === viewerId
        const highlighted = m.id === around
        const reactions = m.reactions ? Object.entries(m.reactions).filter(([, list]) => list.length > 0) : []
        return (
          <div
            key={m.id}
            ref={highlighted ? anchorRef : undefined}
            style={{ display: 'flex', gap: 10, alignItems: 'flex-start', flexDirection: mine ? 'row-reverse' : 'row' }}
          >
            <Avatar src={m.sender.avatar || undefined} icon={<UserOutlined />} size={36} />
            <div style={{ minWidth: 0, maxWidth: '75%', textAlign: mine ? 'right' : 'left' }}>
              <div style={{ marginBottom: 4, fontSize: 12, color: '#9aa4b0' }}>
                <span style={{ fontWeight: 600, color: '#344054' }}>{m.sender.fullName || m.sender.username}</span>
                {' · '}
                {formatDateTime(m.createdAt)}
                {m.editedAt && ' · đã sửa'}
              </div>
              {m.replyTo != null && (
                <div style={{ borderLeft: '3px solid #d0d5dd', paddingLeft: 8, marginBottom: 4, color: '#667085', fontSize: 12, textAlign: 'left' }}>
                  <span style={{ fontWeight: 600 }}>{m.replyTo.senderName || 'Tin nhắn'}</span>
                  {': '}
                  {m.replyTo.type === 'image' && !m.replyTo.excerpt ? '[Hình ảnh]' : m.replyTo.excerpt}
                </div>
              )}
              <div
                style={{
                  display: 'inline-block',
                  textAlign: 'left',
                  background: highlighted ? '#fff7e6' : mine ? '#e8f1ff' : '#fff',
                  border: `1px solid ${highlighted ? '#ffa940' : '#e6e9ef'}`,
                  borderRadius: 14,
                  padding: m.type === 'image' ? 6 : '8px 12px',
                  fontSize: 14,
                  lineHeight: 1.5,
                  whiteSpace: 'pre-wrap',
                  wordBreak: 'break-word',
                  opacity: m.deletedAt ? 0.6 : 1,
                }}
              >
                <MessageBody message={m} />
              </div>
              {(m.deletedAt || highlighted || reactions.length > 0) && (
                <div style={{ marginTop: 4, display: 'flex', flexWrap: 'wrap', gap: 4, justifyContent: mine ? 'flex-end' : 'flex-start' }}>
                  {highlighted && <Tag color="orange" style={{ margin: 0 }}>Tin bị báo cáo</Tag>}
                  {m.deletedAt && (
                    <Tag color="red" style={{ margin: 0 }}>
                      Đã xoá {formatDateTime(m.deletedAt)}
                    </Tag>
                  )}
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
      {hasNewer && onShowLatest && (
        <Button size="small" style={{ alignSelf: 'center' }} onClick={onShowLatest}>
          Còn tin mới hơn — xem tin mới nhất
        </Button>
      )}
      <div ref={bottomRef} />
    </div>
  )
}
