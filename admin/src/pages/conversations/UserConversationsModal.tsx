import { useState } from 'react'
import { Alert, Avatar, Button, Empty, Modal, Segmented, Skeleton, Tag, Typography } from 'antd'
import { ReloadOutlined, TeamOutlined, UserOutlined } from '@ant-design/icons'
import { formatDateTime } from '@/lib/format'
import { ApiError, errorMessage } from '@/lib/apiError'
import { ConversationMessages } from './ConversationMessages'
import { useUserConversations } from './useConversationQueries'
import { conversationTitle } from './utils'

interface UserConversationsModalProps {
  userId: string | null
  username?: string
  open: boolean
  onClose: () => void
}

export function UserConversationsModal({ userId, username, open, onClose }: UserConversationsModalProps) {
  const [hidden, setHidden] = useState(false)
  const {
    data,
    isLoading,
    error,
    fetchNextPage,
    hasNextPage,
    isFetchingNextPage,
    isFetchNextPageError,
    refetch,
    isRefetching,
  } = useUserConversations(open ? userId : null, hidden)
  const [selectedId, setSelectedId] = useState<string | null>(null)
  const conversations = data ? data.pages.flatMap((page) => page.items) : []
  const total = data?.pages[0]?.total ?? 0
  const activeId = selectedId ?? conversations[0]?.id ?? null

  return (
    <Modal
      title={username ? `Hội thoại của @${username}` : 'Hội thoại'}
      open={open}
      onCancel={onClose}
      afterClose={() => {
        setSelectedId(null)
        setHidden(false)
      }}
      centered
      width={1100}
      footer={null}
      styles={{ body: { height: '76vh', display: 'flex', gap: 16, padding: 0 } }}
      destroyOnHidden
    >
      <div style={{ width: 320, flexShrink: 0, overflowY: 'auto', borderRight: '1px solid #e6e9ef', paddingRight: 8 }}>
        <Segmented
          block
          value={hidden ? 'hidden' : 'visible'}
          onChange={(value) => {
            setHidden(value === 'hidden')
            setSelectedId(null)
          }}
          options={[
            { label: 'Đang hiển thị', value: 'visible' },
            { label: 'Đã ẩn', value: 'hidden' },
          ]}
          style={{ marginBottom: 8 }}
        />
        {isLoading ? (
          <Skeleton active avatar paragraph={{ rows: 6 }} />
        ) : error && !data ? (
          <Alert type="error" showIcon message={errorMessage(error, 'Không tải được danh sách hội thoại')} />
        ) : conversations.length === 0 ? (
          <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description={hidden ? 'Không có hội thoại đã ẩn' : 'Chưa có hội thoại'} style={{ marginTop: 80 }} />
        ) : (
          <>
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', margin: '0 0 8px 8px' }}>
              <Typography.Text type="secondary" style={{ fontSize: 12 }}>
                {conversations.length < total ? `${conversations.length} / ${total} hội thoại` : `${total} hội thoại`}
              </Typography.Text>
              <Button size="small" type="text" icon={<ReloadOutlined />} loading={isRefetching} onClick={() => void refetch()}>
                Làm mới
              </Button>
            </div>
            {conversations.map((item) => {
              const active = item.id === activeId
              return (
                <div
                  key={item.id}
                  onClick={() => setSelectedId(item.id)}
                  style={{
                    display: 'flex',
                    gap: 10,
                    padding: '10px 8px',
                    borderRadius: 10,
                    cursor: 'pointer',
                    background: active ? '#e8f1ff' : undefined,
                  }}
                >
                  <Avatar
                    src={(item.otherUser?.avatar ?? item.avatar) || undefined}
                    icon={item.type === 'group' ? <TeamOutlined /> : <UserOutlined />}
                  />
                  <div style={{ minWidth: 0, flex: 1 }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: 6 }}>
                      <Typography.Text strong ellipsis style={{ flex: 1 }}>
                        {conversationTitle(item)}
                      </Typography.Text>
                      {item.type === 'group' && <Tag style={{ margin: 0 }}>Nhóm</Tag>}
                      {item.missing && <Tag color="red" style={{ margin: 0 }}>Không còn dữ liệu</Tag>}
                    </div>
                    <Typography.Text type="secondary" ellipsis style={{ display: 'block', fontSize: 12 }}>
                      {item.lastMessagePreview || '—'}
                    </Typography.Text>
                    {(item.lastMessageAt || item.hiddenAt) && (
                      <Typography.Text type="secondary" style={{ fontSize: 11 }}>
                        {item.lastMessageAt && formatDateTime(item.lastMessageAt)}
                        {item.lastMessageAt && item.hiddenAt && ' · '}
                        {item.hiddenAt && `ẩn lúc ${formatDateTime(item.hiddenAt)}`}
                      </Typography.Text>
                    )}
                  </div>
                </div>
              )
            })}
            {isFetchNextPageError ? (
              <Alert
                type="warning"
                showIcon
                style={{ marginTop: 8 }}
                message={
                  error instanceof ApiError && error.status === 410
                    ? 'Danh sách đã hết hạn, cần tải lại từ đầu'
                    : errorMessage(error, 'Không tải thêm được')
                }
                action={
                  <Button size="small" onClick={() => void refetch()}>
                    Tải lại
                  </Button>
                }
              />
            ) : (
              hasNextPage && (
                <Button block size="small" loading={isFetchingNextPage} onClick={() => void fetchNextPage()} style={{ marginTop: 8 }}>
                  Tải thêm
                </Button>
              )
            )}
          </>
        )}
      </div>
      <div style={{ flex: 1, minWidth: 0, overflowY: 'auto', background: '#f5f7fa', padding: 16, borderRadius: 8 }}>
        {activeId ? (
          <ConversationMessages key={activeId} conversationId={activeId} viewerId={userId ?? undefined} />
        ) : (
          !isLoading && <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description="Chọn một hội thoại" style={{ marginTop: 80 }} />
        )}
      </div>
    </Modal>
  )
}
