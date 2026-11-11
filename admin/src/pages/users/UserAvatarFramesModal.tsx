import { useMemo, useState } from 'react'
import { Alert, Button, Empty, Modal, Segmented, Skeleton, Tag, Tooltip } from 'antd'
import { CrownFilled, GiftOutlined } from '@ant-design/icons'
import { avatarFrameById, avatarFrameLabel } from '@ola/shared/lib/avatarFrame'
import { useUserAvatarFrames } from '@/hooks/useUserQueries'
import { formatDateTime } from '@/lib/format'
import type { AdminUserAvatarFrame } from '@/types'
import { GrantAvatarFrameModal } from './GrantAvatarFrameModal'
import { UserFramePurchaseHistory, UserFrameTransferHistory } from './UserAvatarFrameHistory'
import { USER_AVATAR_FRAME_SOURCE_LABEL, USER_FRAMES_TAB_OPTIONS } from './constants'
import type { UserFramesTab } from './types'

interface UserAvatarFramesModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

function FrameCard({ item }: { item: AdminUserAvatarFrame }) {
  const frame = avatarFrameById(item.frameId)
  return (
    <div
      style={{
        position: 'relative',
        border: `1px solid ${item.isEquipped ? '#faad14' : '#eef1f4'}`,
        borderRadius: 12,
        padding: 12,
        textAlign: 'center',
        background: item.isEquipped ? '#fffbe6' : '#fff',
      }}
    >
      {item.isEquipped && (
        <Tooltip title="Đang đeo">
          <CrownFilled style={{ position: 'absolute', top: 8, left: 8, color: '#faad14', fontSize: 16 }} />
        </Tooltip>
      )}
      {frame ? (
        <img src={frame.url} alt={avatarFrameLabel(item.frameId)} width={64} height={64} style={{ objectFit: 'contain' }} />
      ) : (
        <div style={{ height: 64 }} />
      )}
      <div style={{ fontSize: 13, fontWeight: 600, marginTop: 6, lineHeight: 1.3 }}>{avatarFrameLabel(item.frameId)}</div>
      <div style={{ fontSize: 11, color: '#8c98a4', marginTop: 2 }}>#{item.frameId}</div>
      <div style={{ marginTop: 8 }}>
        <Tag style={{ margin: 0 }}>{USER_AVATAR_FRAME_SOURCE_LABEL[item.source] ?? item.source}</Tag>
      </div>
      <div style={{ fontSize: 11, color: '#b0b8c1', marginTop: 6 }}>{formatDateTime(item.acquiredAt)}</div>
    </div>
  )
}

export function UserAvatarFramesModal({ open, userId, username, onClose }: UserAvatarFramesModalProps) {
  const { data, isLoading } = useUserAvatarFrames(open ? userId : null)
  const items = useMemo(() => data?.items ?? [], [data])
  const ownedFrameIds = useMemo(() => new Set(items.map((item) => item.frameId)), [items])
  const [grantOpen, setGrantOpen] = useState(false)
  const [tab, setTab] = useState<UserFramesTab>('owned')
  const hiddenCount = data ? data.total - items.length : 0

  const handleClose = () => {
    setTab('owned')
    onClose()
  }

  return (
    <Modal
      title={
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 12, paddingRight: 32 }}>
          <span>{`Khung avatar${username ? ` — @${username}` : ''}${data ? ` (${data.total})` : ''}`}</span>
          <Button size="small" type="primary" icon={<GiftOutlined />} disabled={!data} onClick={() => setGrantOpen(true)}>
            Tặng khung
          </Button>
        </div>
      }
      open={open}
      onCancel={handleClose}
      footer={null}
      width={760}
      centered
      styles={{ body: { maxHeight: '70vh', overflowY: 'auto' } }}
      destroyOnHidden
    >
      <Segmented<UserFramesTab>
        block
        options={USER_FRAMES_TAB_OPTIONS}
        value={tab}
        onChange={setTab}
        style={{ marginBottom: 12 }}
      />
      {tab === 'owned' && (
        <>
          {data && !data.vipActive && items.length > 0 && (
            <Alert type="info" showIcon style={{ marginBottom: 12 }} title="User đang hết VIP nên khung chưa hiện cho người khác." />
          )}
          {isLoading ? (
            <Skeleton active paragraph={{ rows: 6 }} />
          ) : items.length === 0 ? (
            <Empty description="Người dùng chưa có khung nào" />
          ) : (
            <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fill, minmax(140px, 1fr))', gap: 12 }}>
              {items.map((item) => (
                <FrameCard key={item.frameId} item={item} />
              ))}
            </div>
          )}
          {hiddenCount > 0 && (
            <div style={{ marginTop: 12, fontSize: 12, color: '#8c98a4' }}>Còn {hiddenCount} khung khác chưa hiện.</div>
          )}
        </>
      )}
      {tab === 'purchases' && userId && <UserFramePurchaseHistory userId={userId} />}
      {tab === 'transfers' && userId && <UserFrameTransferHistory userId={userId} />}
      <GrantAvatarFrameModal
        open={grantOpen}
        userId={userId}
        username={username}
        ownedFrameIds={ownedFrameIds}
        vipActive={data?.vipActive ?? false}
        onClose={() => setGrantOpen(false)}
      />
    </Modal>
  )
}
