import { useEffect, useState, type CSSProperties } from 'react'
import { App, Button, Form, Input, InputNumber, Modal, Segmented, Space, Switch, Tag, TimePicker, Typography } from 'antd'
import { PlusOutlined } from '@ant-design/icons'
import type { Dayjs } from 'dayjs'
import { kenNumberInputProps } from '@/lib/format'
import { useCreateKenAutoJob, useUpdateKenAutoJob } from '@/hooks/useKenChests'
import { ApiError } from '@/lib/apiError'
import type {
  KenChestAutoJob,
  KenChestAutoJobRequest,
  KenChestRewardMode,
  KenChestScheduleType,
} from '@/types'

const revealBoxStyle: CSSProperties = {
  marginBottom: 24,
  padding: 16,
  borderRadius: 8,
  background: '#fafafa',
  border: '1px solid #f0f0f0',
}

const kenNumberProps = { min: 1, style: { width: '100%' }, ...kenNumberInputProps }

function DailyTimesInput({
  value = [],
  onChange,
}: {
  value?: string[]
  onChange?: (value: string[]) => void
}) {
  const [picker, setPicker] = useState<Dayjs | null>(null)

  function add() {
    if (!picker) return
    const hhmm = picker.format('HH:mm')
    setPicker(null)
    if (value.includes(hhmm)) return
    onChange?.([...value, hhmm].sort())
  }

  function remove(time: string) {
    onChange?.(value.filter((v) => v !== time))
  }

  return (
    <div>
      <Space.Compact style={{ width: '100%' }}>
        <TimePicker
          value={picker}
          onChange={setPicker}
          format="HH:mm"
          minuteStep={5}
          needConfirm={false}
          placeholder="Chọn giờ"
          style={{ width: '100%' }}
        />
        <Button icon={<PlusOutlined />} onClick={add}>
          Thêm
        </Button>
      </Space.Compact>
      <div style={{ marginTop: 8, display: 'flex', flexWrap: 'wrap', gap: 4 }}>
        {value.length === 0 ? (
          <Typography.Text type="secondary">Chưa có mốc giờ nào</Typography.Text>
        ) : (
          value.map((time) => (
            <Tag key={time} color="blue" closable onClose={() => remove(time)}>
              {time}
            </Tag>
          ))
        )}
      </div>
    </div>
  )
}

interface KenChestAutoJobModalProps {
  open: boolean
  job: KenChestAutoJob | null
  onClose: () => void
}

interface FormValues {
  name: string
  enabled: boolean
  scheduleType: KenChestScheduleType
  intervalMinMinutes?: number
  intervalMaxMinutes?: number
  dailyTimes?: string[]
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
  remainingRuns?: number
}

const TIME_PATTERN = /^([01]\d|2[0-3]):([0-5]\d)$/

const DEFAULT_VALUES: FormValues = {
  name: '',
  enabled: true,
  scheduleType: 'interval',
  intervalMinMinutes: 60,
  intervalMaxMinutes: 90,
  dailyTimes: [],
  rewardMode: 'fixed',
  maxRecipients: 100,
  durationSeconds: 90,
}

