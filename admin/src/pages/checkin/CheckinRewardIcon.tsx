import { Tooltip } from 'antd'
import { CrownOutlined, DollarOutlined, QuestionOutlined, SoundOutlined } from '@ant-design/icons'
import { isRewardItemIncomplete, rewardItemImage, rewardItemText } from '@/lib/rewardItem'
import type { CheckinRewardItem } from '@/types'

const BOX_STYLE = { display: 'inline-flex', alignItems: 'center', justifyContent: 'center', borderRadius: 6, flex: 'none' } as const

export function CheckinRewardIcon({ item, size = 22 }: { item: CheckinRewardItem; size?: number }) {
  const image = rewardItemImage(item)
  const style = { ...BOX_STYLE, width: size, height: size, fontSize: Math.round(size * 0.7) }
  let content
  if (image) {
    content = <img src={image} alt="" width={size} height={size} loading="lazy" style={{ objectFit: 'contain' }} />
  } else if (isRewardItemIncomplete(item)) {
    content = (
      <span style={{ ...style, border: '1px dashed #ff4d4f', color: '#ff4d4f' }}>
        <QuestionOutlined />
      </span>
    )
  } else if (item.type === 'vip_days') {
    content = (
      <span style={{ ...style, background: '#fff7e6', color: '#d48806' }}>
        <CrownOutlined />
      </span>
    )
  } else if (item.type === 'ken') {
    content = (
      <span style={{ ...style, background: '#f6ffed', color: '#389e0d' }}>
        <DollarOutlined />
      </span>
    )
  } else {
    content = (
      <span style={{ ...style, background: '#e6f4ff', color: '#1677ff' }}>
        <SoundOutlined />
      </span>
    )
  }
  return <Tooltip title={rewardItemText(item)}>{content}</Tooltip>
}
