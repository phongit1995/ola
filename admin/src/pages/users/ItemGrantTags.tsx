import { Tag, Tooltip } from 'antd'
import { ClockCircleOutlined, LockFilled } from '@ant-design/icons'
import { formatDateTime } from '@/lib/format'
import { formatShortExpiry } from './utils'

interface ItemGrantTagsProps {
  locked: boolean
  expiresAt?: string | null
  expired?: boolean
}

export function ItemGrantTags({ locked, expiresAt, expired }: ItemGrantTagsProps) {
  return (
    <>
      {locked && (
        <Tag icon={<LockFilled />} color="purple" style={{ margin: 0 }}>
          Khoá
        </Tag>
      )}
      {expiresAt && (
        <Tooltip title={`Hết hạn ${formatDateTime(expiresAt)}`}>
          {expired ? (
            <Tag color="red" style={{ margin: 0 }}>
              Đã hết hạn
            </Tag>
          ) : (
            <Tag icon={<ClockCircleOutlined />} color="blue" style={{ margin: 0 }}>
              {formatShortExpiry(expiresAt)}
            </Tag>
          )}
        </Tooltip>
      )}
    </>
  )
}
