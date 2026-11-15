import { App, Button, Card, Col, Form, InputNumber, Row, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import type { SocialLimitSetting, SocialLimitTier } from '@/types'
import {
  DEFAULT_SOCIAL_LIMIT_SETTING,
  SOCIAL_DAILY_MAX,
  SOCIAL_FRIENDS_MAX,
  SOCIAL_LIMIT_SETTING_KEY,
} from './constants'
import { socialLimitSetting } from './socialLimit'

type TierKey = 'normal' | 'vip'

const TIER_FIELDS: { name: keyof SocialLimitTier; label: string; suffix: string; min: number; max: number }[] = [
  { name: 'newChatsPerDay', label: 'Nhắn tin người mới mỗi ngày', suffix: 'người', min: 0, max: SOCIAL_DAILY_MAX },
  { name: 'friendRequestsPerDay', label: 'Lời mời kết bạn mỗi ngày', suffix: 'lời mời', min: 0, max: SOCIAL_DAILY_MAX },
  { name: 'maxFriends', label: 'Số bạn bè tối đa', suffix: 'bạn', min: 1, max: SOCIAL_FRIENDS_MAX },
  { name: 'maxPendingRequests', label: 'Lời mời đang chờ tối đa', suffix: 'lời mời', min: 1, max: SOCIAL_FRIENDS_MAX },
]

function TierFields({ tier, title }: { tier: TierKey; title: string }) {
  return (
    <Card size="small" title={title}>
      {TIER_FIELDS.map((field) => (
        <Form.Item
          key={field.name}
          name={[tier, field.name]}
          label={field.label}
          rules={[{ required: true, message: 'Nhập số' }]}
        >
          <InputNumber<number>
            min={field.min}
            max={field.max}
            precision={0}
            suffix={field.suffix}
            style={{ width: '100%' }}
          />
        </Form.Item>
      ))}
    </Card>
  )
}

export function SocialLimitSettingsTab() {
  const { message, modal } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
        <Spin />
      </div>
    )
  }

  if (isError) {
    return (
      <Typography.Text type="danger">
        Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
      </Typography.Text>
    )
  }

  const current = socialLimitSetting(settings)

  async function persist(values: SocialLimitSetting) {
    try {
      await putSetting.mutateAsync({
        key: SOCIAL_LIMIT_SETTING_KEY,
        value: { enabled: values.enabled, normal: { ...values.normal }, vip: { ...values.vip } },
      })
      message.success('Đã lưu giới hạn kết bạn & nhắn tin')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: SocialLimitSetting) {
    const lowerFriends =
      values.normal.maxFriends < current.normal.maxFriends || values.vip.maxFriends < current.vip.maxFriends
    if (lowerFriends) {
      modal.confirm({
        title: 'Giảm số bạn bè tối đa?',
        content:
          'Người đang có nhiều bạn hơn mức mới vẫn giữ nguyên bạn bè, nhưng sẽ không kết bạn thêm được cho đến khi xuống dưới mức này.',
        okText: 'Lưu',
        cancelText: 'Huỷ',
        onOk: () => persist(values),
      })
      return
    }
    void persist(values)
  }

  const defaults = DEFAULT_SOCIAL_LIMIT_SETTING
  return (
    <Card style={{ maxWidth: 820 }}>
      <Typography.Paragraph type="secondary">
        "Người mới" là người chưa phải bạn bè mà mình nhắn tin lần đầu. Nhắn bạn bè, trả lời người nhắn mình trước, hoặc
        nhắn lại người đã từng trò chuyện thì không tính. Mỗi người chỉ tính một lượt trong ngày, kể cả nhắn lại hay gửi
        lại lời mời. Lượt đếm theo ngày giờ Việt Nam. Tặng quà cho người lạ không bị tính. Hết lượt thì app báo cho người
        dùng và gợi ý nâng VIP. Chưa lưu lần nào thì dùng mặc định: người thường {defaults.normal.newChatsPerDay} người
        mới và {defaults.normal.friendRequestsPerDay} lời mời mỗi ngày, VIP {defaults.vip.newChatsPerDay} và{' '}
        {defaults.vip.friendRequestsPerDay}. Lưu xong máy chủ áp dụng trong vòng 1 phút.
      </Typography.Paragraph>
      <Form<SocialLimitSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          name="enabled"
          label="Bật giới hạn theo ngày"
          valuePropName="checked"
          extra="Tắt thì không giới hạn số người mới và lời mời mỗi ngày. Số bạn bè tối đa và lời mời đang chờ vẫn luôn áp dụng."
        >
          <Switch />
        </Form.Item>
        <Row gutter={16}>
          <Col xs={24} md={12}>
            <TierFields tier="normal" title="Người thường" />
          </Col>
          <Col xs={24} md={12}>
            <TierFields tier="vip" title="VIP" />
          </Col>
        </Row>
        <Button
          type="primary"
          htmlType="submit"
          icon={<SaveOutlined />}
          loading={putSetting.isPending}
          style={{ marginTop: 16 }}
        >
          Lưu cấu hình
        </Button>
      </Form>
    </Card>
  )
}
