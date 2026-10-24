import type { CSSProperties } from 'react'
import { PlayCircleFilled } from '@ant-design/icons'
import type { AdminReel } from '@/types'
import { REEL_TABLE_PREVIEW_WIDTH } from './constants'
import { overlayBoxStyle, overlayTextStyle, reelBackgroundCss } from './utils'

interface ReelPreviewProps {
  reel: AdminReel
  width: number
  playable?: boolean
}

const FILL: CSSProperties = {
  position: 'absolute',
  inset: 0,
  width: '100%',
  height: '100%',
  objectFit: 'contain',
}

const NOTICE: CSSProperties = {
  position: 'absolute',
  inset: 0,
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  padding: '0 6%',
  textAlign: 'center',
  whiteSpace: 'normal',
  color: 'rgba(255, 255, 255, 0.75)',
  fontSize: 'max(9px, 5cqw)',
  lineHeight: 1.25,
}

function ReelMedia({ reel, playable }: { reel: AdminReel; playable: boolean }) {
  if (reel.type === 'text') {
    return <div style={{ position: 'absolute', inset: 0, background: reelBackgroundCss(reel.background) }} />
  }
  if (reel.mediaPurged) {
    return <div style={NOTICE}>Media đã được dọn</div>
  }
  if (reel.type === 'image') {
    return reel.mediaUrl ? <img src={reel.mediaUrl} alt="" style={FILL} /> : null
  }
  if (playable && reel.mediaUrl) {
    return <video src={reel.mediaUrl} poster={reel.thumbUrl} controls playsInline style={FILL} />
  }
  if (reel.thumbUrl) {
    return <img src={reel.thumbUrl} alt="" style={FILL} />
  }
  return <div style={NOTICE}>{reel.status === 'processing' ? 'Đang xử lý video' : 'Không có ảnh bìa'}</div>
}

export function ReelPreview({ reel, width, playable = false }: ReelPreviewProps) {
  const compact = width <= REEL_TABLE_PREVIEW_WIDTH
  const showPlayBadge = reel.type === 'video' && !playable && !reel.mediaPurged
  return (
    <div
      style={{
        position: 'relative',
        width,
        aspectRatio: '9 / 16',
        overflow: 'hidden',
        borderRadius: compact ? 6 : 12,
        background: '#000',
        containerType: 'inline-size',
        flexShrink: 0,
      }}
    >
      <ReelMedia reel={reel} playable={playable} />
      <div style={{ position: 'absolute', inset: 0, pointerEvents: 'none' }}>
        {reel.overlays.map((overlay) => (
          <div key={overlay.id} style={overlayBoxStyle(overlay)}>
            <span style={overlayTextStyle(overlay)}>{overlay.text}</span>
          </div>
        ))}
      </div>
      {showPlayBadge && (
        <PlayCircleFilled
          style={{
            position: 'absolute',
            right: 4,
            bottom: 4,
            color: 'rgba(255, 255, 255, 0.9)',
            fontSize: compact ? 14 : 28,
          }}
        />
      )}
    </div>
  )
}
