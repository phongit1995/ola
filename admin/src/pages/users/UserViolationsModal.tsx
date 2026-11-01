import { useState } from 'react'
import { App, Button, Modal, Popconfirm, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { ClearOutlined, UnlockOutlined } from '@ant-design/icons'
import {
  useClearUserViolations,
  useRevokeUserViolation,
  useUpdateUserStatus,
  useUserViolations,
} from '@/hooks/useUserQueries'
import { errorMessage } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import { lockStepsLabel, PENALTY_SEVERITY_TAG, REPORT_REASON_LABEL, REPORT_TARGET_LABEL } from '@/lib/moderation'
import type { UserViolation } from '@/types'
import { MODAL_PAGE_SIZE, VIOLATION_SOURCE_LABEL, VIOLATION_STATE_TAG } from './constants'
import type { UserLockFields } from './types'
import { adminName, clearViolationsWarning, unlockWarning, violationState } from './utils'

interface UserViolationsModalProps {
  open: boolean
  userId: string | null
  username?: string
  user?: UserLockFields
  onClose: () => void
}

export function UserViolationsModal({ open, userId, username, user, onClose }: UserViolationsModalProps) {
  const { message } = App.useApp()
  const [page, setPage] = useState(1)
  const [revokingId, setRevokingId] = useState<string | null>(null)
  const { data, isFetching } = useUserViolations(open ? userId : null)
  const revoke = useRevokeUserViolation()
  const clear = useClearUserViolations()
  const updateStatus = useUpdateUserStatus()
  const expireHours = data?.expireHours ?? 0
  const total = data?.total ?? 0
  const locked = user != null && !user.isActive

  async function clearAll() {
    if (!userId) return
    try {
      await clear.mutateAsync(userId)
      message.success('Đã xoá sạch điểm vi phạm')
    } catch (err) {
      message.error(errorMessage(err, 'Xoá điểm vi phạm thất bại'))
    }
  }

  async function unlock() {
    if (!userId) return
    try {
      await updateStatus.mutateAsync({ id: userId, isActive: true })
      message.success('Đã mở khoá tài khoản')
    } catch (err) {
      message.error(errorMessage(err, 'Mở khoá thất bại'))
    }
  }

  async function revokeItem(item: UserViolation) {
    if (!userId) return
    setRevokingId(item.id)
    try {
      await revoke.mutateAsync({ id: userId, violationId: item.id })
      message.success('Đã gỡ vi phạm, điểm này không còn được tính')
    } catch (err) {
      message.error(errorMessage(err, 'Gỡ vi phạm thất bại'))
    } finally {
      setRevokingId(null)
    }
  }

  const columns: TableColumnsType<UserViolation> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Nguồn',
      dataIndex: 'source',
      width: 120,
      render: (_, item) => <Tag>{VIOLATION_SOURCE_LABEL[item.source] ?? item.source}</Tag>,
    },
    {
      title: 'Nội dung',
      dataIndex: 'targetType',
      width: 140,
      render: (_, item) => REPORT_TARGET_LABEL[item.targetType] ?? item.targetType,
    },
    {
      title: 'Lý do',
      dataIndex: 'reason',
      width: 150,
      render: (_, item) => REPORT_REASON_LABEL[item.reason] ?? item.reason,
    },
    {
      title: 'Mức xử lý',
      dataIndex: 'severity',
      width: 140,
      render: (_, item) => {
        const meta = PENALTY_SEVERITY_TAG[item.severity] ?? { label: item.severity, color: 'default' }
        return <Tag color={meta.color}>{meta.label}</Tag>
      },
    },
    {
      title: 'Điểm',
      dataIndex: 'points',
      width: 70,
      align: 'center',
      render: (_, item) => {
        const counting = violationState(item, expireHours) === 'active'
        return (
          <Typography.Text
            strong={counting}
            delete={!counting && item.points > 0}
            type={counting ? undefined : 'secondary'}
          >
            {item.points > 0 ? `+${item.points}` : '0'}
          </Typography.Text>
        )
      },
    },
    {
      title: 'Admin',
      key: 'admin',
      width: 140,
      render: (_, item) => adminName(item.admin),
    },
    {
      title: 'Ghi chú',
      dataIndex: 'note',
      width: 200,
      render: (_, item) =>
        item.note ? (
          <Typography.Paragraph ellipsis={{ rows: 2, tooltip: item.note }} style={{ marginBottom: 0 }}>
            {item.note}
          </Typography.Paragraph>
        ) : (
          '—'
        ),
    },
    {
      title: 'Trạng thái',
      key: 'state',
      width: 190,
      render: (_, item) => {
        const meta = VIOLATION_STATE_TAG[violationState(item, expireHours)]
        return (
          <div style={{ lineHeight: 1.3 }}>
            <Tag color={meta.color}>{meta.label}</Tag>
            {item.revokedAt && (
              <div style={{ fontSize: 12, color: '#6b7785', marginTop: 2 }}>
                {adminName(item.revokedBy)} · {formatDateTime(item.revokedAt)}
              </div>
            )}
          </div>
        )
      },
    },
    {
      title: '',
      key: 'actions',
      width: 80,
      fixed: 'right',
      render: (_, item) =>
        item.points === 0 || violationState(item, expireHours) !== 'active' ? null : (
          <Popconfirm
            title="Gỡ vi phạm này?"
            description={
              <div style={{ maxWidth: 300 }}>
                Điểm của vi phạm này sẽ không còn được tính. Gỡ vi phạm KHÔNG mở khoá tài khoản, muốn mở
                khoá thì bấm Mở khoá tài khoản ở phía trên.
              </div>
            }
            okText="Gỡ"
            okButtonProps={{ danger: true }}
            cancelText="Huỷ"
            onConfirm={() => revokeItem(item)}
          >
            <Button
              size="small"
              danger
              loading={revokingId === item.id}
              disabled={revokingId != null && revokingId !== item.id}
            >
              Gỡ
            </Button>
          </Popconfirm>
        ),
    },
  ]

  return (
    <Modal
      title={`Vi phạm${username ? ` — @${username}` : ''}`}
      open={open}
      onCancel={onClose}
      footer={null}
      width={1200}
      style={{ maxWidth: '95vw', top: 32 }}
      styles={{ body: { maxHeight: '72vh', overflowY: 'auto' } }}
      destroyOnHidden
    >
      {data && (
        <div
          style={{
            display: 'flex',
            flexWrap: 'wrap',
            alignItems: 'flex-start',
            justifyContent: 'space-between',
            gap: 12,
            marginBottom: 12,
          }}
        >
          <div>
            <Typography.Text strong>
              Đang có {data.total}/{data.threshold} điểm
            </Typography.Text>
            {data.expireHours > 0 && (
              <Typography.Text type="secondary"> (tính trong {data.expireHours} giờ gần nhất)</Typography.Text>
            )}
            {data.lockSteps.length > 0 && (
              <Typography.Text type="secondary" style={{ display: 'block' }}>
                Mốc khoá: {lockStepsLabel(data.lockSteps)}
              </Typography.Text>
            )}
          </div>
          <Space wrap>
            {locked && (
              <Popconfirm
                title="Mở khoá tài khoản?"
                description={<div style={{ maxWidth: 320 }}>{unlockWarning(total, data.lockSteps)}</div>}
                okText="Mở khoá"
                cancelText="Huỷ"
                onConfirm={unlock}
              >
                <Button icon={<UnlockOutlined />} loading={updateStatus.isPending}>
                  Mở khoá tài khoản
                </Button>
              </Popconfirm>
            )}
            <Popconfirm
              title="Xoá sạch điểm vi phạm?"
              description={<div style={{ maxWidth: 320 }}>{clearViolationsWarning(total, locked)}</div>}
              okText="Xoá sạch"
              okButtonProps={{ danger: true }}
              cancelText="Huỷ"
              onConfirm={clearAll}
              disabled={total === 0}
            >
              <Button danger icon={<ClearOutlined />} loading={clear.isPending} disabled={total === 0}>
                Xoá sạch điểm
              </Button>
            </Popconfirm>
          </Space>
        </div>
      )}
      <Table<UserViolation>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 'max-content' }}
        pagination={{
          current: page,
          pageSize: MODAL_PAGE_SIZE,
          total: data?.items.length ?? 0,
          showTotal: (total) => `${total} vi phạm`,
          onChange: setPage,
        }}
      />
    </Modal>
  )
}
