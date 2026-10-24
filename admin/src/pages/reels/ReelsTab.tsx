import { useState } from 'react'
import {
  Badge,
  Button,
  Input,
  Select,
  Switch,
  Table,
  Tag,
  Tooltip,
  Typography,
  type TableColumnsType,
} from 'antd'
import { ClearOutlined, EyeOutlined } from '@ant-design/icons'
import type { ReelType, ReelVisibility } from '@ola/shared/types'
import { UserBriefCell } from '@/components/UserBriefCell'
import { useDebounce } from '@/hooks/useDebounce'
import { formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { AdminReel, AdminReelState } from '@/types'
import { triToBool } from '../me/utils'
import type { TriState } from '../me/types'
import { ReelDetailModal } from './ReelDetailModal'
import { ReelPreview } from './ReelPreview'
import { useReelList, useToggleReelStatus } from './useReelQueries'
import { canToggleReel, reelExcerpt } from './utils'
import {
  REEL_SORT_OPTIONS,
  REEL_STATE_TAG,
  REEL_TABLE_PREVIEW_WIDTH,
  REEL_TOGGLE_LOCKED_HINT,
  REEL_TYPE_TAG,
  REEL_VISIBILITY_TAG,
} from './constants'

type AnyOr<T> = 'all' | T

function tagOptions<K extends string>(allLabel: string, tags: Record<K, { label: string }>) {
  return [
    { value: 'all', label: allLabel },
    ...(Object.keys(tags) as K[]).map((key) => ({ value: key, label: tags[key].label })),
  ]
}

const pickAll = <T,>(value: AnyOr<T>): T | undefined => (value === 'all' ? undefined : value)

export function ReelsTab() {
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const [type, setType] = useState<AnyOr<ReelType>>('all')
  const [state, setState] = useState<AnyOr<AdminReelState>>('all')
  const [visibility, setVisibility] = useState<AnyOr<ReelVisibility>>('all')
  const [shown, setShown] = useState<TriState>('all')
  const [pendingReports, setPendingReports] = useState<TriState>('all')
  const [sort, setSort] = useState('newest')
  const [detailId, setDetailId] = useState<string | null>(null)

  function resetPage<T>(setter: (v: T) => void) {
    return (v: T) => {
      setter(v)
      setPage(1)
    }
  }

  const hasActiveFilter =
    search !== '' ||
    type !== 'all' ||
    state !== 'all' ||
    visibility !== 'all' ||
    shown !== 'all' ||
    pendingReports !== 'all' ||
    sort !== 'newest'

  function clearFilters() {
    setSearch('')
    setType('all')
    setState('all')
    setVisibility('all')
    setShown('all')
    setPendingReports('all')
    setSort('newest')
    setPage(1)
  }

  const sortParams = REEL_SORT_OPTIONS.find((o) => o.value === sort)?.params ?? {}

  const { data, isFetching } = useReelList({
    q: q || undefined,
    type: pickAll(type),
    state: pickAll(state),
    visibility: pickAll(visibility),
    enabled: triToBool(shown),
    hasPendingReports: triToBool(pendingReports),
    ...sortParams,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const status = useToggleReelStatus()

  const columns: TableColumnsType<AdminReel> = [
    {
      title: 'Xem trước',
      key: 'preview',
      width: 84,
      fixed: 'left',
      render: (_, reel) => (
        <Button type="text" style={{ padding: 0, height: 'auto' }} onClick={() => setDetailId(reel.id)}>
          <ReelPreview reel={reel} width={REEL_TABLE_PREVIEW_WIDTH} />
        </Button>
      ),
    },
    {
      title: 'Tác giả',
      dataIndex: 'author',
      width: 190,
      render: (_, reel) => <UserBriefCell user={reel.author} />,
    },
    {
      title: 'Loại',
      dataIndex: 'type',
      width: 80,
      render: (value: ReelType) => <Tag color={REEL_TYPE_TAG[value].color}>{REEL_TYPE_TAG[value].label}</Tag>,
    },
    {
      title: 'Chữ trên reel',
      key: 'text',
      width: 260,
      render: (_, reel) => {
        const text = reelExcerpt(reel)
        return text ? (
          <Typography.Paragraph ellipsis={{ rows: 2 }} style={{ marginBottom: 0, maxWidth: 260 }}>
            {text}
          </Typography.Paragraph>
        ) : (
          <Typography.Text type="secondary">(không có chữ)</Typography.Text>
        )
      },
    },
    {
      title: 'Quyền xem',
      dataIndex: 'visibility',
      width: 100,
      render: (value: ReelVisibility) => (
        <Tag color={REEL_VISIBILITY_TAG[value].color}>{REEL_VISIBILITY_TAG[value].label}</Tag>
      ),
    },
    {
      title: 'Tình trạng',
      dataIndex: 'state',
      width: 140,
      render: (value: AdminReelState) => (
        <Tag color={REEL_STATE_TAG[value].color}>{REEL_STATE_TAG[value].label}</Tag>
      ),
    },
    {
      title: 'Lượt xem',
      dataIndex: 'viewerCount',
      width: 90,
      align: 'center',
      render: (value: number | null) => value ?? <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'Báo cáo',
      key: 'reports',
      width: 90,
      align: 'center',
      render: (_, reel) =>
        reel.pendingReportCount > 0 ? (
          <Tooltip title={`${reel.pendingReportCount} chờ xử lý / ${reel.reportCount} báo cáo`}>
            <Badge count={reel.pendingReportCount} />
          </Tooltip>
        ) : (
          <Typography.Text type="secondary">{reel.reportCount || '—'}</Typography.Text>
        ),
    },
    {
      title: 'Hiện / Ẩn',
      dataIndex: 'enabled',
      width: 100,
      render: (enabled: boolean, reel) => (
        <Tooltip title={canToggleReel(reel) ? null : REEL_TOGGLE_LOCKED_HINT}>
          <Switch
            checked={enabled}
            checkedChildren="Hiện"
            unCheckedChildren="Ẩn"
            disabled={!canToggleReel(reel)}
            loading={status.pendingId === reel.id}
            onChange={(value) => status.toggle(reel, value)}
          />
        </Tooltip>
      ),
    },
    {
      title: 'Đăng lúc',
      dataIndex: 'createdAt',
      width: 170,
      render: (_, reel) => (
        <div style={{ lineHeight: 1.3 }}>
          <div>{formatDateTime(reel.createdAt)}</div>
          <div style={{ fontSize: 12, color: '#6b7785' }}>Hết hạn {formatDateTime(reel.expiresAt)}</div>
        </div>
      ),
    },
    {
      title: '',
      key: 'actions',
      width: 110,
      fixed: 'right',
      render: (_, reel) => (
        <Button size="small" icon={<EyeOutlined />} onClick={() => setDetailId(reel.id)}>
          Chi tiết
        </Button>
      ),
    },
  ]

  return (
    <>
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          flexWrap: 'wrap',
          gap: 12,
          alignItems: 'center',
        }}
      >
        <Input.Search
          allowClear
          placeholder="Tìm theo chữ trên reel..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
          style={{ width: 260 }}
        />
        <Select
          value={type}
          onChange={resetPage(setType)}
          style={{ width: 130 }}
          options={tagOptions('Mọi loại', REEL_TYPE_TAG)}
        />
        <Select
          value={state}
          onChange={resetPage(setState)}
          style={{ width: 170 }}
          options={tagOptions('Mọi tình trạng', REEL_STATE_TAG)}
        />
        <Select
          value={visibility}
          onChange={resetPage(setVisibility)}
          style={{ width: 150 }}
          options={tagOptions('Mọi quyền xem', REEL_VISIBILITY_TAG)}
        />
        <Select
          value={shown}
          onChange={resetPage(setShown)}
          style={{ width: 170 }}
          options={[
            { value: 'all', label: 'Hiện / Ẩn: tất cả' },
            { value: 'yes', label: 'Đang hiện' },
            { value: 'no', label: 'Admin đã ẩn' },
          ]}
        />
        <Select
          value={pendingReports}
          onChange={resetPage(setPendingReports)}
          style={{ width: 190 }}
          options={[
            { value: 'all', label: 'Báo cáo: tất cả' },
            { value: 'yes', label: 'Có báo cáo chờ xử lý' },
            { value: 'no', label: 'Không có báo cáo chờ' },
          ]}
        />
        <Select
          value={sort}
          onChange={resetPage(setSort)}
          style={{ width: 210 }}
          options={REEL_SORT_OPTIONS.map((o) => ({ value: o.value, label: `Sắp xếp: ${o.label}` }))}
        />
        {hasActiveFilter && (
          <Button icon={<ClearOutlined />} onClick={clearFilters}>
            Xoá lọc
          </Button>
        )}
      </div>
      <Table<AdminReel>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 1420 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} reel`,
          onChange: setPage,
        }}
      />
      <ReelDetailModal reelId={detailId} onClose={() => setDetailId(null)} />
    </>
  )
}
