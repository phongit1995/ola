import { App, Button, Form, InputNumber, Modal, Space, Spin, Typography } from 'antd'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { useServerFormValues } from '@/hooks/useServerFormValues'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { VipDayTransferSetting } from '@/types'
import {
  DEFAULT_VIP_DAY_TRANSFER_SETTING,
  VIP_DAY_TRANSFER_MIN_DAYS_MAX,
  VIP_DAY_TRANSFER_RATE_MAX,
  VIP_DAY_TRANSFER_SETTING_KEY,
} from './constants'

export function VipDayTransferSettingsModal({
  open,
  onClose,
}: {
  open: boolean
  onClose: () => void
}) {
  return (
    <Modal
      title="Cài đặt chuyển NSD"
      open={open}
      width={640}
      onCancel={onClose}
      footer={null}
      destroyOnHidden
    >
      <VipDayTransferSettingsForm onClose={onClose} />
    </Modal>
  )
}

function VipDayTransferSettingsForm({ onClose }: { onClose: () => void }) {
  const { message } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()
  const [form] = Form.useForm<VipDayTransferSetting>()
  const current = settingValue(settings, VIP_DAY_TRANSFER_SETTING_KEY, DEFAULT_VIP_DAY_TRANSFER_SETTING)
  useServerFormValues(form, current)

  async function save(values: VipDayTransferSetting) {
    try {
      await putSetting.mutateAsync({
        key: VIP_DAY_TRANSFER_SETTING_KEY,
        value: { ...values, platforms: cleanPlatformRules(values.platforms) },
      })
      message.success('Đã lưu cài đặt chuyển NSD')
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

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

  return (
    <>
      <Form<VipDayTransferSetting> form={form} layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          label="Hiển thị chuyển NSD"
          extra="Tắt nền tảng nào thì nền tảng đó ẩn tab Chuyển NSD và nút trong chat, server từ chối lượt chuyển từ nền tảng đó."
        >
          <PlatformRulesTable name={['platforms']} />
        </Form.Item>
        <Form.Item
          name="minSenderDays"
          label="Số ngày tối thiểu bị trừ"
          extra="Người gửi phải chuyển từ số ngày này trở lên."
          rules={[{ required: true, message: 'Nhập số ngày tối thiểu' }]}
        >
          <InputNumber min={1} max={VIP_DAY_TRANSFER_MIN_DAYS_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="rate"
          label="Hệ số"
          extra="Số ngày người nhận được = số ngày bị trừ chia hệ số, làm tròn lên. Ví dụ tối thiểu 10, hệ số 3: chuyển 10 ngày thì người nhận được 4 ngày."
          rules={[{ required: true, message: 'Nhập hệ số' }]}
        >
          <InputNumber min={1} max={VIP_DAY_TRANSFER_RATE_MAX} precision={0} style={{ width: '100%' }} />
        </Form.Item>
      </Form>
      <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
        <Space>
          <Button onClick={onClose}>Huỷ</Button>
          <Button type="primary" loading={putSetting.isPending} onClick={() => form.submit()}>
            Lưu
          </Button>
        </Space>
      </div>
    </>
  )
}
