import { App, Button, Card, Drawer, Form, InputNumber, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { useServerFormValues } from '@/hooks/useServerFormValues'
import { errorMessage } from '@/lib/apiError'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { MomentDisplaySetting, MomentMediaPurgeSetting, MomentVideoSetting } from '@/types'
import {
  MOMENT_DISPLAY_SETTING_KEY,
  MOMENT_VIDEO_SETTING_KEY,
  MOMENT_MEDIA_PURGE_SETTING_KEY,
  MOMENT_PURGE_AFTER_HOURS_MAX,
  MOMENT_PURGE_AFTER_HOURS_MIN,
  MOMENT_SETTINGS_DRAWER_WIDTH,
} from './constants'
import { MomentPurgeLogs } from './MomentPurgeLogs'
import {
  disabledPlatformLabels,
  hoursInDays,
  momentDisplaySetting,
  momentPurgeSetting,
  momentVideoSetting,
} from './utils'

export function MomentSettingsDrawer({ open, onClose }: { open: boolean; onClose: () => void }) {
  return (
    <Drawer
      open={open}
      onClose={onClose}
      size={MOMENT_SETTINGS_DRAWER_WIDTH}
      title="Cài đặt khoảnh khắc"
      destroyOnHidden
    >
      <MomentSettings />
    </Drawer>
  )
}

function MomentSettings() {
  const { message, modal } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()
  const [form] = Form.useForm<MomentMediaPurgeSetting>()
  const afterHours = Form.useWatch('afterHours', form)
  const current = momentPurgeSetting(settings)
  const markSaved = useServerFormValues(form, current)

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

  async function persist(values: MomentMediaPurgeSetting) {
    try {
      await putSetting.mutateAsync({
        key: MOMENT_MEDIA_PURGE_SETTING_KEY,
        value: { enabled: values.enabled, afterHours: values.afterHours },
      })
      markSaved(values)
      message.success(
        values.enabled
          ? 'Đã lưu, máy chủ bắt đầu xoá file trong vòng khoảng 10 phút'
          : 'Đã lưu, tự động xoá file đang tắt',
      )
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: MomentMediaPurgeSetting) {
    const turningOn = values.enabled && !current.enabled
    const shortening = values.enabled && current.enabled && values.afterHours < current.afterHours
    if (!turningOn && !shortening) {
      void persist(values)
      return
    }
    modal.confirm({
      title: turningOn ? 'Bật tự động xoá file?' : 'Rút ngắn thời gian giữ file?',
      content: `Máy chủ sẽ xoá vĩnh viễn file ảnh/video của mọi khoảnh khắc đăng quá ${values.afterHours} giờ (${hoursInDays(values.afterHours)}), kể cả khoảnh khắc cũ đang có. File đã xoá không khôi phục được.`,
      okText: turningOn ? 'Bật tự động xoá' : 'Lưu',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => persist(values),
    })
  }

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 16 }}>
      <MomentDisplayCard current={momentDisplaySetting(settings)} />
      <MomentVideoCard current={momentVideoSetting(settings)} />
      <Card title="Tự động xoá file ảnh/video">
        <Typography.Paragraph type="secondary">
          Khi bật, cứ 10 phút máy chủ kiểm tra một lần và xoá vĩnh viễn file ảnh, video, ảnh bìa của
          khoảnh khắc đã đăng quá số giờ cài bên dưới. Bản ghi, chữ trên khoảnh khắc và lượt xem vẫn
          giữ, chỗ ảnh/video sẽ báo đã bị xoá. Khoảnh khắc chữ không có file nên không bị ảnh hưởng.
          Khoảnh khắc đang có báo cáo chờ xử lý được giữ file để admin xem, xử lý xong báo cáo thì lượt
          sau mới xoá. Tối thiểu {MOMENT_PURGE_AFTER_HOURS_MIN} giờ vì khoảnh khắc hiện trong khay 24
          giờ. Chưa lưu lần nào thì đang tắt.
        </Typography.Paragraph>
        <Form<MomentMediaPurgeSetting>
          form={form}
          layout="vertical"
          initialValues={current}
          onFinish={save}
        >
          <Form.Item name="enabled" label="Bật tự động xoá file" valuePropName="checked">
            <Switch />
          </Form.Item>
          <Form.Item
            name="afterHours"
            label="Xoá file sau khi đăng"
            rules={[
              { required: true, message: 'Nhập số giờ' },
              {
                type: 'number',
                min: MOMENT_PURGE_AFTER_HOURS_MIN,
                message: `Tối thiểu ${MOMENT_PURGE_AFTER_HOURS_MIN} giờ`,
              },
              {
                type: 'number',
                max: MOMENT_PURGE_AFTER_HOURS_MAX,
                message: `Tối đa ${MOMENT_PURGE_AFTER_HOURS_MAX} giờ (1 năm)`,
              },
            ]}
            extra={afterHours ? `Tức là ${hoursInDays(afterHours)} kể từ lúc đăng` : undefined}
          >
            <InputNumber<number> precision={0} suffix="giờ" style={{ width: 240 }} />
          </Form.Item>
          <Button
            type="primary"
            htmlType="submit"
            icon={<SaveOutlined />}
            loading={putSetting.isPending}
          >
            Lưu cấu hình
          </Button>
        </Form>
      </Card>
      <MomentPurgeLogs enabled={current.enabled} afterHours={current.afterHours} />
    </div>
  )
}

