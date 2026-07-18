import { useState, type ReactNode } from 'react'
import { Avatar, Button, Modal, Skeleton, Tag, Typography } from 'antd'
import {
  CrownOutlined,
  EditOutlined,
  FileTextOutlined,
  HistoryOutlined,
  LockOutlined,
  PlusOutlined,
  UserOutlined,
  WalletOutlined,
} from '@ant-design/icons'
import { useUserDetail } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import { GENDER } from './userMeta'
import { KenAdjustModal } from './KenAdjustModal'
import { KenHistoryModal } from './KenHistoryModal'
import { UserMeModal } from './UserMeModal'
import { UserVipIconsModal } from './UserVipIconsModal'
import { UserVipHistoryModal } from './UserVipHistoryModal'
import { UserSessionsModal } from './UserSessionsModal'
import { EditUsernameModal } from './EditUsernameModal'
import { ResetPasswordModal } from './ResetPasswordModal'
import { AddVipDaysModal } from './AddVipDaysModal'

interface UserDetailModalProps {
  userId: string | null
  open: boolean
  onClose: () => void
}

const labelStyle: React.CSSProperties = {
  fontSize: 11,
  fontWeight: 600,
  color: '#8c98a4',
  textTransform: 'uppercase',
  letterSpacing: 0.4,
  marginBottom: 4,
}

function Section({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div style={{ marginTop: 14 }}>
      <div style={labelStyle}>{title}</div>
      {children}
    </div>
  )
}

function StatBox({ label, value }: { label: string; value: number }) {
  return (
    <div
      style={{
        flex: 1,
        textAlign: 'center',
        padding: '8px 8px',
        background: '#f6f8fa',
        borderRadius: 10,
      }}
    >
      <div style={{ fontSize: 18, fontWeight: 700 }}>{value.toLocaleString('vi-VN')}</div>
      <div style={{ fontSize: 12, color: '#6b7785' }}>{label}</div>
    </div>
  )
}

function Row({ label, value }: { label: string; value?: ReactNode }) {
  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', gap: 16, padding: '3px 0' }}>
      <span style={{ color: '#6b7785' }}>{label}</span>
      <span style={{ textAlign: 'right', wordBreak: 'break-word' }}>{value || '—'}</span>
    </div>
  )
}

function vipDaysLeft(vipEndTime?: string): number | null {
  if (!vipEndTime) return null
  const end = new Date(vipEndTime).getTime()
  if (Number.isNaN(end)) return null
  const diff = end - Date.now()
  return diff <= 0 ? 0 : Math.ceil(diff / 86_400_000)
}

