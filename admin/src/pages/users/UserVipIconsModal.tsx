import { useState } from 'react'
import { App, Button, Empty, Modal, Popconfirm, Skeleton, Tag, Tooltip } from 'antd'
import { CloseOutlined, CrownFilled, EditOutlined, GiftOutlined, LockFilled } from '@ant-design/icons'
import { useDeleteUserVip, useUpdateUserVip, useUserVips } from '@/hooks/useUserQueries'
import { formatDateTime } from '@/lib/format'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import { EditItemGrantModal } from './EditItemGrantModal'
import { GrantVipModal } from './GrantVipModal'
import { ItemGrantTags } from './ItemGrantTags'
import type { AdminUserVipIcon } from '@/types'
import { deleteWarning, vipIconSourceLabel } from './utils'

interface UserVipIconsModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

interface VipCardProps {
  item: AdminUserVipIcon
  onDelete: (item: AdminUserVipIcon) => void
  onEdit: (item: AdminUserVipIcon) => void
  deleting: boolean
}

function VipCard({ item, onDelete, onEdit, deleting }: VipCardProps) {
  return (
    <div
      style={{
        position: 'relative',
        opacity: item.expired ? 0.55 : 1,
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
      <Popconfirm
        title={`Xoá "${vipName(item.typeId)}" khỏi kho?`}
        description={deleteWarning(item)}
        okText="Xoá"
        okButtonProps={{ danger: true, loading: deleting }}
        cancelText="Huỷ"
        placement="topRight"
        onConfirm={() => onDelete(item)}
      >
        <Button
          type="text"
          size="small"
          danger
          icon={<CloseOutlined />}
          aria-label="Xoá VIP"
          style={{ position: 'absolute', top: 4, right: 4 }}
        />
      </Popconfirm>
      <Tooltip title="Sửa hạn / khoá">
        <Button
          type="text"
          size="small"
          icon={<EditOutlined />}
          aria-label="Sửa hạn và khoá"
          onClick={() => onEdit(item)}
          style={{ position: 'absolute', top: 4, right: 30 }}
        />
      </Tooltip>
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
        {item.source && <Tag style={{ margin: 0 }}>{vipIconSourceLabel(item.source)}</Tag>}
        {item.isLocked && (
          <Tag icon={<LockFilled />} style={{ margin: 0 }}>
            User tự khoá
          </Tag>
        )}
        <ItemGrantTags locked={item.locked} expiresAt={item.expiresAt} expired={item.expired} />
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
  const { message } = App.useApp()
  const { data, isLoading } = useUserVips(open ? userId : null)
  const items = data?.items ?? []
  const [grantOpen, setGrantOpen] = useState(false)
  const [deletingId, setDeletingId] = useState<string | null>(null)
  const deleteVip = useDeleteUserVip()
  const updateVip = useUpdateUserVip()
  const [editing, setEditing] = useState<AdminUserVipIcon | null>(null)

  async function handleDelete(item: AdminUserVipIcon) {
    if (userId == null) return
    setDeletingId(item.instanceId)
    try {
      await deleteVip.mutateAsync({ id: userId, instanceId: item.instanceId })
      message.success(`Đã xoá "${vipName(item.typeId)}"`)
    } catch {
      message.error('Xoá VIP thất bại')
    } finally {
      setDeletingId(null)
    }
  }

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
            <VipCard
              key={item.instanceId}
              item={item}
              onDelete={handleDelete}
              onEdit={setEditing}
              deleting={deletingId === item.instanceId}
            />
          ))}
        </div>
      )}
      <EditItemGrantModal
        open={editing != null}
        title={editing ? `Sửa "${vipName(editing.typeId)}"` : ''}
        locked={editing?.locked ?? false}
        expiresAt={editing?.expiresAt}
        submitting={updateVip.isPending}
        onSubmit={(payload) =>
          userId && editing
            ? updateVip.mutateAsync({ id: userId, instanceId: editing.instanceId, payload })
            : Promise.resolve()
        }
        onClose={() => setEditing(null)}
      />
      <GrantVipModal
        open={grantOpen}
        userId={userId}
        username={username}
        onClose={() => setGrantOpen(false)}
      />
    </Modal>
  )
}
