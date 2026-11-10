import { Button, Image, Space, Switch, Tag, Typography, type TableColumnsType } from 'antd'
import { DeleteOutlined, MessageOutlined, UnorderedListOutlined } from '@ant-design/icons'
import type { StoryKind } from '@ola/shared/types'
import { formatCount, formatDate } from '@/lib/format'
import type { AdminStory } from '@/types'
import { COVER_HEIGHT, COVER_WIDTH, KIND_LABEL, STORY_STATUS_TAG } from './constants'
import { sourceLabel } from './utils'

export interface StoryColumnActions {
  hidingId: string | undefined
  onToggleVisible: (story: AdminStory, visible: boolean) => void
  onOpenChapters: (story: AdminStory) => void
  onOpenComments: (story: AdminStory) => void
  onRemove: (story: AdminStory) => void
}

export function storyColumns(actions: StoryColumnActions): TableColumnsType<AdminStory> {
  return [
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
          <Tag color={STORY_STATUS_TAG[story.status].color}>{STORY_STATUS_TAG[story.status].label}</Tag>
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
          loading={actions.hidingId === story.id}
          onChange={(value) => actions.onToggleVisible(story, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 250,
      render: (_, story) => (
        <Space>
          <Button
            size="small"
            icon={<UnorderedListOutlined />}
            onClick={() => actions.onOpenChapters(story)}
          >
            Chương
          </Button>
          <Button
            size="small"
            icon={<MessageOutlined />}
            onClick={() => actions.onOpenComments(story)}
          >
            Bình luận ({formatCount(story.commentCount ?? 0)})
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => actions.onRemove(story)}
          />
        </Space>
      ),
    },
  ]
}
