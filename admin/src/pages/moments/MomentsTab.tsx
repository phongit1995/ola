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
import { ClearOutlined, DeleteOutlined, EyeOutlined, SettingOutlined } from '@ant-design/icons'
import type { MomentType, MomentVisibility } from '@ola/shared/types'
import { UserBriefCell } from '@/components/UserBriefCell'
import { useDebounce } from '@/hooks/useDebounce'
import { formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { AdminMoment, AdminMomentState } from '@/types'
import { triToBool } from '../me/utils'
import type { TriState } from '../me/types'
import { MomentDetailModal } from './MomentDetailModal'
import { MomentPreview } from './MomentPreview'
import { MomentSettingsDrawer } from './MomentSettingsDrawer'
import { useMomentList, usePurgeMomentMedia, useToggleMomentStatus } from './useMomentQueries'
import {
  canPurgeMomentMedia,
  canToggleMoment,
  hasMomentSwitch,
  momentExcerpt,
  momentHiddenByLabel,
  momentPageLabel,
} from './utils'
import {
  MOMENT_SORT_OPTIONS,
  MOMENT_STATE_TAG,
  MOMENT_SWITCHLESS_HINT,
  MOMENT_TABLE_PREVIEW_WIDTH,
  MOMENT_TOGGLE_LOCKED_HINT,
  MOMENT_TYPE_TAG,
  MOMENT_VISIBILITY_TAG,
} from './constants'

type AnyOr<T> = 'all' | T

function tagOptions<K extends string>(allLabel: string, tags: Record<K, { label: string }>) {
  return [
    { value: 'all', label: allLabel },
    ...(Object.keys(tags) as K[]).map((key) => ({ value: key, label: tags[key].label })),
  ]
}

const pickAll = <T,>(value: AnyOr<T>): T | undefined => (value === 'all' ? undefined : value)

export function MomentsTab() {
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const q = useDebounce(search.trim())

  const [type, setType] = useState<AnyOr<MomentType>>('all')
  const [state, setState] = useState<AnyOr<AdminMomentState>>('all')
  const [visibility, setVisibility] = useState<AnyOr<MomentVisibility>>('all')
  const [shown, setShown] = useState<TriState>('all')
  const [pendingReports, setPendingReports] = useState<TriState>('all')
  const [sort, setSort] = useState('newest')
  const [detailId, setDetailId] = useState<string | null>(null)
  const [settingsOpen, setSettingsOpen] = useState(false)

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

  const sortParams = MOMENT_SORT_OPTIONS.find((o) => o.value === sort)?.params ?? {}

  const { data, isFetching } = useMomentList({
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
  const status = useToggleMomentStatus()
  const media = usePurgeMomentMedia()

  const columns: TableColumnsType<AdminMoment> = [
    {
      title: 'Xem trước',
      key: 'preview',
      width: 84,
      fixed: 'left',
      render: (_, moment) => (
        <Button type="text" style={{ padding: 0, height: 'auto' }} onClick={() => setDetailId(moment.id)}>
          <MomentPreview moment={moment} width={MOMENT_TABLE_PREVIEW_WIDTH} />
        </Button>
      ),
    },
    {
      title: 'Tác giả',
      dataIndex: 'author',
      width: 190,
      render: (_, moment) => <UserBriefCell user={moment.author} />,
    },
    {
      title: 'Loại',
      dataIndex: 'type',
      width: 90,
      render: (value: MomentType, moment) => {
        const page = momentPageLabel(moment)
        return (
          <div style={{ lineHeight: 1.3 }}>
            <Tag color={MOMENT_TYPE_TAG[value].color}>{MOMENT_TYPE_TAG[value].label}</Tag>
            {page && <div style={{ marginTop: 4, fontSize: 12, color: '#6b7785' }}>{page}</div>}
          </div>
        )
      },
    },
    {
      title: 'Chữ trên khoảnh khắc',
      key: 'text',
      width: 260,
      render: (_, moment) => {
        const text = momentExcerpt(moment)
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
      render: (value: MomentVisibility) => (
        <Tag color={MOMENT_VISIBILITY_TAG[value].color}>{MOMENT_VISIBILITY_TAG[value].label}</Tag>
      ),
    },
    {
      title: 'Tình trạng',
      dataIndex: 'state',
      width: 140,
      render: (value: AdminMomentState) => (
        <Tag color={MOMENT_STATE_TAG[value].color}>{MOMENT_STATE_TAG[value].label}</Tag>
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
      title: 'Bình luận',
      dataIndex: 'commentCount',
      width: 90,
      align: 'center',
      render: (value: number) => value || <Typography.Text type="secondary">—</Typography.Text>,
    },
    {
      title: 'Báo cáo',
      key: 'reports',
      width: 90,
      align: 'center',
      render: (_, moment) =>
        moment.pendingReportCount > 0 ? (
          <Tooltip title={`${moment.pendingReportCount} chờ xử lý / ${moment.reportCount} báo cáo`}>
            <Badge count={moment.pendingReportCount} />
          </Tooltip>
        ) : (
          <Typography.Text type="secondary">{moment.reportCount || '—'}</Typography.Text>
        ),
    },
    {
      title: 'Hiện / Ẩn',
      dataIndex: 'enabled',
      width: 110,
      render: (enabled: boolean, moment) => {
        if (!hasMomentSwitch(moment)) {
          return (
            <Tooltip title={MOMENT_SWITCHLESS_HINT}>
              <Typography.Text type="secondary">—</Typography.Text>
            </Tooltip>
          )
        }
        const hiddenBy = momentHiddenByLabel(moment)
        return (
          <div style={{ lineHeight: 1.3 }}>
            <Tooltip title={canToggleMoment(moment) ? null : MOMENT_TOGGLE_LOCKED_HINT}>
              <Switch
                checked={enabled}
                checkedChildren="Hiện"
                unCheckedChildren="Ẩn"
                disabled={!canToggleMoment(moment)}
                loading={status.pendingId === moment.id}
                onChange={(value) => status.toggle(moment, value)}
              />
            </Tooltip>
            {hiddenBy && <div style={{ fontSize: 12, color: '#6b7785' }}>{hiddenBy}</div>}
          </div>
        )
      },
    },
    {
      title: 'Đăng lúc',
      dataIndex: 'createdAt',
      width: 170,
      render: (_, moment) => (
        <div style={{ lineHeight: 1.3 }}>
          <div>{formatDateTime(moment.createdAt)}</div>
          <div style={{ fontSize: 12, color: '#6b7785' }}>Hết hạn {formatDateTime(moment.expiresAt)}</div>
        </div>
      ),
    },
    {
      title: '',
      key: 'actions',
      width: 120,
      fixed: 'right',
      render: (_, moment) => (
        <div style={{ display: 'flex', flexDirection: 'column', gap: 6 }}>
          <Button size="small" icon={<EyeOutlined />} onClick={() => setDetailId(moment.id)}>
            Chi tiết
          </Button>
          {canPurgeMomentMedia(moment) && (
            <Button
              size="small"
              danger
              icon={<DeleteOutlined />}
              loading={media.pendingId === moment.id}
              onClick={() => media.purge(moment)}
            >
              Xoá file
            </Button>
          )}
        </div>
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
          placeholder="Tìm theo chữ trên khoảnh khắc..."
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
          style={{ width: 300 }}
        />
        <Select
          value={type}
          onChange={resetPage(setType)}
          style={{ width: 130 }}
          options={tagOptions('Mọi loại', MOMENT_TYPE_TAG)}
        />
        <Select
          value={state}
          onChange={resetPage(setState)}
          style={{ width: 170 }}
          options={tagOptions('Mọi tình trạng', MOMENT_STATE_TAG)}
        />
        <Select
          value={visibility}
          onChange={resetPage(setVisibility)}
          style={{ width: 150 }}
          options={tagOptions('Mọi quyền xem', MOMENT_VISIBILITY_TAG)}
        />
        <Select
          value={shown}
          onChange={resetPage(setShown)}
          style={{ width: 170 }}
          options={[
            { value: 'all', label: 'Hiện / Ẩn: tất cả' },
            { value: 'yes', label: 'Đang hiện' },
            { value: 'no', label: 'Đã ẩn' },
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
          options={MOMENT_SORT_OPTIONS.map((o) => ({ value: o.value, label: `Sắp xếp: ${o.label}` }))}
        />
        {hasActiveFilter && (
          <Button icon={<ClearOutlined />} onClick={clearFilters}>
            Xoá lọc
          </Button>
        )}
        <Button
          icon={<SettingOutlined />}
          style={{ marginLeft: 'auto' }}
          onClick={() => setSettingsOpen(true)}
        >
          Cài đặt
        </Button>
      </div>
      <Table<AdminMoment>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 1430 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} khoảnh khắc`,
          onChange: setPage,
        }}
      />
      <MomentDetailModal momentId={detailId} onClose={() => setDetailId(null)} />
      <MomentSettingsDrawer open={settingsOpen} onClose={() => setSettingsOpen(false)} />
    </>
  )
}
