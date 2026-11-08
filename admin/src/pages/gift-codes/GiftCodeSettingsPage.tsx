import { App, Button, Card, Form, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { GiftCodeSetting } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { GIFT_CODE_SECTION_LINKS } from '@/pages/shop/sections'
import { DEFAULT_GIFT_CODE_SETTING, GIFT_CODE_SETTING_KEY } from './constants'

const CARD_STYLE = { maxWidth: 680 }

export function GiftCodeSettingsPage() {
  const { message } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()
  const title = <ShopSectionNav links={GIFT_CODE_SECTION_LINKS} />

  if (isLoading) {
    return (
      <Card title={title} style={CARD_STYLE}>
        <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
          <Spin />
        </div>
      </Card>
    )
  }

  if (isError) {
    return (
      <Card title={title} style={CARD_STYLE}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  const current = settingValue(settings, GIFT_CODE_SETTING_KEY, DEFAULT_GIFT_CODE_SETTING)

  async function save(values: GiftCodeSetting) {
    try {
      await putSetting.mutateAsync({
        key: GIFT_CODE_SETTING_KEY,
        value: {
          enabled: values.enabled,
          platforms: cleanPlatformRules(values.platforms),
          requireEmailVerified: values.requireEmailVerified,
        },
      })
      message.success('Đã lưu cài đặt mã quà tặng')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title={title} style={CARD_STYLE}>
      <Typography.Paragraph type="secondary">
        Áp dụng cho mọi đợt mã. Chưa lưu lần nào thì hệ thống dùng giá trị mặc định đang hiển thị.
      </Typography.Paragraph>
      <Form<GiftCodeSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          label="Hiển thị theo nền tảng"
          extra="Tắt nền tảng nào thì nền tảng đó ẩn mục Nhập mã quà tặng và server từ chối lượt nhập từ nền tảng đó. So theo tên bản (1.0.0), không tính build."
        >
          <PlatformRulesTable name={['platforms']} />
        </Form.Item>
        <Form.Item
          name="enabled"
          label="Bật mã quà tặng"
          valuePropName="checked"
          extra="Công tắc tổng: tắt thì mọi nền tảng ẩn mục Nhập mã quà tặng và server từ chối mọi lượt nhập mã. Các đợt mã vẫn giữ nguyên."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="requireEmailVerified"
          label="Bắt buộc xác thực email"
          valuePropName="checked"
          extra="Bật thì tài khoản chưa xác thực email nhập đúng mã sẽ được báo cần xác thực email trước, chưa nhận được quà. Lượt đó ghi vào Nhập lỗi với lý do Chưa xác thực email."
        >
          <Switch />
        </Form.Item>
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}
