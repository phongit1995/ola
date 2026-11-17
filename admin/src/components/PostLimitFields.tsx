import { Col, Form, InputNumber, Row } from 'antd'
import { POST_LIMIT_DAILY_MAX } from '@/lib/constants'

const TIERS = [
  { name: 'normalPerDay', label: 'Người chưa VIP' },
  { name: 'vipPerDay', label: 'Người có VIP' },
] as const

export function PostLimitFields({ unit }: { unit: string }) {
  return (
    <Row gutter={16}>
      {TIERS.map((tier) => (
        <Col key={tier.name} xs={24} md={12}>
          <Form.Item
            name={tier.name}
            label={tier.label}
            rules={[{ required: true, message: 'Nhập số lần' }]}
            extra="0 là không giới hạn"
          >
            <InputNumber<number>
              min={0}
              max={POST_LIMIT_DAILY_MAX}
              precision={0}
              suffix={`${unit}/ngày`}
              style={{ width: '100%' }}
            />
          </Form.Item>
        </Col>
      ))}
    </Row>
  )
}
