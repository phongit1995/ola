import { App, Button, Card, Form, InputNumber, Space, Spin, Switch, Typography } from 'antd'
import { DeleteOutlined, PlusOutlined, SaveOutlined } from '@ant-design/icons'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import { kenNumberInputProps } from '@/lib/format'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { MegaphoneSetting } from '@/types'
import {
  DEFAULT_MEGAPHONE_SETTING,
  MEGAPHONE_COOLDOWN_SECONDS_MAX,
  MEGAPHONE_DAILY_LIMIT_MAX,
  MEGAPHONE_DISPLAY_SECONDS_MAX,
  MEGAPHONE_DISPLAY_SECONDS_MIN,
  MEGAPHONE_GAP_SECONDS_MAX,
  MEGAPHONE_GIFT_TIERS_MAX,
  MEGAPHONE_KEN_PRICE_MAX,
  MEGAPHONE_LIVE_MINUTES_MAX,
  MEGAPHONE_MAX_LENGTH_LIMIT,
  MEGAPHONE_REPEAT_BASE_MAX,
  MEGAPHONE_REPEAT_BASE_MIN,
  MEGAPHONE_SEND_RATE_PER_MINUTE,
  MEGAPHONE_SETTING_KEY,
  MEGAPHONE_WEIGHT_MAX,
} from './constants'
import { megaphoneQueueLimits } from './utils'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { MEGAPHONE_SECTION_LINKS } from '@/pages/shop/sections'

function tiersAreValid(tiers: MegaphoneSetting['giftTiers']) {
  return tiers[0]?.minKen === 0 && tiers.every((tier, index) => index === 0 || tier.minKen > tiers[index - 1].minKen)
}

function QueueLimitsNote({ values }: { values: MegaphoneSetting }) {
  const limits = megaphoneQueueLimits(values)
  if (limits == null) return null
  return (
    <Typography.Paragraph type="secondary">
      Tự tính theo thời gian sống: {limits.turns} lượt phát mỗi vòng, nhận tối đa {limits.message} loa thường và{' '}
      {limits.gift} loa quà đang chờ lượt đầu.
    </Typography.Paragraph>
  )
}

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
    if (!tiersAreValid(values.giftTiers)) {
      message.error('Mốc quà phải bắt đầu từ 0 KEN và tăng dần')
      return
    }
    try {
      await putSetting.mutateAsync({ key: MEGAPHONE_SETTING_KEY, value: { ...values, platforms: cleanPlatformRules(values.platforms) } })
      message.success('Đã lưu cài đặt loa')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title={<ShopSectionNav links={MEGAPHONE_SECTION_LINKS} />} style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Server tự phát loa theo lượt cho mọi người trong thời gian sống. Loa hiện ở các tab chính và trong phòng chat, ẩn
        ở màn full màn hình. Máy nào đã xem thì không hiện lại. Chưa lưu lần nào thì hệ thống dùng giá trị mặc định đang
        hiển thị. Mỗi người gọi phát loa tối đa {MEGAPHONE_SEND_RATE_PER_MINUTE} lần/phút (cố định ở server).
      </Typography.Paragraph>
      <Form<MegaphoneSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          name="enabled"
          label="Bật loa"
          valuePropName="checked"
          extra="Công tắc tổng: tắt thì server từ chối loa mới và ngừng phát cho mọi nền tảng, kể cả loa quà. Loa đã phát vẫn xem lại được."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          label="Hiển thị theo nền tảng"
          extra="Tắt nền tảng nào thì nền tảng đó không phát được loa và không hiện viên loa; các nền tảng khác vẫn chạy. App bản cũ chưa có phần này vẫn hiện viên loa, chỉ bị chặn phát. So theo tên bản (1.0.0), không tính build."
        >
          <PlatformRulesTable name={['platforms']} />
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
          extra="Emoji điện thoại tính là 1 ký tự. Emoji của app tính theo độ dài mã, ví dụ [e:5] là 5 ký tự."
          rules={[{ required: true, message: 'Nhập số ký tự tối đa' }]}
        >
          <InputNumber min={1} max={MEGAPHONE_MAX_LENGTH_LIMIT} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="displaySeconds"
          label="Thời gian chạy một lượt (giây)"
          rules={[{ required: true, message: 'Nhập thời gian chạy' }]}
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
          name="liveMinutes"
          label="Thời gian sống của mỗi loa (phút)"
          extra="Trong thời gian này server phát lặp lại, hết hạn thì ngừng."
          rules={[{ required: true, message: 'Nhập thời gian sống' }]}
        >
          <InputNumber min={1} max={MEGAPHONE_LIVE_MINUTES_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="gapSeconds"
          label="Nghỉ giữa 2 lượt phát (giây)"
          rules={[{ required: true, message: 'Nhập thời gian nghỉ' }]}
        >
          <InputNumber min={0} max={MEGAPHONE_GAP_SECONDS_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="repeatBaseSeconds"
          label="Nhịp lặp của trọng số 1 (giây)"
          extra="Một loa lặp lại sau (số này ÷ trọng số) giây. Ví dụ 720 và trọng số 3 là 4 phút một lần."
          rules={[{ required: true, message: 'Nhập nhịp lặp' }]}
        >
          <InputNumber
            min={MEGAPHONE_REPEAT_BASE_MIN}
            max={MEGAPHONE_REPEAT_BASE_MAX}
            precision={0}
            style={{ width: '100%' }}
          />
        </Form.Item>
        <Form.Item
          name="messageWeight"
          label="Trọng số loa thường"
          extra="Trọng số càng cao thì càng được phát nhiều."
          rules={[{ required: true, message: 'Nhập trọng số' }]}
        >
          <InputNumber min={1} max={MEGAPHONE_WEIGHT_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item label="Mốc trọng số loa quà" extra="Tính theo tổng KEN của lần tặng (giá × số lượng). Mốc đầu phải là 0.">
          <Form.List name="giftTiers">
            {(fields, { add, remove }) => (
              <>
                {fields.map((field) => (
                  <Space key={field.key} align="baseline" style={{ display: 'flex' }}>
                    <Form.Item
                      name={[field.name, 'minKen']}
                      rules={[{ required: true, message: 'Nhập mốc KEN' }]}
                    >
                      <InputNumber min={0} precision={0} addonBefore="Từ" addonAfter="KEN" {...kenNumberInputProps} />
                    </Form.Item>
                    <Form.Item
                      name={[field.name, 'weight']}
                      rules={[{ required: true, message: 'Nhập trọng số' }]}
                    >
                      <InputNumber min={1} max={MEGAPHONE_WEIGHT_MAX} precision={0} addonBefore="Trọng số" />
                    </Form.Item>
                    <Button
                      type="text"
                      danger
                      icon={<DeleteOutlined />}
                      aria-label="Xoá mốc"
                      disabled={fields.length === 1}
                      onClick={() => remove(field.name)}
                    />
                  </Space>
                ))}
                <Button
                  type="dashed"
                  icon={<PlusOutlined />}
                  disabled={fields.length >= MEGAPHONE_GIFT_TIERS_MAX}
                  onClick={() => add({ minKen: 0, weight: 1 })}
                >
                  Thêm mốc
                </Button>
              </>
            )}
          </Form.List>
        </Form.Item>
        <Form.Item noStyle shouldUpdate>
          {(form) => <QueueLimitsNote values={form.getFieldsValue(true) as MegaphoneSetting} />}
        </Form.Item>
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}
