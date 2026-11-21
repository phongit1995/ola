import { App, Alert, Form, InputNumber, Modal, Radio, Select, Space } from 'antd'
import { errorMessage } from '@/lib/apiError'
import type { CheckinMonth } from '@/types'
import { CHECKIN_DEFAULT_SLOT_COUNT, CHECKIN_MONTH_SOURCE_OPTIONS } from './constants'
import type { CheckinCreateMonthFormValues } from './types'
import { useCreateCheckinMonth } from './useCheckinQueries'
import { daysInMonth, monthLabel } from './utils'

interface CheckinCreateMonthModalProps {
  month: string
  months: CheckinMonth[]
  onClose: () => void
  onCreated: (month: string) => void
}

export function CheckinCreateMonthModal({ month, months, onClose, onCreated }: CheckinCreateMonthModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<CheckinCreateMonthFormValues>()
  const createMonth = useCreateCheckinMonth()
  const days = daysInMonth(month)
  const sources = [...months].sort((a, b) => b.month.localeCompare(a.month))
  const latest = sources[0]
  const source = Form.useWatch('source', form)
  const slotCount = Form.useWatch('slotCount', form) ?? 0
  const copyFrom = Form.useWatch('copyFrom', form)
  const copySource = sources.find((item) => item.month === copyFrom)

  async function submit(values: CheckinCreateMonthFormValues) {
    try {
      await createMonth.mutateAsync({
        month,
        slotCount: values.slotCount,
        source: values.source,
        copyFrom: values.source === 'copy' ? values.copyFrom : undefined,
      })
      message.success(`Đã tạo lịch ${monthLabel(month).toLowerCase()}`)
      onCreated(month)
    } catch (err) {
      message.error(errorMessage(err, 'Tạo lịch thất bại'))
    }
  }

  return (
    <Modal
      open
      title={`Tạo lịch ${monthLabel(month).toLowerCase()}`}
      onCancel={onClose}
      onOk={() => form.submit()}
      okText="Tạo lịch"
      confirmLoading={createMonth.isPending}
      destroyOnHidden
    >
      <Form<CheckinCreateMonthFormValues>
        form={form}
        layout="vertical"
        initialValues={{
          slotCount: Math.min(latest?.slotCount ?? CHECKIN_DEFAULT_SLOT_COUNT, days),
          source: latest ? 'copy' : 'empty',
          copyFrom: latest?.month,
        }}
        onFinish={submit}
      >
        <Form.Item
          name="slotCount"
          label="Số ô"
          rules={[{ required: true, message: 'Nhập số ô' }]}
          extra={
            slotCount > 0 && slotCount <= days
              ? `Tháng này có ${days} ngày. ${slotCount === days ? 'Người dùng phải điểm danh đủ mọi ngày mới tới ô cuối.' : `Người dùng được nghỉ ${days - slotCount} ngày mà vẫn tới ô cuối.`}`
              : `Từ 1 tới ${days}.`
          }
        >
          <InputNumber min={1} max={days} precision={0} addonAfter="ô" style={{ width: 160 }} />
        </Form.Item>
        <Form.Item name="source" label="Cách tạo">
          <Radio.Group>
            <Space orientation="vertical">
              {CHECKIN_MONTH_SOURCE_OPTIONS.map((option) => (
                <Radio key={option.value} value={option.value} disabled={option.value === 'copy' && sources.length === 0}>
                  {option.label}
                </Radio>
              ))}
            </Space>
          </Radio.Group>
        </Form.Item>
        {source === 'copy' ? (
          <Form.Item
            name="copyFrom"
            label="Chép từ"
            rules={[{ required: true, message: 'Chọn tháng để chép' }]}
            extra={
              copySource && copySource.slotCount !== slotCount
                ? `${monthLabel(copySource.month)} có ${copySource.slotCount} ô: ô k chép sang ô k, ô dư bỏ, ô thiếu để trống. Muốn dời hộp đặc biệt thì kéo thả trên lưới sau khi tạo.`
                : 'Chép nguyên các quà, cờ và nhiệm vụ của từng ô.'
            }
          >
            <Select
              options={sources.map((item) => ({ value: item.month, label: `${monthLabel(item.month)} · ${item.slotCount} ô` }))}
              style={{ maxWidth: 260 }}
            />
          </Form.Item>
        ) : null}
        <Alert type="info" showIcon title="Lịch tạo ra là nháp, chưa chạy. Nhập xong các ô rồi bấm Phát hành trên trang Lịch tháng." />
      </Form>
    </Modal>
  )
}
