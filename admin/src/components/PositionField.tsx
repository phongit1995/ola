import type { CSSProperties } from 'react'
import { Form, InputNumber } from 'antd'

interface PositionFieldProps {
  name?: string
  style?: CSSProperties
}

export function PositionField({ name = 'sortOrder', style }: PositionFieldProps) {
  return (
    <Form.Item
      name={name}
      label="Vị trí (1 là đầu tiên)"
      extra="Các mục từ vị trí này trở xuống tự lùi 1 bậc."
      style={style}
    >
      <InputNumber min={1} precision={0} style={{ width: '100%' }} />
    </Form.Item>
  )
}
