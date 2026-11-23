import { Alert, App, Button, Card, Checkbox, Form, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { errorMessage } from '@/lib/apiError'
import { cleanPlatformRules } from '@/lib/platformRules'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { CHECKIN_SECTION_LINKS } from '@/pages/shop/sections'
import type { CheckinSetting } from '@/types'
import { CHECKIN_TASK_CODES, CHECKIN_TASK_META } from './constants'
import { useCheckinMonths, useCheckinSetting, useSaveCheckinSetting } from './useCheckinQueries'
import { monthKey, monthLabel, vnNow } from './utils'

const CARD_STYLE = { maxWidth: 720 }

const RANDOM_TASK_OPTIONS = CHECKIN_TASK_CODES.map((code) => ({
  value: code,
  label: CHECKIN_TASK_META[code].costsKen ? `${CHECKIN_TASK_META[code].label} (tốn KEN)` : CHECKIN_TASK_META[code].label,
}))

function MissingMonthAlert() {
  const currentMonth = monthKey(vnNow())
  const months = useCheckinMonths()
  const item = (months.data ?? []).find((entry) => entry.month === currentMonth)
  if (!months.isSuccess || item?.publishedAt) return null
  return (
    <Alert
      type="error"
      showIcon
      style={{ marginBottom: 16 }}
      title={`${monthLabel(currentMonth)} ${item ? 'còn là nháp' : 'chưa có lịch'} nên điểm danh vẫn tắt dù bật ở đây. ${item ? 'Phát hành' : 'Tạo lịch'} ở tab Lịch tháng.`}
    />
  )
}

export function CheckinSettingsPage() {
  const { message } = App.useApp()
  const { data: current, isLoading, isError } = useCheckinSetting()
  const saveSetting = useSaveCheckinSetting()
  const title = <ShopSectionNav links={CHECKIN_SECTION_LINKS} />

  if (isLoading) {
    return (
      <Card title={title} style={CARD_STYLE}>
        <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
          <Spin />
        </div>
      </Card>
    )
  }

  if (isError || !current) {
    return (
      <Card title={title} style={CARD_STYLE}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  async function save(values: CheckinSetting) {
    try {
      await saveSetting.mutateAsync({
        enabled: values.enabled,
        platforms: cleanPlatformRules(values.platforms),
        popup: values.popup,
        requireEmailVerified: values.requireEmailVerified,
        randomTasks: values.randomTasks,
      })
      message.success('Đã lưu cài đặt điểm danh')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title={title} style={CARD_STYLE}>
      <MissingMonthAlert />
      <Typography.Paragraph type="secondary">
        Áp dụng cho mọi tháng. Chưa lưu lần nào thì hệ thống dùng giá trị mặc định đang hiển thị. Điểm danh chỉ chạy khi công tắc tổng bật,
        nền tảng bật và tháng hiện tại đã có lịch.
      </Typography.Paragraph>
      <Form<CheckinSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          label="Hiển thị theo nền tảng"
          extra="Tắt nền tảng nào thì nền tảng đó ẩn dòng Điểm danh, không hiện popup và server từ chối điểm danh từ nền tảng đó. So theo tên bản (1.0.0), không tính build."
        >
          <PlatformRulesTable name={['platforms']} />
        </Form.Item>
        <Form.Item
          name="enabled"
          label="Bật điểm danh"
          valuePropName="checked"
          extra="Công tắc tổng, mặc định tắt. Tắt thì mọi nền tảng ẩn điểm danh và server từ chối. Lịch tháng và lịch sử vẫn giữ nguyên."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="popup"
          label="Popup tự hiện khi mở app"
          valuePropName="checked"
          extra="Hiện lần đầu mở app trong ngày nếu chưa điểm danh. Đã điểm danh mà hộp còn chờ nhiệm vụ thì không hiện lại, chỉ có chấm đỏ."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="requireEmailVerified"
          label="Phải xác thực email mới điểm danh được"
          valuePropName="checked"
          extra="Bật thì tài khoản chưa xác thực email thấy nút Xác thực email thay cho nút Điểm danh, ô không đi tiếp. Chỉ xét lúc bấm Điểm danh."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="randomTasks"
          label="Nhiệm vụ cho ô đặt Ngẫu nhiên"
          rules={[{ required: true, type: 'array', min: 1, message: 'Chọn ít nhất một nhiệm vụ' }]}
          extra="Lúc điểm danh ô có nhiệm vụ Ngẫu nhiên, server bốc một nhiệm vụ trong danh sách này cho từng người. Mặc định bỏ hai nhiệm vụ tốn KEN."
        >
          <Checkbox.Group options={RANDOM_TASK_OPTIONS} style={{ display: 'grid', gridTemplateColumns: 'repeat(2, minmax(0, 1fr))', gap: 8 }} />
        </Form.Item>
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={saveSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}
