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
import { reactionLabel } from '@/pages/rooms/utils'
import { formatDateTime } from '@/lib/format'
import { BRAND } from '@/theme'
import type { AdminMoment, AdminMomentDetail, AdminMomentViewer, MomentReactionCount } from '@/types'
import { MomentPreview } from './MomentPreview'
import {
  useMomentDetail,
  useMomentViewers,
  usePurgeMomentMedia,
  useSeedMomentDetail,
  useToggleMomentStatus,
} from './useMomentQueries'
import {
  canPurgeMomentMedia,
  canToggleMoment,
  hasMomentSwitch,
  momentHiddenByLabel,
  videoSummary,
} from './utils'
import {
  HTTP_NOT_FOUND,
  MOMENT_DETAIL_PREVIEW_WIDTH,
  MOMENT_PAGE_THUMB_WIDTH,
  MOMENT_STATE_TAG,
  MOMENT_TOGGLE_LOCKED_HINT,
  MOMENT_TYPE_TAG,
  MOMENT_VIEWER_PAGE_SIZE,
  MOMENT_VISIBILITY_TAG,
} from './constants'

interface MomentDetailModalProps {
  momentId: string | null
  onClose: () => void
}

function MomentReactionTags({ reactions }: { reactions: MomentReactionCount[] }) {
  return (
    <Space size={4} wrap>
      {reactions.map(({ type, count }) => (
        <Tag key={type} style={{ margin: 0, borderRadius: 12 }}>
          {reactionLabel(type.toLowerCase())} {count}
        </Tag>
      ))}
    </Space>
  )
}

const VIEWER_COLUMNS: TableColumnsType<AdminMomentViewer> = [
  { key: 'user', render: (_, viewer) => <UserBriefCell user={viewer.user} /> },
  {
    key: 'reactions',
    render: (_, viewer) =>
      viewer.reactions && viewer.reactions.length > 0 ? <MomentReactionTags reactions={viewer.reactions} /> : null,
  },
  {
    key: 'viewedAt',
    align: 'right',
    render: (_, viewer) => <Typography.Text type="secondary">{formatDateTime(viewer.viewedAt)}</Typography.Text>,
  },
]

function MomentViewers({ moment }: { moment: AdminMoment }) {
  const [page, setPage] = useState(1)
  const live = moment.viewerCount != null
  const { data, isFetching } = useMomentViewers(live ? moment.id : null, {
    limit: MOMENT_VIEWER_PAGE_SIZE,
    offset: (page - 1) * MOMENT_VIEWER_PAGE_SIZE,
  })

  if (!live) {
    return (
      <Empty
        image={Empty.PRESENTED_IMAGE_SIMPLE}
        description="Danh sách người xem chỉ có khi khoảnh khắc còn hạn và chưa bị xoá"
      />
    )
  }
  return (
    <Table<AdminMomentViewer>
      size="small"
      rowKey={(viewer) => viewer.user.id}
      loading={isFetching}
      dataSource={data?.items ?? []}
      locale={{ emptyText: 'Chưa có ai xem' }}
      showHeader={false}
      columns={VIEWER_COLUMNS}
      pagination={
        (data?.total ?? 0) > MOMENT_VIEWER_PAGE_SIZE
          ? {
              current: page,
              pageSize: MOMENT_VIEWER_PAGE_SIZE,
              total: data?.total ?? 0,
              onChange: setPage,
              size: 'small',
            }
          : false
      }
    />
  )
}

function MomentPages({
  moment,
  onSelect,
}: {
  moment: AdminMomentDetail
  onSelect: (page: AdminMoment) => void
}) {
  if (moment.pages.length < 2) return null
  return (
    <div>
      <Typography.Text type="secondary" style={{ fontSize: 12 }}>
        Bài có {moment.pages.length} trang
      </Typography.Text>
      <div style={{ display: 'flex', gap: 8, marginTop: 6 }}>
        {moment.pages.map((page) => {
          const current = page.id === moment.id
          return (
            <button
              key={page.id}
              type="button"
              aria-current={current}
              onClick={() => onSelect(page)}
              style={{
                padding: 2,
                border: `2px solid ${current ? BRAND.primary : 'transparent'}`,
                borderRadius: 10,
                background: 'none',
                cursor: current ? 'default' : 'pointer',
              }}
            >
              <MomentPreview moment={page} width={MOMENT_PAGE_THUMB_WIDTH} />
              <div style={{ marginTop: 4, fontSize: 12, color: current ? BRAND.text : '#6b7785' }}>
                Trang {page.position + 1}
              </div>
            </button>
          )
        })}
      </div>
    </div>
  )
}