export function UserDetailModal({ userId, open, onClose }: UserDetailModalProps) {
  const { data, isLoading } = useUserDetail(open ? userId : null)
  const gender = data?.gender ? GENDER[data.gender] ?? { label: data.gender, color: 'default' } : null
  const [adjustOpen, setAdjustOpen] = useState(false)
  const [historyOpen, setHistoryOpen] = useState(false)
  const [sessionsOpen, setSessionsOpen] = useState(false)
  const [meOpen, setMeOpen] = useState(false)
  const [vipsOpen, setVipsOpen] = useState(false)
  const [vipHistoryOpen, setVipHistoryOpen] = useState(false)
  const [usernameOpen, setUsernameOpen] = useState(false)
  const [passwordOpen, setPasswordOpen] = useState(false)
  const [vipDaysOpen, setVipDaysOpen] = useState(false)

  return (
    <>
    <Modal
      title="Chi tiết người dùng"
      open={open}
      onCancel={onClose}
      centered
      width={560}
      styles={{ body: { maxHeight: '72vh', overflowY: 'auto', paddingRight: 8 } }}
      footer={
        <div style={{ display: 'flex', flexWrap: 'wrap', justifyContent: 'flex-end', gap: 8 }}>
          <Button icon={<FileTextOutlined />} disabled={!userId} onClick={() => setMeOpen(true)}>
            Bài đăng (Me)
          </Button>
          <Button icon={<CrownOutlined />} disabled={!userId} onClick={() => setVipsOpen(true)}>
            VIP đang có
          </Button>
          <Button icon={<CrownOutlined />} disabled={!userId} onClick={() => setVipHistoryOpen(true)}>
            Lịch sử VIP
          </Button>
          <Button icon={<HistoryOutlined />} disabled={!userId} onClick={() => setHistoryOpen(true)}>
            Lịch sử Ken
          </Button>
          <Button icon={<HistoryOutlined />} disabled={!userId} onClick={() => setSessionsOpen(true)}>
            Lịch sử đăng nhập
          </Button>
          <Button icon={<LockOutlined />} disabled={!userId} onClick={() => setPasswordOpen(true)}>
            Đổi mật khẩu
          </Button>
          <Button
            type="primary"
            ghost
            icon={<WalletOutlined />}
            disabled={!userId}
            onClick={() => setAdjustOpen(true)}
          >
            Tặng / Trừ Ken
          </Button>
          <Button onClick={onClose}>Đóng</Button>
        </div>
      }
    >
      {isLoading || !data ? (
        <Skeleton active avatar paragraph={{ rows: 6 }} />
      ) : (
        <>
          <div
            style={{
              display: 'flex',
              alignItems: 'center',
              gap: 14,
              padding: 16,
              background: '#fafbfc',
              border: '1px solid #eef1f4',
              borderRadius: 12,
            }}
          >
            <Avatar src={data.avatar} icon={<UserOutlined />} size={72} />
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 18, fontWeight: 600 }}>
                {data.fullName || data.username}
                {data.isVip && <CrownOutlined style={{ color: '#faad14', marginLeft: 8 }} />}
              </div>
              <div style={{ display: 'flex', alignItems: 'center', gap: 6, color: '#6b7785', marginBottom: 6 }}>
                <span>@{data.username}</span>
                <Button
                  type="text"
                  size="small"
                  icon={<EditOutlined />}
                  onClick={() => setUsernameOpen(true)}
                />
              </div>
              <div>
                {data.isActive ? (
                  <Tag color="green">Hoạt động</Tag>
                ) : (
                  <Tag color="red">Đã khoá</Tag>
                )}
                {gender && <Tag color={gender.color}>{gender.label}</Tag>}
                {data.isVip && <Tag color="gold">VIP</Tag>}
              </div>
            </div>
          </div>

          <Section title="Thống kê">
            <div style={{ display: 'flex', gap: 12 }}>
              <StatBox label="Follower" value={data.followerCount ?? 0} />
              <StatBox label="Following" value={data.followingCount ?? 0} />
              <StatBox label="Ken" value={data.ken ?? 0} />
            </div>
          </Section>

          <Section title="Liên hệ">
            <Row
              label="Email"
              value={
                data.email ? (
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 8 }}>
                    <span style={{ wordBreak: 'break-all' }}>{data.email}</span>
                    {data.emailVerified ? (
                      <Tag color="green" style={{ margin: 0 }}>Đã xác thực</Tag>
                    ) : (
                      <Tag style={{ margin: 0 }}>Chưa xác thực</Tag>
                    )}
                  </span>
                ) : undefined
              }
            />
            {data.emailVerified && (
              <Row label="Ngày xác thực email" value={formatDateTime(data.emailVerifiedAt)} />
            )}
            <Row label="Số điện thoại" value={data.phone} />
            <Row label="Ngày sinh" value={data.dateOfBirth} />
          </Section>

          {data.bio && (
            <Section title="Giới thiệu">
              <Typography.Paragraph style={{ marginBottom: 0, whiteSpace: 'pre-wrap' }}>
                {data.bio}
              </Typography.Paragraph>
            </Section>
          )}

          <Section title="VIP">
            {(() => {
              const days = vipDaysLeft(data.vipEndTime)
              return (
                <div style={{ display: 'flex', alignItems: 'center', gap: 8, padding: '3px 0' }}>
                  <span style={{ color: '#6b7785' }}>Còn hạn VIP</span>
                  {days && days > 0 ? (
                    <>
                      <Tag color="gold" style={{ margin: 0 }}>{`Còn ${days} ngày`}</Tag>
                      <span style={{ color: '#8c98a4', fontSize: 12 }}>
                        {formatDateTime(data.vipEndTime)}
                      </span>
                    </>
                  ) : (
                    <Tag style={{ margin: 0 }}>{data.vipEndTime ? 'Đã hết hạn' : 'Chưa có VIP'}</Tag>
                  )}
                  <Button
                    type="primary"
                    ghost
                    size="small"
                    icon={<PlusOutlined />}
                    disabled={!userId}
                    onClick={() => setVipDaysOpen(true)}
                    style={{ marginLeft: 'auto' }}
                  >
                    Cộng ngày
                  </Button>
                </div>
              )
            })()}
            <Row
              label="Icon đang dùng"
              value={
                data.vipUsed ? (
                  <span style={{ display: 'inline-flex', alignItems: 'center', gap: 8 }}>
                    <img
                      src={vipIconUrl(Number(data.vipUsed))}
                      alt={vipName(Number(data.vipUsed))}
                      width={24}
                      height={24}
                      style={{ objectFit: 'contain' }}
                      onError={(e) => {
                        e.currentTarget.style.visibility = 'hidden'
                      }}
                    />
                    <span>{vipName(Number(data.vipUsed))}</span>
                  </span>
                ) : (
                  'Không dùng icon'
                )
              }
            />
          </Section>

          <Section title="Hoạt động">
            <Row label="Đăng nhập cuối" value={formatDateTime(data.lastLoginAt)} />
            <Row
              label="IP đăng nhập cuối"
              value={
                data.lastLoginIp ? (
                  <Typography.Text copyable style={{ fontSize: 13 }}>
                    {data.lastLoginIp}
                  </Typography.Text>
                ) : undefined
              }
            />
            <Row label="Ngày tạo" value={formatDateTime(data.createdAt)} />
            <Row label="Cập nhật" value={formatDateTime(data.updatedAt)} />
            <Row
              label="ID"
              value={
                <Typography.Text copyable style={{ fontSize: 12 }}>
                  {data.id}
                </Typography.Text>
              }
            />
          </Section>
        </>
      )}
    </Modal>
    <KenAdjustModal
      open={adjustOpen}
      userId={userId}
      username={data?.username}
      currentKen={data?.ken}
      onClose={() => setAdjustOpen(false)}
    />
    <KenHistoryModal
      open={historyOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setHistoryOpen(false)}
    />
    <UserMeModal
      open={meOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setMeOpen(false)}
    />
    <UserVipIconsModal
      open={vipsOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setVipsOpen(false)}
    />
    <UserVipHistoryModal
      open={vipHistoryOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setVipHistoryOpen(false)}
    />
    <UserSessionsModal
      open={sessionsOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setSessionsOpen(false)}
    />
    <EditUsernameModal
      open={usernameOpen}
      userId={userId}
      currentUsername={data?.username}
      onClose={() => setUsernameOpen(false)}
    />
    <ResetPasswordModal
      open={passwordOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setPasswordOpen(false)}
    />
    <AddVipDaysModal
      open={vipDaysOpen}
      userId={userId}
      username={data?.username}
      onClose={() => setVipDaysOpen(false)}
    />
    </>
  )
}
