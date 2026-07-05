import { useState } from 'react'
import { Button, Empty, Modal, Skeleton, Tag, Tooltip } from 'antd'
import { CrownFilled, GiftOutlined, LockFilled } from '@ant-design/icons'
import { useUserVips } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import { GrantVipModal } from './GrantVipModal'
import type { AdminUserVipIcon } from '@/types'

interface UserVipIconsModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

const SOURCE_LABEL: Record<string, string> = {
  purchase: 'Mua',
  icon: 'Mua',
  transfer: 'Nhận chuyển',
  gift: 'Tặng',
  admin: 'Admin',
}

function sourceLabel(source?: string): string {
  if (!source) return ''
  return SOURCE_LABEL[source] ?? source
}

function VipCard({ item }: { item: AdminUserVipIcon }) {
  return (
    <div
      style={{
        position: 'relative',
        border: `1px solid ${item.isUsing ? '#faad14' : '#eef1f4'}`,
        borderRadius: 12,
        padding: 12,
        textAlign: 'center',
        background: item.isUsing ? '#fffbe6' : '#fff',
      }}
    >
      {item.isUsing && (
        <Tooltip title="Đang sử dụng">
          <CrownFilled
            style={{ position: 'absolute', top: 8, left: 8, color: '#faad14', fontSize: 16 }}
          />
        </Tooltip>
      )}
      {item.isLocked && (
        <Tooltip title="Đã khoá">
          <LockFilled
            style={{ position: 'absolute', top: 8, right: 8, color: '#8c98a4', fontSize: 14 }}
          />
        </Tooltip>
      )}
      <img
        src={vipIconUrl(item.typeId)}
        alt={vipName(item.typeId)}
        width={56}
        height={56}
        style={{ objectFit: 'contain' }}
        onError={(e) => {
          e.currentTarget.style.visibility = 'hidden'
        }}
      />
      <div style={{ fontSize: 13, fontWeight: 600, marginTop: 6, lineHeight: 1.3 }}>
        {vipName(item.typeId)}
      </div>
      <div style={{ fontSize: 11, color: '#8c98a4', marginTop: 2 }}>#{item.typeId}</div>
      <div style={{ marginTop: 8, display: 'flex', gap: 4, justifyContent: 'center', flexWrap: 'wrap' }}>
        {item.source && <Tag style={{ margin: 0 }}>{sourceLabel(item.source)}</Tag>}
      </div>
      {item.acquiredAt && (
        <div style={{ fontSize: 11, color: '#b0b8c1', marginTop: 6 }}>
          {formatDateTime(item.acquiredAt)}
        </div>
      )}
    </div>
  )
}

export function UserVipIconsModal({ open, userId, username, onClose }: UserVipIconsModalProps) {
  const { data, isLoading } = useUserVips(open ? userId : null)
  const items = data?.items ?? []
  const [grantOpen, setGrantOpen] = useState(false)

  return (
    <Modal
      title={
        <div
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            gap: 12,
            paddingRight: 32,
          }}
        >
          <span>{`VIP đang có${username ? ` — @${username}` : ''}${data ? ` (${data.total})` : ''}`}</span>
          <Button
            size="small"
            type="primary"
            icon={<GiftOutlined />}
            onClick={() => setGrantOpen(true)}
          >
            Tặng VIP
          </Button>
        </div>
      }
      open={open}
      onCancel={onClose}
      footer={null}
      width={720}
      centered
      styles={{ body: { maxHeight: '70vh', overflowY: 'auto' } }}
      destroyOnHidden
    >
      {isLoading ? (
        <Skeleton active paragraph={{ rows: 6 }} />
      ) : items.length === 0 ? (
        <Empty description="Người dùng chưa sở hữu VIP nào" />
      ) : (
        <div
          style={{
            display: 'grid',
            gridTemplateColumns: 'repeat(auto-fill, minmax(140px, 1fr))',
            gap: 12,
          }}
        >
          {items.map((item) => (
            <VipCard key={item.instanceId} item={item} />
          ))}
        </div>
      )}
      <GrantVipModal
        open={grantOpen}
        userId={userId}
        username={username}
        onClose={() => setGrantOpen(false)}
      />
    </Modal>
  )
}