function MomentInfo({
  moment,
  onSelectPage,
}: {
  moment: AdminMomentDetail
  onSelectPage: (page: AdminMoment) => void
}) {
  const status = useToggleMomentStatus()
  const media = usePurgeMomentMedia()
  const hiddenBy = momentHiddenByLabel(moment)
  const typeTag = MOMENT_TYPE_TAG[moment.type]
  const stateTag = MOMENT_STATE_TAG[moment.state]
  const visibilityTag = MOMENT_VISIBILITY_TAG[moment.visibility]
  const toggleable = canToggleMoment(moment)
  const texts = moment.overlays.filter((overlay) => overlay.text.trim() !== '')

  return (
    <div style={{ display: 'flex', gap: 20, alignItems: 'flex-start', flexWrap: 'wrap' }}>
      <div style={{ display: 'flex', flexDirection: 'column', gap: 12, width: MOMENT_DETAIL_PREVIEW_WIDTH }}>
        <MomentPreview moment={moment} width={MOMENT_DETAIL_PREVIEW_WIDTH} playable />
        <MomentPages moment={moment} onSelect={onSelectPage} />
      </div>
      <div style={{ flex: 1, minWidth: 260 }}>
        <div style={{ display: 'flex', alignItems: 'center', gap: 12, marginBottom: 12 }}>
          <Avatar src={moment.author?.avatar} icon={<UserOutlined />} size={44} />
          <div style={{ minWidth: 0 }}>
            <div style={{ fontSize: 16, fontWeight: 600 }}>
              {moment.author?.fullName || moment.author?.username || '—'}
            </div>
            {moment.author?.username && <div style={{ color: '#6b7785' }}>@{moment.author.username}</div>}
          </div>
          {hasMomentSwitch(moment) && (
            <Tooltip title={toggleable ? null : MOMENT_TOGGLE_LOCKED_HINT}>
              <Switch
                style={{ marginLeft: 'auto' }}
                checked={moment.enabled}
                checkedChildren="Hiện"
                unCheckedChildren="Ẩn"
                disabled={!toggleable}
                loading={status.pendingId === moment.id}
                onChange={(value) => status.toggle(moment, value)}
              />
            </Tooltip>
          )}
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
              {!moment.enabled && <Tag color="red">{hiddenBy ?? 'Đã ẩn'}</Tag>}
              {moment.mediaPurged && <Tag>Đã xoá file</Tag>}
            </Space>
          </Descriptions.Item>
          {moment.hiddenAt && (
            <Descriptions.Item label="Ẩn lúc">{formatDateTime(moment.hiddenAt)}</Descriptions.Item>
          )}
          {moment.purgedAt && (
            <Descriptions.Item label="Xoá file lúc">{formatDateTime(moment.purgedAt)}</Descriptions.Item>
          )}
          {canPurgeMomentMedia(moment) && (
            <Descriptions.Item label="File ảnh/video">
              <Button
                size="small"
                danger
                loading={media.pendingId === moment.id}
                onClick={() => media.purge(moment)}
              >
                Xoá file khỏi bộ nhớ
              </Button>
            </Descriptions.Item>
          )}
          <Descriptions.Item label="Đăng lúc">{formatDateTime(moment.createdAt)}</Descriptions.Item>
          <Descriptions.Item label="Hết hạn lúc">{formatDateTime(moment.expiresAt)}</Descriptions.Item>
          {moment.deletedAt && (
            <Descriptions.Item label="Xoá lúc">{formatDateTime(moment.deletedAt)}</Descriptions.Item>
          )}
          {moment.type === 'video' && (
            <Descriptions.Item label="Video">{videoSummary(moment)}</Descriptions.Item>
          )}
          <Descriptions.Item label="Lượt xem">{moment.viewerCount ?? '—'}</Descriptions.Item>
          <Descriptions.Item label="Cảm xúc">
            {moment.reactionCount > 0 ? (
              <Space size={6} wrap>
                <Typography.Text strong>{moment.reactionCount}</Typography.Text>
                <MomentReactionTags reactions={moment.reactions} />
              </Space>
            ) : (
              '—'
            )}
          </Descriptions.Item>
          <Descriptions.Item label="Báo cáo">
            {moment.reportCount === 0
              ? 'Chưa có'
              : `${moment.reportCount} báo cáo · ${moment.pendingReportCount} chờ xử lý`}
          </Descriptions.Item>
          <Descriptions.Item label="ID">
            <Typography.Text copyable style={{ fontSize: 12 }}>
              {moment.id}
            </Typography.Text>
          </Descriptions.Item>
        </Descriptions>
        {texts.length > 0 && (
          <>
            <Divider style={{ margin: '16px 0 8px' }}>Chữ trên khoảnh khắc</Divider>
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
    ? 'Khoảnh khắc không còn tồn tại'
    : errorMessage(error, 'Không tải được khoảnh khắc')
}

export function MomentDetailModal({ momentId, onClose }: MomentDetailModalProps) {
  const [selection, setSelection] = useState({ openedId: momentId, shownId: momentId })
  if (selection.openedId !== momentId) {
    setSelection({ openedId: momentId, shownId: momentId })
  }
  const { data, isLoading, error } = useMomentDetail(selection.shownId)
  const seedDetail = useSeedMomentDetail()

  function selectPage(page: AdminMoment) {
    if (data == null || page.id === data.id) return
    seedDetail(page, data.pages)
    setSelection({ openedId: momentId, shownId: page.id })
  }

  return (
    <Modal
      title="Chi tiết khoảnh khắc"
      open={momentId != null}
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
          <MomentInfo moment={data} onSelectPage={selectPage} />
          <Divider style={{ marginTop: 24, marginBottom: 8 }}>
            Người xem{data.viewerCount != null ? ` (${data.viewerCount})` : ''}
          </Divider>
          <MomentViewers key={data.id} moment={data} />
        </>
      )}
    </Modal>
  )
}
