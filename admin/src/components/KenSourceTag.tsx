import { Tag } from 'antd'

export function KenSourceTag({ source }: { source: string }) {
  return source === 'auto' ? <Tag color="blue">Auto</Tag> : <Tag>Tay</Tag>
}
