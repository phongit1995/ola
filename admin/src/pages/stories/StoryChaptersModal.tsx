import { useState } from 'react'
import {
  Alert,
  App,
  Button,
  Drawer,
  Empty,
  Modal,
  Skeleton,
  Space,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { CloudDownloadOutlined, EyeOutlined, ReloadOutlined } from '@ant-design/icons'
import {
  useFetchMissingStoryContent,
  useRefetchStoryChapter,
  useRefreshStoryLists,
  useStoryChapter,
  useStoryChapters,
} from '@/hooks/useStories'
import { formatDate, formatDateTime } from '@/lib/format'
import { ApiError } from '@/lib/apiError'
import type { AdminStory, AdminStoryChapter } from '@/types'

const CHAPTER_PAGE_SIZE = 20
const POLL_MS_PER_CHAPTER = 2000
const POLL_GRACE_MS = 30000

interface StoryChaptersModalProps {
  story: AdminStory | null
  open: boolean
  onClose: () => void
}

function contentParagraphs(content: string): string[] {
  return content
    .split(/\n\s*\n/)
    .map((paragraph) => paragraph.trim())
    .filter((paragraph) => paragraph.length > 0)
}

function errorText(error: unknown): string {
  return error instanceof ApiError ? error.message : 'Lỗi không xác định, thử lại sau'
}

export function StoryChaptersModal({ story, open, onClose }: StoryChaptersModalProps) {
  const { message } = App.useApp()
  const storyId = open && story ? story.id : null
  const [pollUntil, setPollUntil] = useState(0)
  const [previewPosition, setPreviewPosition] = useState<number | null>(null)
  const [refetchingPosition, setRefetchingPosition] = useState<number | null>(null)

  const {
    data: chapters,
    isLoading,
    isFetching,
    isError,
    error,
    refetch,
  } = useStoryChapters(storyId, pollUntil)
  const {
    data: preview,
    isFetching: previewLoading,
    isError: previewFailed,
    error: previewError,
    refetch: refetchPreview,
  } = useStoryChapter(storyId, previewPosition)
  const fetchMissing = useFetchMissingStoryContent()
  const refetchChapter = useRefetchStoryChapter(storyId)
  const refreshLists = useRefreshStoryLists()

  const items = chapters ?? []
  const missing = items.filter((chapter) => !chapter.hasContent).length
  const loadFailed = isError && chapters === undefined

  function close() {
    setPreviewPosition(null)
    setPollUntil(0)
    refreshLists()
    onClose()
  }

  async function startFetchMissing() {
    if (!storyId) return
    try {
      const result = await fetchMissing.mutateAsync(storyId)
      if (result.queued === 0) {
        message.info('Tất cả chương đã có nội dung')
        return
      }
      setPollUntil(Date.now() + result.queued * POLL_MS_PER_CHAPTER + POLL_GRACE_MS)
      message.success(`Đang lấy ${result.queued} chương ở nền, danh sách tự cập nhật`)
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Không bắt đầu được')
    }
  }

  async function refetchContent(position: number) {
    setRefetchingPosition(position)
    try {
      await refetchChapter.mutateAsync(position)
      message.success(`Đã lấy lại nội dung chương ${position}`)
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lấy nội dung thất bại')
    } finally {
      setRefetchingPosition(null)
    }
  }

  const columns: TableColumnsType<AdminStoryChapter> = [
    { title: '#', dataIndex: 'position', width: 60 },
    {
      title: 'Tên chương',
      dataIndex: 'title',
      render: (title: string, chapter) => (
        <Typography.Link href={chapter.sourceUrl} target="_blank" rel="noreferrer">
          {title}
        </Typography.Link>
      ),
    },
    {
      title: 'Số chữ',
      dataIndex: 'wordCount',
      width: 90,
      render: (value: number, chapter) =>
        chapter.hasContent ? value.toLocaleString('vi-VN') : '—',
    },
    {
      title: 'Ngày đăng',
      dataIndex: 'publishedAt',
      width: 120,
      render: (value: string | null) => formatDate(value),
    },
    {
      title: 'Nội dung',
      dataIndex: 'hasContent',
      width: 160,
      render: (hasContent: boolean, chapter) =>
        hasContent ? (
          <Space orientation="vertical" size={0}>
            <Tag color="green">Đã có</Tag>
            <Typography.Text type="secondary" style={{ fontSize: 12 }}>
              {formatDateTime(chapter.crawledAt)}
            </Typography.Text>
          </Space>
        ) : (
          <Tag>Chưa có</Tag>
        ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 190,
      render: (_, chapter) => (
        <Space>
          <Button
            size="small"
            icon={<EyeOutlined />}
            onClick={() => setPreviewPosition(chapter.position)}
          >
            Xem
          </Button>
          <Button
            size="small"
            icon={<ReloadOutlined />}
            loading={refetchingPosition === chapter.position}
            disabled={refetchingPosition != null && refetchingPosition !== chapter.position}
            onClick={() => void refetchContent(chapter.position)}
          >
            {chapter.hasContent ? 'Lấy lại' : 'Lấy'}
          </Button>
        </Space>
      ),
    },
  ]

  return (
    <Modal
      open={open}
      onCancel={close}
      footer={null}
      width={960}
      title={story ? `Chương — ${story.title}` : 'Chương'}
      destroyOnHidden
    >
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
        <Typography.Text type="secondary">
          {loadFailed
            ? 'Chưa tải được danh sách chương.'
            : `${items.length - missing}/${items.length} chương đã có nội dung. Chương chưa có nội dung sẽ được lấy khi người dùng mở.`}
        </Typography.Text>
        <Space>
          <Button icon={<ReloadOutlined />} loading={isFetching} onClick={() => void refetch()} />
          <Button
            type="primary"
            icon={<CloudDownloadOutlined />}
            disabled={loadFailed || missing === 0}
            loading={fetchMissing.isPending}
            onClick={() => void startFetchMissing()}
          >
            Lấy nội dung còn thiếu ({missing})
          </Button>
        </Space>
      </div>
      {isError && (
        <Alert
          type={loadFailed ? 'error' : 'warning'}
          showIcon
          style={{ marginBottom: 12 }}
          title={
            loadFailed
              ? 'Không tải được danh sách chương'
              : 'Không tải lại được danh sách chương, đang hiện dữ liệu lần trước'
          }
          description={errorText(error)}
          action={
            <Button size="small" loading={isFetching} onClick={() => void refetch()}>
              Thử lại
            </Button>
          }
        />
      )}
      {!loadFailed && (
        <Table<AdminStoryChapter>
          rowKey="id"
          size="small"
          columns={columns}
          dataSource={items}
          loading={isLoading}
          scroll={{ x: 820 }}
          pagination={{ pageSize: CHAPTER_PAGE_SIZE, showSizeChanger: false }}
        />
      )}
      <Drawer
        open={previewPosition != null}
        onClose={() => setPreviewPosition(null)}
        size={640}
        title={preview?.title ?? 'Nội dung chương'}
        extra={
          previewPosition != null && (
            <Button
              icon={<ReloadOutlined />}
              loading={refetchingPosition === previewPosition}
              onClick={() => void refetchContent(previewPosition)}
            >
              Lấy lại từ nguồn
            </Button>
          )
        }
      >
        {previewLoading && !preview ? (
          <Skeleton active paragraph={{ rows: 8 }} />
        ) : previewFailed && !preview ? (
          <Alert
            type="error"
            showIcon
            title="Không tải được chương"
            description={errorText(previewError)}
            action={
              <Button size="small" onClick={() => void refetchPreview()}>
                Thử lại
              </Button>
            }
          />
        ) : preview?.hasContent ? (
          <div style={{ fontSize: 15, lineHeight: 1.7 }}>
            {contentParagraphs(preview.content).map((paragraph, index) => (
              <p key={index}>{paragraph}</p>
            ))}
          </div>
        ) : (
          <Empty description="Chương chưa có nội dung. Bấm “Lấy lại từ nguồn” để lấy ngay." />
        )}
      </Drawer>
    </Modal>
  )
}
