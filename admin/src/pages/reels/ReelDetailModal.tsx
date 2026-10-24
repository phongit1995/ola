import { useState } from 'react'
import {
  Avatar,
  Button,
  Descriptions,
  Divider,
  Empty,
  Modal,
  Skeleton,
  Space,
  Switch,
  Table,
  Tag,
  Tooltip,
  Typography,
  type TableColumnsType,
} from 'antd'
import { UserOutlined } from '@ant-design/icons'
import { UserBriefCell } from '@/components/UserBriefCell'
import { errorMessage, toApiError } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import type { AdminReel, AdminReelViewer } from '@/types'
import { ReelPreview } from './ReelPreview'
import { useReelDetail, useReelViewers, useToggleReelStatus } from './useReelQueries'
import { canToggleReel, videoSummary } from './utils'
import {
  HTTP_NOT_FOUND,
  REEL_DETAIL_PREVIEW_WIDTH,
  REEL_STATE_TAG,
  REEL_TOGGLE_LOCKED_HINT,
  REEL_TYPE_TAG,
  REEL_VIEWER_PAGE_SIZE,
  REEL_VISIBILITY_TAG,
} from './constants'

interface ReelDetailModalProps {
  reelId: string | null
  onClose: () => void
}

const VIEWER_COLUMNS: TableColumnsType<AdminReelViewer> = [
  { key: 'user', render: (_, viewer) => <UserBriefCell user={viewer.user} /> },
  {
    key: 'viewedAt',
    align: 'right',
    render: (_, viewer) => <Typography.Text type="secondary">{formatDateTime(viewer.viewedAt)}</Typography.Text>,
  },
]

function ReelViewers({ reel }: { reel: AdminReel }) {
  const [page, setPage] = useState(1)
  const live = reel.viewerCount != null
  const { data, isFetching } = useReelViewers(live ? reel.id : null, {
    limit: REEL_VIEWER_PAGE_SIZE,
    offset: (page - 1) * REEL_VIEWER_PAGE_SIZE,
  })

  if (!live) {
    return (
      <Empty
        image={Empty.PRESENTED_IMAGE_SIMPLE}
        description="Danh sách người xem chỉ có khi reel còn hạn và chưa bị xoá"
      />
    )
  }
  return (
    <Table<AdminReelViewer>
      size="small"
      rowKey={(viewer) => viewer.user.id}
      loading={isFetching}
      dataSource={data?.items ?? []}
      locale={{ emptyText: 'Chưa có ai xem' }}
      showHeader={false}
      columns={VIEWER_COLUMNS}
      pagination={
        (data?.total ?? 0) > REEL_VIEWER_PAGE_SIZE
          ? {
              current: page,
              pageSize: REEL_VIEWER_PAGE_SIZE,
              total: data?.total ?? 0,
              onChange: setPage,
              size: 'small',
            }
          : false
      }
    />
  )
}

