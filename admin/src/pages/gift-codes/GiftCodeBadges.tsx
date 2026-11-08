import { Badge, Space, Tag } from 'antd'
import { CrownOutlined } from '@ant-design/icons'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import type { GiftCodeKind, GiftCodeReward, GiftCodeStatus } from '@/types'
import { GIFT_CODE_KIND_META, GIFT_CODE_STATUS_META } from './constants'

const ICON_STYLE = { width: 20, height: 20, objectFit: 'contain' as const, verticalAlign: 'middle', marginRight: 4 }

export function GiftCodeRewardTags({ rewards }: { rewards: GiftCodeReward[] }) {
  return (
    <Space size={4} wrap>
      {rewards.map((reward, index) =>
        reward.type === 'vip_days' ? (
          <Tag key={index} color="gold" icon={<CrownOutlined />} style={{ marginInlineEnd: 0 }}>
            {reward.days} ngày VIP
          </Tag>
        ) : (
          <Tag key={index} color="purple" style={{ marginInlineEnd: 0 }}>
            <img src={vipIconUrl(reward.vipIconId ?? 0)} alt="" style={ICON_STYLE} />
            {vipName(reward.vipIconId ?? 0)}
          </Tag>
        ),
      )}
    </Space>
  )
}

export function GiftCodeStatusBadge({ status }: { status: GiftCodeStatus }) {
  const meta = GIFT_CODE_STATUS_META[status]
  return <Badge status={meta.badge} color={meta.color} text={meta.label} />
}

export function GiftCodeKindTag({ kind }: { kind: GiftCodeKind }) {
  const meta = GIFT_CODE_KIND_META[kind]
  return (
    <Tag color={meta.color} style={{ marginInlineEnd: 0 }}>
      {meta.label}
    </Tag>
  )
}