function MomentVideoCard({ current }: { current: MomentVideoSetting }) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const [form] = Form.useForm<MomentVideoSetting>()
  const markSaved = useServerFormValues(form, current)

  async function save(values: MomentVideoSetting) {
    try {
      await putSetting.mutateAsync({
        key: MOMENT_VIDEO_SETTING_KEY,
        value: { vipRequired: values.vipRequired },
      })
      markSaved(values)
      message.success(
        values.vipRequired
          ? 'Đã lưu, từ giờ chỉ thành viên VIP đăng được video'
          : 'Đã lưu, mọi người đều đăng được video',
      )
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title="Đăng video">
      <Typography.Paragraph type="secondary">
        Khi bật, chỉ người còn hạn VIP mới đăng được khoảnh khắc video. Người không có VIP vẫn thấy
        nút Video kèm nhãn VIP, bấm vào sẽ được gợi ý mua VIP. Khoảnh khắc ảnh và chữ không bị ảnh
        hưởng. Chưa lưu lần nào thì đang tắt.
      </Typography.Paragraph>
      <Form<MomentVideoSetting>
        form={form}
        layout="vertical"
        initialValues={current}
        onFinish={save}
      >
        <Form.Item name="vipRequired" label="Chỉ VIP mới được đăng video" valuePropName="checked">
          <Switch />
        </Form.Item>
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}

function MomentDisplayCard({ current }: { current: MomentDisplaySetting }) {
  const { message, modal } = App.useApp()
  const putSetting = usePutAppSetting()
  const [form] = Form.useForm<MomentDisplaySetting>()
  const markSaved = useServerFormValues(form, current)

  async function persist(value: MomentDisplaySetting) {
    try {
      await putSetting.mutateAsync({ key: MOMENT_DISPLAY_SETTING_KEY, value: { ...value } })
      markSaved(value)
      message.success('Đã lưu cài đặt hiển thị khoảnh khắc')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: MomentDisplaySetting) {
    const value = cleanPlatformRules(values)
    const turnedOff = disabledPlatformLabels(current, value)
    if (turnedOff.length === 0) {
      void persist(value)
      return
    }
    modal.confirm({
      title: `Tắt Khoảnh khắc trên ${turnedOff.join(', ')}?`,
      content:
        'Khay khoảnh khắc, mục "Khoảnh khắc" trong menu và trang "Khoảnh khắc của tôi" sẽ biến mất ở lần mở app tiếp theo. Dữ liệu khoảnh khắc vẫn giữ nguyên.',
      okText: 'Tắt',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => persist(value),
    })
  }

  return (
    <Card title="Hiển thị trên app">
      <Typography.Paragraph type="secondary">
        Tắt ở nền tảng nào thì app trên nền tảng đó ẩn khay khoảnh khắc, mục &quot;Khoảnh khắc&quot;
        trong menu và trang &quot;Khoảnh khắc của tôi&quot;. Chưa lưu lần nào thì đang bật ở mọi nền
        tảng.
      </Typography.Paragraph>
      <Form<MomentDisplaySetting> form={form} initialValues={current} onFinish={save}>
        <PlatformRulesTable />
        <div
          style={{
            marginTop: 12,
            display: 'flex',
            justifyContent: 'space-between',
            alignItems: 'center',
            gap: 12,
          }}
        >
          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
            So theo tên bản (1.0.0), không tính build. Có hiệu lực ở lần mở app sau.
          </Typography.Text>
          <Button
            type="primary"
            htmlType="submit"
            icon={<SaveOutlined />}
            loading={putSetting.isPending}
          >
            Lưu
          </Button>
        </div>
      </Form>
    </Card>
  )
}
