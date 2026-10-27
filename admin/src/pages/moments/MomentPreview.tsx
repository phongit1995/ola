import type { CSSProperties } from 'react'
import { PlayCircleFilled } from '@ant-design/icons'
import type { AdminMoment } from '@/types'
import { MOMENT_TABLE_PREVIEW_WIDTH } from './constants'
import { overlayBoxStyle, overlayTextStyle, momentBackgroundCss, momentNoCoverLabel } from './utils'

interface MomentPreviewProps {
  moment: AdminMoment
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

function MomentMedia({ moment, playable }: { moment: AdminMoment; playable: boolean }) {
  if (moment.type === 'text') {
    return <div style={{ position: 'absolute', inset: 0, background: momentBackgroundCss(moment.background) }} />
  }
  if (moment.mediaPurged) {
    return <div style={NOTICE}>Media đã được dọn</div>
  }
  if (moment.type === 'image') {
    return moment.mediaUrl ? <img src={moment.mediaUrl} alt="" style={FILL} /> : null
  }
  if (playable && moment.mediaUrl) {
    return <video src={moment.mediaUrl} poster={moment.thumbUrl} controls playsInline style={FILL} />
  }
  if (moment.thumbUrl) {
    return <img src={moment.thumbUrl} alt="" style={FILL} />
  }
  return <div style={NOTICE}>{momentNoCoverLabel(moment)}</div>
}

export function MomentPreview({ moment, width, playable = false }: MomentPreviewProps) {
  const compact = width <= MOMENT_TABLE_PREVIEW_WIDTH
  const showPlayBadge = moment.type === 'video' && !playable && !moment.mediaPurged
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
      <MomentMedia moment={moment} playable={playable} />
      <div style={{ position: 'absolute', inset: 0, pointerEvents: 'none' }}>
        {moment.overlays.map((overlay) => (
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
