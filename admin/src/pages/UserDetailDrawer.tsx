import type { ReactNode } from 'react'
import { Avatar, Drawer, Skeleton, Tag, Typography } from 'antd'
import { CrownOutlined, UserOutlined } from '@ant-design/icons'
import { useUserDetail } from '@/hooks/useUsers'
import { formatDateTime } from '@/lib/format'
import { GENDER } from './userMeta'

interface UserDetailDrawerProps {
  userId: string | null
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

function StatBox({ label, value }: { label: string; value: number }) {
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
      <div style={{ fontSize: 20, fontWeight: 700 }}>{value}</div>
      <div style={{ fontSize: 12, color: '#6b7785' }}>{label}</div>
    </div>
  )
}

function Row({ label, value }: { label: string; value?: ReactNode }) {
  return (
    <div style={{ display: 'flex', justifyContent: 'space-between', gap: 16, padding: '6px 0' }}>
      <span style={{ color: '#6b7785' }}>{label}</span>
      <span style={{ textAlign: 'right', wordBreak: 'break-word' }}>{value || '—'}</span>
    </div>
  )
}

export function UserDetailDrawer({ userId, open, onClose }: UserDetailDrawerProps) {
  const { data, isLoading } = useUserDetail(open ? userId : null)
  const gender = data?.gender ? GENDER[data.gender] ?? { label: data.gender, color: 'default' } : null

  return (
    <Drawer title="Chi tiết người dùng" open={open} onClose={onClose} width={460}>
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
            <Avatar src={data.avatar} icon={<UserOutlined />} size={64} />
            <div style={{ minWidth: 0 }}>
              <div style={{ fontSize: 18, fontWeight: 600 }}>
                {data.fullName || data.username}
                {data.isVip && <CrownOutlined style={{ color: '#faad14', marginLeft: 8 }} />}
              </div>
              <div style={{ color: '#6b7785', marginBottom: 6 }}>@{data.username}</div>
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
            <Row label="Email" value={data.email} />
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

          {data.isVip && (
            <Section title="VIP">
              <Row label="Gói" value={data.vipUsed} />
              <Row label="Hết hạn" value={formatDateTime(data.vipEndTime)} />
            </Section>
          )}

          <Section title="Hoạt động">
            <Row label="Đăng nhập cuối" value={formatDateTime(data.lastLoginAt)} />
            <Row label="IP đăng nhập cuối" value={data.lastLoginIp} />
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
    </Drawer>
  )
}
