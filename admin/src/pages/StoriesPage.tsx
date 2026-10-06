import { useState, type Key } from 'react'
import {
  App,
  Button,
  Card,
  Col,
  Image,
  Input,
  Row,
  Select,
  Space,
  Statistic,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import {
  ClearOutlined,
  DeleteOutlined,
  EyeInvisibleOutlined,
  EyeOutlined,
  UnorderedListOutlined,
} from '@ant-design/icons'
import type { StoryKind, StorySort, StoryStatus } from '@ola/shared/types'
import { useDebounce } from '@/hooks/useDebounce'
import {
  useDeleteStory,
  useSetStoriesHidden,
  useSetStoryHidden,
  useStories,
  useStoryGenres,
  useStorySources,
  useStorySummary,
} from '@/hooks/useStories'
import { formatDate, formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import { StoryChaptersModal } from './StoryChaptersModal'
import type {
  AdminStory,
  AdminStoryBulkVisibilityInput,
  AdminStoryFilter,
  AdminStoryListParams,
  AdminStoryVisibility,
} from '@/types'

const PAGE_SIZE = 20
const COVER_WIDTH = 44
const COVER_HEIGHT = 58
const ALL = 'all'

const SOURCE_LABEL: Record<string, string> = {
  vnkings: 'Vnkings',
}

const KIND_LABEL: Record<StoryKind, string> = {
  long: 'Truyện dài',
  short: 'Truyện ngắn',
}

const STATUS_TAG: Record<StoryStatus, { label: string; color?: string }> = {
  ongoing: { label: 'Đang ra', color: 'orange' },
  completed: { label: 'Hoàn thành', color: 'green' },
  unknown: { label: 'Không rõ' },
}

const VISIBILITY_LABEL: Record<AdminStoryVisibility, string> = {
  all: 'Cả ẩn và hiện',
  visible: 'Đang hiện',
  hidden: 'Đang ẩn',
}

const KIND_OPTIONS = [
  { value: ALL, label: 'Mọi loại' },
  { value: 'long', label: KIND_LABEL.long },
  { value: 'short', label: KIND_LABEL.short },
]

const STATUS_OPTIONS = [
  { value: ALL, label: 'Mọi tình trạng' },
  { value: 'ongoing', label: STATUS_TAG.ongoing.label },
  { value: 'completed', label: STATUS_TAG.completed.label },
]

const VISIBILITY_OPTIONS: { value: AdminStoryVisibility; label: string }[] = [
  { value: 'all', label: VISIBILITY_LABEL.all },
  { value: 'visible', label: VISIBILITY_LABEL.visible },
  { value: 'hidden', label: VISIBILITY_LABEL.hidden },
]

const SORT_OPTIONS: { value: StorySort; label: string }[] = [
  { value: 'updated', label: 'Mới cập nhật' },
  { value: 'views', label: 'Xem nhiều' },
  { value: 'new', label: 'Mới đăng' },
]

function formatCount(value: number) {
  return value.toLocaleString('vi-VN')
}

function percent(part: number, total: number) {
  return total > 0 ? Math.round((part / total) * 1000) / 10 : 0
}

function sourceLabel(source: string) {
  return SOURCE_LABEL[source] ?? source
}

function describeFilter(filter: AdminStoryFilter): string[] {
  const parts: string[] = []
  if (filter.source) parts.push(`nguồn ${sourceLabel(filter.source)}`)
  if (filter.genre) parts.push(`thể loại ${filter.genre}`)
  if (filter.kind) parts.push(KIND_LABEL[filter.kind].toLowerCase())
  if (filter.status) parts.push(STATUS_TAG[filter.status].label.toLowerCase())
  if (filter.visibility && filter.visibility !== 'all') {
    parts.push(VISIBILITY_LABEL[filter.visibility].toLowerCase())
  }
  if (filter.q) parts.push(`tìm “${filter.q}”`)
  return parts
}

export function StoriesPage() {
  const { message, modal } = App.useApp()
  const [search, setSearch] = useState('')
  const [source, setSource] = useState<string | undefined>()
  const [genre, setGenre] = useState<string | undefined>()
  const [kind, setKind] = useState<string>(ALL)
  const [status, setStatus] = useState<string>(ALL)
  const [visibility, setVisibility] = useState<AdminStoryVisibility>('all')
  const [sort, setSort] = useState<StorySort>('updated')
  const [page, setPage] = useState(1)
  const [selectedIds, setSelectedIds] = useState<string[]>([])
  const [chaptersStory, setChaptersStory] = useState<AdminStory | null>(null)
  const q = useDebounce(search.trim())

  const filter: AdminStoryFilter = {
    q: q || undefined,
    source,
    genre,
    kind: kind === ALL ? undefined : (kind as StoryKind),
    status: status === ALL ? undefined : (status as AdminStoryFilter['status']),
    visibility,
  }
  const params: AdminStoryListParams = {
    ...filter,
    sort,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  }
  const { data, isFetching, isPlaceholderData } = useStories(params)
  const { data: summary } = useStorySummary()
  const { data: genres } = useStoryGenres()
  const { data: sources } = useStorySources()
  const setHidden = useSetStoryHidden()
  const setManyHidden = useSetStoriesHidden()
  const deleteStory = useDeleteStory()

  const total = data?.total ?? 0
  const lastPage = Math.max(1, Math.ceil(total / PAGE_SIZE))
  if (data && !isPlaceholderData && page > lastPage) {
    setPage(lastPage)
  }
  const filterParts = describeFilter(filter)
  const filterSettled = !isPlaceholderData && q === search.trim()
  const hasFilter = search.trim() !== '' || filterParts.length > 0

  function resetSelection() {
    setPage(1)
    setSelectedIds([])
  }

  function changeFilter<T>(setter: (value: T) => void) {
    return (value: T) => {
      setter(value)
      resetSelection()
    }
  }

  function clearFilters() {
    setSearch('')
    setSource(undefined)
    setGenre(undefined)
    setKind(ALL)
    setStatus(ALL)
    setVisibility('all')
    resetSelection()
  }

  function toggleVisible(story: AdminStory, visible: boolean) {
    modal.confirm({
      title: visible ? 'Hiện lại truyện này?' : 'Ẩn truyện này?',
      content: visible
        ? 'Người dùng sẽ thấy và đọc được truyện trở lại.'
        : 'Truyện biến mất khỏi danh sách, tìm kiếm và không mở được nữa. Lần nạp dữ liệu sau vẫn giữ trạng thái ẩn.',
      okText: visible ? 'Hiện' : 'Ẩn',
      okButtonProps: { danger: !visible },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await setHidden.mutateAsync({ id: story.id, isHidden: !visible })
          message.success(visible ? 'Đã hiện truyện' : 'Đã ẩn truyện')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
        }
      },
    })
  }

  async function applyVisibility(input: AdminStoryBulkVisibilityInput) {
    const verb = input.isHidden ? 'ẩn' : 'hiện'
    try {
      const { updated } = await setManyHidden.mutateAsync(input)
      if (updated === 0) {
        message.info(`Các truyện này đều đang ${verb} sẵn`)
      } else {
        message.success(`Đã ${verb} ${formatCount(updated)} truyện`)
      }
      if ('ids' in input) setSelectedIds([])
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
    }
  }

  function confirmSelected(isHidden: boolean) {
    const count = selectedIds.length
    modal.confirm({
      title: `${isHidden ? 'Ẩn' : 'Hiện'} ${formatCount(count)} truyện đã chọn?`,
      content: isHidden
        ? 'Người dùng sẽ không thấy và không mở được các truyện này nữa.'
        : 'Người dùng sẽ thấy và đọc được các truyện này.',
      okText: isHidden ? 'Ẩn' : 'Hiện',
      okButtonProps: { danger: isHidden },
      cancelText: 'Huỷ',
      onOk: () => applyVisibility({ isHidden, ids: selectedIds }),
    })
  }

  function confirmFiltered(isHidden: boolean) {
    const scope =
      filterParts.length > 0
        ? `Áp dụng cho mọi truyện khớp bộ lọc: ${filterParts.join(' · ')}, kể cả các trang chưa xem.`
        : 'Chưa chọn bộ lọc nào nên thao tác áp dụng cho toàn bộ truyện.'
    modal.confirm({
      title: `${isHidden ? 'Ẩn' : 'Hiện'} tất cả ${formatCount(total)} truyện?`,
      content: scope,
      okText: isHidden ? 'Ẩn tất cả' : 'Hiện tất cả',
      okButtonProps: { danger: isHidden },
      cancelText: 'Huỷ',
      onOk: () => applyVisibility({ isHidden, filter }),
    })
  }

  function removeStory(story: AdminStory) {
    modal.confirm({
      title: 'Xoá truyện?',
      content: `“${story.title}” và toàn bộ ${story.chapterCount} chương sẽ bị xoá. Nếu truyện vẫn có trong file dữ liệu, lần nạp sau sẽ thêm lại; muốn gỡ hẳn thì dùng Ẩn.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteStory.mutateAsync(story.id)
          setSelectedIds((ids) => ids.filter((id) => id !== story.id))
          message.success('Đã xoá truyện')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<AdminStory> = [
    {
      title: 'Truyện',
      dataIndex: 'title',
      render: (_, story) => (
        <Space align="start">
          <Image
            src={story.coverUrl ?? undefined}
            width={COVER_WIDTH}
            height={COVER_HEIGHT}
            style={{ objectFit: 'cover', borderRadius: 4 }}
            preview={story.coverUrl ? undefined : false}
            fallback="data:image/gif;base64,R0lGODlhAQABAAAAACw="
          />
          <div style={{ lineHeight: 1.35, maxWidth: 360 }}>
            <div style={{ fontWeight: 600, opacity: story.isHidden ? 0.5 : 1 }}>{story.title}</div>
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              {story.authorName || '—'}
            </Typography.Text>
            <div style={{ marginTop: 4 }}>
              {story.genres.map((name) => (
                <Tag key={name} style={{ marginBottom: 2 }}>
                  {name}
                </Tag>
              ))}
            </div>
          </div>
        </Space>
      ),
    },
    {
      title: 'Nguồn',
      dataIndex: 'source',
      width: 110,
      render: (value: string, story) => (
        <Space orientation="vertical" size={2}>
          <Tag color="cyan">{sourceLabel(value)}</Tag>
          <Typography.Link
            href={story.sourceUrl}
            target="_blank"
            rel="noreferrer"
            style={{ fontSize: 12 }}
          >
            ID {story.sourceStoryId}
          </Typography.Link>
        </Space>
      ),
    },
    {
      title: 'Loại',
      dataIndex: 'kind',
      width: 120,
      render: (value: StoryKind, story) => (
        <Space orientation="vertical" size={4}>
          <Tag color={value === 'long' ? 'blue' : 'purple'}>{KIND_LABEL[value]}</Tag>
          <Tag color={STATUS_TAG[story.status].color}>{STATUS_TAG[story.status].label}</Tag>
        </Space>
      ),
    },
    {
      title: 'Chương',
      dataIndex: 'chapterCount',
      width: 140,
      render: (value: number, story) => (
        <div style={{ lineHeight: 1.35 }}>
          <div>{formatCount(value)} chương</div>
          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
            {formatCount(story.contentChapters)} đã có nội dung
          </Typography.Text>
        </div>
      ),
    },
    {
      title: 'Lượt xem',
      dataIndex: 'viewCount',
      width: 90,
      render: (value: number) => formatCount(value),
    },
    {
      title: 'Chương mới nhất',
      dataIndex: 'lastChapterAt',
      width: 120,
      render: (_, story) => formatDate(story.lastChapterAt ?? story.updatedAt),
    },
    {
      title: 'Hiện',
      dataIndex: 'isHidden',
      width: 70,
      render: (isHidden: boolean, story) => (
        <Switch
          checked={!isHidden}
          loading={setHidden.isPending && setHidden.variables?.id === story.id}
          onChange={(value) => toggleVisible(story, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 140,
      render: (_, story) => (
        <Space>
          <Button
            size="small"
            icon={<UnorderedListOutlined />}
            onClick={() => setChaptersStory(story)}
          >
            Chương
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => removeStory(story)}
          />
        </Space>
      ),
    },
  ]

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Row gutter={[16, 16]}>
          <Col xs={12} md={6}>
            <Statistic
              groupSeparator="."
              title="Truyện"
              value={summary?.stories ?? 0}
              suffix={
                <Typography.Text type="secondary" style={{ fontSize: 13 }}>
                  ({formatCount(summary?.longStories ?? 0)} dài ·{' '}
                  {formatCount(summary?.shortStories ?? 0)} ngắn)
                </Typography.Text>
              }
            />
          </Col>
          <Col xs={12} md={4}>
            <Statistic groupSeparator="." title="Đang ẩn" value={summary?.hiddenStories ?? 0} />
          </Col>
          <Col xs={12} md={4}>
            <Statistic groupSeparator="." title="Chương" value={summary?.chapters ?? 0} />
          </Col>
          <Col xs={12} md={5}>
            <Statistic
              groupSeparator="."
              title="Chương đã có nội dung"
              value={summary?.contentChapters ?? 0}
              suffix={
                <Typography.Text type="secondary" style={{ fontSize: 13 }}>
                  ({percent(summary?.contentChapters ?? 0, summary?.chapters ?? 0)}%)
                </Typography.Text>
              }
            />
          </Col>
          <Col xs={24} md={5}>
            <Statistic
              title="Lần nạp gần nhất"
              value={formatDateTime(summary?.lastCrawledAt)}
              styles={{ content: { fontSize: 18 } }}
            />
          </Col>
        </Row>
      </Card>
      <Card>
        <div style={{ marginBottom: 12, display: 'flex', gap: 12, flexWrap: 'wrap' }}>
          <Input.Search
            allowClear
            placeholder="Tìm tên truyện, tác giả (không cần dấu)..."
            value={search}
            onChange={(e) => {
              setSearch(e.target.value)
              resetSelection()
            }}
            style={{ maxWidth: 320 }}
          />
          <Select
            allowClear
            placeholder="Mọi nguồn"
            value={source}
            onChange={changeFilter(setSource)}
            style={{ width: 170 }}
            options={(sources ?? []).map((item) => ({
              value: item.name,
              label: `${sourceLabel(item.name)} (${formatCount(item.count)})`,
            }))}
          />
          <Select
            allowClear
            showSearch
            placeholder="Mọi thể loại"
            value={genre}
            onChange={changeFilter(setGenre)}
            style={{ width: 220 }}
            options={(genres ?? []).map((item) => ({
              value: item.name,
              label: `${item.name} (${item.count})`,
            }))}
          />
          <Select value={kind} onChange={changeFilter(setKind)} options={KIND_OPTIONS} style={{ width: 140 }} />
          <Select
            value={status}
            onChange={changeFilter(setStatus)}
            options={STATUS_OPTIONS}
            style={{ width: 160 }}
          />
          <Select
            value={visibility}
            onChange={changeFilter(setVisibility)}
            options={VISIBILITY_OPTIONS}
            style={{ width: 150 }}
          />
          <Select
            value={sort}
            onChange={(value) => {
              setSort(value)
              setPage(1)
            }}
            options={SORT_OPTIONS}
            style={{ width: 150 }}
          />
          {hasFilter && (
            <Button icon={<ClearOutlined />} onClick={clearFilters}>
              Xoá bộ lọc
            </Button>
          )}
        </div>
        <div
          style={{
            marginBottom: 12,
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            gap: 12,
            flexWrap: 'wrap',
          }}
        >
          {selectedIds.length > 0 ? (
            <Space size={4}>
              <Typography.Text strong>Đã chọn {formatCount(selectedIds.length)} truyện</Typography.Text>
              <Button type="link" size="small" onClick={() => setSelectedIds([])}>
                Bỏ chọn
              </Button>
            </Space>
          ) : (
            <Typography.Text type="secondary">
              {formatCount(total)} truyện
              {filterParts.length > 0 ? ` khớp bộ lọc: ${filterParts.join(' · ')}` : ''}
            </Typography.Text>
          )}
          {selectedIds.length > 0 ? (
            <Space>
              <Button
                danger
                icon={<EyeInvisibleOutlined />}
                loading={setManyHidden.isPending}
                onClick={() => confirmSelected(true)}
              >
                Ẩn đã chọn
              </Button>
              <Button
                icon={<EyeOutlined />}
                loading={setManyHidden.isPending}
                onClick={() => confirmSelected(false)}
              >
                Hiện đã chọn
              </Button>
            </Space>
          ) : (
            <Space>
              <Button
                danger
                icon={<EyeInvisibleOutlined />}
                disabled={!filterSettled || total === 0 || visibility === 'hidden'}
                loading={setManyHidden.isPending}
                onClick={() => confirmFiltered(true)}
              >
                Ẩn tất cả ({formatCount(total)})
              </Button>
              <Button
                icon={<EyeOutlined />}
                disabled={!filterSettled || total === 0 || visibility === 'visible'}
                loading={setManyHidden.isPending}
                onClick={() => confirmFiltered(false)}
              >
                Hiện tất cả ({formatCount(total)})
              </Button>
            </Space>
          )}
        </div>
        <Table<AdminStory>
          rowKey="id"
          columns={columns}
          dataSource={data?.items ?? []}
          loading={isFetching}
          scroll={{ x: 1080 }}
          rowSelection={{
            selectedRowKeys: selectedIds,
            preserveSelectedRowKeys: true,
            onChange: (keys: Key[]) => setSelectedIds(keys.map(String)),
          }}
          pagination={{
            current: page,
            pageSize: PAGE_SIZE,
            total,
            showSizeChanger: false,
            showTotal: (count) => `${formatCount(count)} truyện`,
            onChange: setPage,
          }}
        />
      </Card>
      <StoryChaptersModal
        story={chaptersStory}
        open={chaptersStory != null}
        onClose={() => setChaptersStory(null)}
      />
    </Space>
  )
}
