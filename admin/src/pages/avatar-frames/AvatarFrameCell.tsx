import { Space, Tag, Typography } from 'antd'
import { avatarFrameName, avatarFrameUrl } from './utils'

export function AvatarFrameImage({ frameId, size }: { frameId: string; size: number }) {
  const url = avatarFrameUrl(frameId)
  const box = { width: size, height: size, flex: 'none' as const }
  if (!url) {
    return (
      <div
        style={{
          ...box,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          border: '1px dashed #d9d9d9',
          borderRadius: 8,
          color: '#bfbfbf',
          fontSize: 11,
        }}
      >
        ?
      </div>
    )
  }
  return (
    <img
      src={url}
      alt={avatarFrameName(frameId)}
      loading="lazy"
      width={size}
      height={size}
      style={{ ...box, objectFit: 'contain' }}
    />
  )
}

export function AvatarFrameCell({ frameId, size = 48 }: { frameId: string; size?: number }) {
  return (
    <Space>
      <AvatarFrameImage frameId={frameId} size={size} />
      <Space orientation="vertical" size={0}>
        <Typography.Text strong>{avatarFrameName(frameId)}</Typography.Text>
        <Tag style={{ marginInlineEnd: 0 }}>#{frameId}</Tag>
      </Space>
    </Space>
  )
}
