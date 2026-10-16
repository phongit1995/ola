import { Typography } from 'antd'
import { formatCount } from '@/lib/format'

export function NetText({ value }: { value: number }) {
  if (value > 0) return <Typography.Text type="success">+{formatCount(value)}</Typography.Text>
  if (value < 0) return <Typography.Text type="danger">{formatCount(value)}</Typography.Text>
  return <Typography.Text>0</Typography.Text>
}
