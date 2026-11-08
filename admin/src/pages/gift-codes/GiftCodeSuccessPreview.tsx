import { Col, Row, Typography } from 'antd'
import { GiftOutlined } from '@ant-design/icons'
import type { GiftCodeReward } from '@/types'
import { GiftCodeRewardTags } from './GiftCodeBadges'

const BOX_STYLE = { border: '1px dashed #c9d1db', borderRadius: 12, padding: 16, background: '#fafbfc' }
const DIALOG_STYLE = {
  maxWidth: 280,
  margin: '0 auto',
  background: '#fff',
  borderRadius: 14,
  boxShadow: '0 6px 24px rgba(17,35,26,.14)',
  padding: '20px 18px 14px',
  textAlign: 'center' as const,
}
const OK_STYLE = { background: '#5b8c2a', color: '#fff', borderRadius: 8, padding: 8, fontWeight: 600, marginTop: 14 }
const NOTIF_STYLE = {
  display: 'flex',
  gap: 10,
  alignItems: 'flex-start',
  background: '#fff',
  borderRadius: 10,
  padding: '10px 12px',
  boxShadow: '0 2px 10px rgba(17,35,26,.08)',
  fontSize: 13,
}
const DOT_STYLE = {
  width: 32,
  height: 32,
  borderRadius: '50%',
  background: '#5b8c2a',
  color: '#fff',
  display: 'inline-flex',
  alignItems: 'center',
  justifyContent: 'center',
  flex: 'none',
}

export function GiftCodeSuccessPreview({
  message,
  rewards,
  notify,
}: {
  message: string
  rewards: GiftCodeReward[]
  notify: boolean
}) {
  return (
    <div style={BOX_STYLE}>
      <Row gutter={[16, 16]} align="middle">
        <Col xs={24} md={notify ? 13 : 24}>
          <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12, marginBottom: 8, textAlign: 'center' }}>
            Người dùng thấy sau khi nhập mã
          </Typography.Text>
          <div style={DIALOG_STYLE}>
            <div style={{ fontSize: 34 }}>🎁</div>
            <Typography.Title level={5} style={{ margin: '8px 0 6px' }}>
              Nhận quà thành công
            </Typography.Title>
            <Typography.Paragraph style={{ fontSize: 13, marginBottom: 12 }}>{message}</Typography.Paragraph>
            <GiftCodeRewardTags rewards={rewards} />
            <div style={OK_STYLE}>Tuyệt vời</div>
          </div>
        </Col>
        {notify && (
          <Col xs={24} md={11}>
            <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12, marginBottom: 8 }}>
              Và trong thông báo hệ thống
            </Typography.Text>
            <div style={NOTIF_STYLE}>
              <span style={DOT_STYLE}>
                <GiftOutlined />
              </span>
              <div>
                <Typography.Text strong>Mã quà tặng</Typography.Text>
                <div>{message}</div>
                <Typography.Text type="secondary" style={{ fontSize: 11 }}>
                  Vừa xong
                </Typography.Text>
              </div>
            </div>
          </Col>
        )}
      </Row>
    </div>
  )
}