export function KenChestAutoJobModal({ open, job, onClose }: KenChestAutoJobModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<FormValues>()
  const createJob = useCreateKenAutoJob()
  const updateJob = useUpdateKenAutoJob()
  const scheduleType = Form.useWatch('scheduleType', form) ?? 'interval'
  const rewardMode = Form.useWatch('rewardMode', form) ?? 'fixed'

  useEffect(() => {
    if (!open) return
    form.resetFields()
    if (job) {
      form.setFieldsValue({
        name: job.name,
        enabled: job.enabled,
        scheduleType: job.scheduleType,
        intervalMinMinutes: job.intervalMinMinutes,
        intervalMaxMinutes: job.intervalMaxMinutes,
        dailyTimes: job.dailyTimes ?? [],
        rewardMode: job.rewardMode,
        kenAmount: job.kenAmount,
        kenMin: job.kenMin,
        kenMax: job.kenMax,
        maxRecipients: job.maxRecipients,
        durationSeconds: job.durationSeconds,
        remainingRuns: job.remainingRuns,
      })
    }
  }, [open, job, form])

  async function onOk() {
    const values = await form.validateFields()
    const payload: KenChestAutoJobRequest = {
      name: values.name,
      enabled: values.enabled,
      scheduleType: values.scheduleType,
      rewardMode: values.rewardMode,
      maxRecipients: values.maxRecipients,
      durationSeconds: values.durationSeconds,
      remainingRuns: values.remainingRuns ?? undefined,
      ...(values.scheduleType === 'interval'
        ? { intervalMinMinutes: values.intervalMinMinutes, intervalMaxMinutes: values.intervalMaxMinutes }
        : { dailyTimes: values.dailyTimes }),
      ...(values.rewardMode === 'fixed'
        ? { kenAmount: values.kenAmount }
        : { kenMin: values.kenMin, kenMax: values.kenMax }),
    }
    try {
      if (job) {
        await updateJob.mutateAsync({ id: job.id, payload })
        message.success('Đã cập nhật lịch')
      } else {
        await createJob.mutateAsync(payload)
        message.success('Đã tạo lịch')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu lịch thất bại')
    }
  }

  return (
    <Modal
      title={job ? 'Sửa lịch rương tự động' : 'Tạo lịch rương tự động'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Lưu"
      cancelText="Huỷ"
      confirmLoading={createJob.isPending || updateJob.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false} initialValues={DEFAULT_VALUES}>
        <Form.Item
          name="name"
          label="Tên lịch"
          rules={[{ required: true, message: 'Vui lòng nhập tên lịch' }]}
        >
          <Input placeholder="Lịch giờ vàng" />
        </Form.Item>

        <div style={{ display: 'flex', gap: 16, alignItems: 'flex-start' }}>
          <Form.Item name="enabled" label="Bật lịch" valuePropName="checked">
            <Switch />
          </Form.Item>
          <Form.Item
            name="remainingRuns"
            label="Số lần chạy (trống = không giới hạn)"
            tooltip="Số lần lịch sẽ phát rương, giảm dần sau mỗi lần. Về 0 thì lịch tự tắt."
            style={{ flex: 1 }}
          >
            <InputNumber min={1} style={{ width: '100%' }} placeholder="Không giới hạn" />
          </Form.Item>
        </div>

        <Form.Item name="scheduleType" label="Kiểu lập lịch">
          <Segmented
            block
            options={[
              { label: 'Theo khoảng cách (ngẫu nhiên)', value: 'interval' },
              { label: 'Theo giờ trong ngày', value: 'daily' },
            ]}
          />
        </Form.Item>

        <div style={revealBoxStyle}>
          {scheduleType === 'interval' ? (
            <>
              <div style={{ marginBottom: 12, fontSize: 13, color: '#6b7785' }}>
                Mỗi lần phát cách nhau một khoảng thời gian ngẫu nhiên trong đoạn dưới đây.
              </div>
              <div style={{ display: 'flex', gap: 8, alignItems: 'flex-start' }}>
                <Form.Item
                  name="intervalMinMinutes"
                  label="Ngẫu nhiên từ (phút)"
                  rules={[{ required: true, message: 'Nhập số phút tối thiểu' }]}
                  style={{ flex: 1, marginBottom: 0 }}
                >
                  <InputNumber min={1} style={{ width: '100%' }} placeholder="60" />
                </Form.Item>
                <Form.Item
                  name="intervalMaxMinutes"
                  label="Đến (phút)"
                  dependencies={['intervalMinMinutes']}
                  rules={[
                    { required: true, message: 'Nhập số phút tối đa' },
                    ({ getFieldValue }) => ({
                      validator(_, value) {
                        const min = getFieldValue('intervalMinMinutes')
                        if (value == null || min == null || value >= min) return Promise.resolve()
                        return Promise.reject(new Error('Tối đa phải ≥ tối thiểu'))
                      },
                    }),
                  ]}
                  style={{ flex: 1, marginBottom: 0 }}
                >
                  <InputNumber min={1} style={{ width: '100%' }} placeholder="90" />
                </Form.Item>
              </div>
            </>
          ) : (
            <Form.Item
              name="dailyTimes"
              label="Mốc giờ phát trong ngày"
              rules={[
                {
                  validator(_, value: string[] | undefined) {
                    if (!value || value.length === 0) {
                      return Promise.reject(new Error('Vui lòng thêm ít nhất 1 mốc giờ'))
                    }
                    const invalid = value.find((v) => !TIME_PATTERN.test(v))
                    if (invalid) return Promise.reject(new Error(`Mốc giờ không hợp lệ: ${invalid}`))
                    return Promise.resolve()
                  },
                },
              ]}
              style={{ marginBottom: 0 }}
            >
              <DailyTimesInput />
            </Form.Item>
          )}
        </div>

        <Form.Item name="rewardMode" label="Chế độ thưởng">
          <Segmented
            block
            options={[
              { label: 'Cố định', value: 'fixed' },
              { label: 'Ngẫu nhiên', value: 'random' },
            ]}
          />
        </Form.Item>

        <div style={revealBoxStyle}>
          {rewardMode === 'fixed' ? (
            <Form.Item
              name="kenAmount"
              label="Số KEN mỗi rương"
              rules={[{ required: true, message: 'Vui lòng nhập số KEN' }]}
              style={{ marginBottom: 0 }}
            >
              <InputNumber {...kenNumberProps} placeholder="10.000" />
            </Form.Item>
          ) : (
            <>
              <Form.Item
                name="kenMin"
                label="KEN tối thiểu"
                rules={[{ required: true, message: 'Vui lòng nhập KEN tối thiểu' }]}
                style={{ marginBottom: 12 }}
              >
                <InputNumber {...kenNumberProps} placeholder="1.000" />
              </Form.Item>
              <Form.Item
                name="kenMax"
                label="KEN tối đa"
                dependencies={['kenMin']}
                rules={[
                  { required: true, message: 'Vui lòng nhập KEN tối đa' },
                  ({ getFieldValue }) => ({
                    validator(_, value) {
                      const min = getFieldValue('kenMin')
                      if (value == null || min == null || value >= min) return Promise.resolve()
                      return Promise.reject(new Error('KEN tối đa phải ≥ tối thiểu'))
                    },
                  }),
                ]}
                style={{ marginBottom: 0 }}
              >
                <InputNumber {...kenNumberProps} placeholder="10.000" />
              </Form.Item>
            </>
          )}
        </div>

        <Form.Item
          name="maxRecipients"
          label="Số lượng người nhận"
          rules={[{ required: true, message: 'Vui lòng nhập số người nhận' }]}
        >
          <InputNumber min={1} style={{ width: '100%' }} placeholder="100" />
        </Form.Item>

        <Form.Item
          name="durationSeconds"
          label="Thời hạn mở (giây, 30–600)"
          rules={[{ required: true, message: 'Vui lòng nhập thời hạn' }]}
        >
          <InputNumber min={30} max={600} style={{ width: '100%' }} placeholder="90" />
        </Form.Item>
      </Form>
    </Modal>
  )
}
