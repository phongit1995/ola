import { App, Button, Card, Form, InputNumber, Select, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import {
  DEFAULT_GIFT_SETTING,
  GIFT_NOTE_MAX_LENGTH_LIMIT,
  GIFT_QUANTITY_MAX_LIMIT,
  GIFT_QUANTITY_OPTIONS_MAX,
  GIFT_SETTING_KEY,
} from './constants'
import { normalizeQuantityOptions } from './utils'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import { kenNumberInputProps } from '@/lib/format'
import type { GiftSetting } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { GIFT_SECTION_LINKS } from '@/pages/shop/sections'

export function GiftSettingsPage() {
  const { message } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

  if (isLoading) {
    return (
      <Card title={<ShopSectionNav links={GIFT_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
        <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
          <Spin />
        </div>
      </Card>
    )
  }

  if (isError) {
    return (
      <Card title={<ShopSectionNav links={GIFT_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  const current = settingValue(settings, GIFT_SETTING_KEY, DEFAULT_GIFT_SETTING)

  async function save(values: GiftSetting) {
    const payload: GiftSetting = {
      ...values,
      quantityOptions: normalizeQuantityOptions(values.quantityOptions),
    }
    if (payload.quantityOptions.length === 0) {
      message.error('Cần ít nhất một lựa chọn số lượng')
      return
    }
    if (payload.quantityOptions.some((q) => q > payload.quantityMax)) {
      message.error('Lựa chọn số lượng không được lớn hơn số lượng tối đa')
      return
    }
    try {
      await putSetting.mutateAsync({ key: GIFT_SETTING_KEY, value: { ...payload } })
      message.success('Đã lưu cài đặt tặng quà')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title={<ShopSectionNav links={GIFT_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Áp dụng cho chat 1-1 và trang cá nhân. Chưa lưu lần nào thì hệ thống dùng đúng giá trị mặc
        định đang hiển thị. Mỗi người tặng tối đa 20 lần/phút (cố định ở server).
      </Typography.Paragraph>
      <Form<GiftSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          name="enabled"
          label="Bật tặng quà"
          valuePropName="checked"
          extra="Tắt thì app ẩn nút tặng quà và server từ chối mọi lượt tặng. Tường quà và bảng xếp hạng vẫn xem được."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="quantityOptions"
          label="Nút chọn nhanh số lượng"
          extra={`Tối đa ${GIFT_QUANTITY_OPTIONS_MAX} lựa chọn, tự sắp tăng dần. Gõ số rồi Enter.`}
          rules={[{ required: true, message: 'Cần ít nhất một lựa chọn' }]}
        >
          <Select mode="tags" tokenSeparators={[',', ' ']} maxCount={GIFT_QUANTITY_OPTIONS_MAX} />
        </Form.Item>
        <Form.Item
          name="quantityMax"
          label="Số lượng tối đa mỗi lần tặng"
          rules={[{ required: true, message: 'Nhập số lượng tối đa' }]}
        >
          <InputNumber min={1} max={GIFT_QUANTITY_MAX_LIMIT} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="noteMaxLength"
          label="Độ dài lời nhắn tối đa (ký tự)"
          extra="Đặt 0 để tắt ô lời nhắn."
          rules={[{ required: true, message: 'Nhập độ dài lời nhắn' }]}
        >
          <InputNumber min={0} max={GIFT_NOTE_MAX_LENGTH_LIMIT} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="confirmOverKen"
          label="Hỏi xác nhận khi tổng từ (KEN)"
          extra="Lượt tặng có tổng giá từ mức này trở lên phải bấm xác nhận thêm một lần. Đặt 0 để luôn hỏi."
          rules={[{ required: true, message: 'Nhập ngưỡng xác nhận' }]}
        >
          <InputNumber min={0} precision={0} style={{ width: '100%' }} {...kenNumberInputProps} />
        </Form.Item>
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}
