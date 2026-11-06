import { App, Button, Card, Form, InputNumber, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import { kenNumberInputProps } from '@/lib/format'
import type { MegaphoneSetting } from '@/types'
import {
  DEFAULT_MEGAPHONE_SETTING,
  MEGAPHONE_COOLDOWN_SECONDS_MAX,
  MEGAPHONE_DAILY_LIMIT_MAX,
  MEGAPHONE_DISPLAY_SECONDS_MAX,
  MEGAPHONE_DISPLAY_SECONDS_MIN,
  MEGAPHONE_KEN_PRICE_MAX,
  MEGAPHONE_MAX_LENGTH_LIMIT,
  MEGAPHONE_MAX_QUEUE_SECONDS_MAX,
  MEGAPHONE_SEND_RATE_PER_MINUTE,
  MEGAPHONE_SETTING_KEY,
} from './constants'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { MEGAPHONE_SECTION_LINKS } from '@/pages/shop/sections'

export function MegaphoneSettingsPage() {
  const { message } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

  if (isLoading) {
    return (
      <Card title={<ShopSectionNav links={MEGAPHONE_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
        <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
          <Spin />
        </div>
      </Card>
    )
  }

  if (isError) {
    return (
      <Card title={<ShopSectionNav links={MEGAPHONE_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  const current = settingValue(settings, MEGAPHONE_SETTING_KEY, DEFAULT_MEGAPHONE_SETTING)

  async function save(values: MegaphoneSetting) {
    if (values.maxQueueSeconds < values.displaySeconds) {
      message.error('Hàng chờ tối đa phải dài hơn thời gian hiện một loa')
      return
    }
    try {
      await putSetting.mutateAsync({ key: MEGAPHONE_SETTING_KEY, value: { ...values } })
      message.success('Đã lưu cài đặt loa')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title={<ShopSectionNav links={MEGAPHONE_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Loa hiện dưới header tab Chat, tab Phòng chat và trong phòng chat. Chưa lưu lần nào thì hệ thống dùng đúng
        giá trị mặc định đang hiển thị. Mỗi người gọi phát loa tối đa {MEGAPHONE_SEND_RATE_PER_MINUTE} lần/phút (cố
        định ở server).
      </Typography.Paragraph>
      <Form<MegaphoneSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          name="enabled"
          label="Bật loa"
          valuePropName="checked"
          extra="Tắt thì server từ chối mọi lượt phát mới. Loa đã phát vẫn chạy hết lượt và vẫn xem lại được."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="kenPrice"
          label="Giá mỗi lần phát (KEN)"
          extra="KEN bị trừ hẳn, không chuyển cho ai. Đặt 0 để phát miễn phí."
          rules={[{ required: true, message: 'Nhập giá' }]}
        >
          <InputNumber
            min={0}
            max={MEGAPHONE_KEN_PRICE_MAX}
            precision={0}
            style={{ width: '100%' }}
            {...kenNumberInputProps}
          />
        </Form.Item>
        <Form.Item
          name="maxLength"
          label="Số ký tự tối đa"
          extra="Emoji tính là 1 ký tự."
          rules={[{ required: true, message: 'Nhập số ký tự tối đa' }]}
        >
          <InputNumber min={1} max={MEGAPHONE_MAX_LENGTH_LIMIT} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="displaySeconds"
          label="Thời gian hiện mỗi loa (giây)"
          rules={[{ required: true, message: 'Nhập thời gian hiện' }]}
        >
          <InputNumber
            min={MEGAPHONE_DISPLAY_SECONDS_MIN}
            max={MEGAPHONE_DISPLAY_SECONDS_MAX}
            precision={0}
            style={{ width: '100%' }}
          />
        </Form.Item>
        <Form.Item
          name="cooldownSeconds"
          label="Thời gian chờ giữa 2 lần phát của một người (giây)"
          extra="Đặt 0 để không giới hạn."
          rules={[{ required: true, message: 'Nhập thời gian chờ' }]}
        >
          <InputNumber min={0} max={MEGAPHONE_COOLDOWN_SECONDS_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="dailyLimit"
          label="Số loa tối đa mỗi người mỗi ngày"
          extra="Tính theo ngày giờ Việt Nam."
          rules={[{ required: true, message: 'Nhập số loa mỗi ngày' }]}
        >
          <InputNumber min={1} max={MEGAPHONE_DAILY_LIMIT_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="maxQueueSeconds"
          label="Hàng chờ tối đa (giây)"
          extra="Loa xếp hàng phát lần lượt. Loa mới phải chờ lâu hơn mức này thì bị từ chối và không trừ KEN."
          rules={[{ required: true, message: 'Nhập hàng chờ tối đa' }]}
        >
          <InputNumber min={1} max={MEGAPHONE_MAX_QUEUE_SECONDS_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}