function ReelInfo({ reel }: { reel: AdminReel }) {
  const status = useToggleReelStatus()
  const typeTag = REEL_TYPE_TAG[reel.type]
  const stateTag = REEL_STATE_TAG[reel.state]
  const visibilityTag = REEL_VISIBILITY_TAG[reel.visibility]
  const toggleable = canToggleReel(reel)
  const texts = reel.overlays.filter((overlay) => overlay.text.trim() !== '')

  return (
    <div style={{ display: 'flex', gap: 20, alignItems: 'flex-start', flexWrap: 'wrap' }}>
      <ReelPreview reel={reel} width={REEL_DETAIL_PREVIEW_WIDTH} playable />
      <div style={{ flex: 1, minWidth: 260 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 12 }}>
          <Avatar src={reel.author?.avatar} icon={<UserOutlined />} size={44} />
          <div style={{ minWidth: 0 }}>
            <div style={{ fontSize: 16, fontWeight: 600 }}>
              {reel.author?.fullName || reel.author?.username || '—'}
            </div>
            {reel.author?.username && <div style={{ color: '#6b7785' }}>@{reel.author.username}</div>}
          </div>
          <Tooltip title={toggleable ? null : REEL_TOGGLE_LOCKED_HINT}>
            <Switch
              style={{ marginLeft: 'auto' }}
              checked={reel.enabled}
              checkedChildren="Hiện"
              unCheckedChildren="Ẩn"
              disabled={!toggleable}
              loading={status.pendingId === reel.id}
              onChange={(value) => status.toggle(reel, value)}
            />
          </Tooltip>
        </div>
        <Descriptions column={1} size="small" bordered>
          <Descriptions.Item label="Loại">
            <Space size={4}>
              <Tag color={typeTag.color}>{typeTag.label}</Tag>
              <Tag color={visibilityTag.color}>{visibilityTag.label}</Tag>
            </Space>
          </Descriptions.Item>
          <Descriptions.Item label="Tình trạng">
            <Space size={4} wrap>
              <Tag color={stateTag.color}>{stateTag.label}</Tag>
              {!reel.enabled && <Tag color="red">Admin đã ẩn</Tag>}
              {reel.mediaPurged && <Tag>Media đã dọn</Tag>}
            </Space>
          </Descriptions.Item>
          <Descriptions.Item label="Đăng lúc">{formatDateTime(reel.createdAt)}</Descriptions.Item>
          <Descriptions.Item label="Hết hạn lúc">{formatDateTime(reel.expiresAt)}</Descriptions.Item>
          {reel.deletedAt && (
            <Descriptions.Item label="Xoá lúc">{formatDateTime(reel.deletedAt)}</Descriptions.Item>
          )}
          {reel.type === 'video' && (
            <Descriptions.Item label="Video">{videoSummary(reel)}</Descriptions.Item>
          )}
          <Descriptions.Item label="Lượt xem">{reel.viewerCount ?? '—'}</Descriptions.Item>
          <Descriptions.Item label="Báo cáo">
            {reel.reportCount === 0
              ? 'Chưa có'
              : `${reel.reportCount} báo cáo · ${reel.pendingReportCount} chờ xử lý`}
          </Descriptions.Item>
          <Descriptions.Item label="ID">
            <Typography.Text copyable style={{ fontSize: 12 }}>
              {reel.id}
            </Typography.Text>
          </Descriptions.Item>
        </Descriptions>
        {texts.length > 0 && (
          <>
            <Divider style={{ margin: '16px 0 8px' }}>Chữ trên reel</Divider>
            {texts.map((overlay) => (
              <Typography.Paragraph key={overlay.id} style={{ whiteSpace: 'pre-wrap', marginBottom: 6 }}>
                {overlay.text}
              </Typography.Paragraph>
            ))}
          </>
        )}
      </div>
    </div>
  )
}

function loadErrorText(error: unknown): string {
  return toApiError(error).status === HTTP_NOT_FOUND
    ? 'Reel không còn tồn tại'
    : errorMessage(error, 'Không tải được reel')
}

export function ReelDetailModal({ reelId, onClose }: ReelDetailModalProps) {
  const { data, isLoading, error } = useReelDetail(reelId)

  return (
    <Modal
      title="Chi tiết reel"
      open={reelId != null}
      onCancel={onClose}
      centered
      width={820}
      destroyOnHidden
      styles={{ body: { maxHeight: '76vh', overflowY: 'auto', paddingRight: 8 } }}
      footer={[
        <Button key="close" onClick={onClose}>
          Đóng
        </Button>,
      ]}
    >
      {error ? (
        <Empty image={Empty.PRESENTED_IMAGE_SIMPLE} description={loadErrorText(error)} />
      ) : isLoading || !data ? (
        <Skeleton active avatar paragraph={{ rows: 8 }} />
      ) : (
        <>
          <ReelInfo reel={data} />
          <Divider style={{ marginTop: 24, marginBottom: 8 }}>
            Người xem{data.viewerCount != null ? ` (${data.viewerCount})` : ''}
          </Divider>
          <ReelViewers key={data.id} reel={data} />
        </>
      )}
    </Modal>
  )
}
