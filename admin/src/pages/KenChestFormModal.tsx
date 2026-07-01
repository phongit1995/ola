import { App, Form, InputNumber, Modal, Radio } from 'antd'
import { useCreateKenChest } from '@/hooks/useKenChests'
import { ApiError } from '@/lib/apiError'
import type { CreateKenChestRequest, KenChestRewardMode } from '@/types'

interface KenChestFormModalProps {
  open: boolean
  onClose: () => void
}

interface FormValues {
  rewardMode: KenChestRewardMode
  kenAmount?: number
  kenMin?: number
  kenMax?: number
  maxRecipients: number
  durationSeconds: number
}

export function KenChestFormModal({ open, onClose }: KenChestFormModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<FormValues>()
  const createChest = useCreateKenChest()
  const rewardMode = Form.useWatch('rewardMode', form) ?? 'fixed'

  async function onOk() {
    const values = await form.validateFields()
    const payload: CreateKenChestRequest = {
      rewardMode: values.rewardMode,
      maxRecipients: values.maxRecipients,
      durationSeconds: values.durationSeconds,
      ...(values.rewardMode === 'fixed'
        ? { kenAmount: values.kenAmount }
        : { kenMin: values.kenMin, kenMax: values.kenMax }),
    }
    try {
      await createChest.mutateAsync(payload)
      message.success('Đã tạo & phát rương Ken')
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Tạo rương thất bại')
    }
  }

  return (
    <Modal
      title="Tạo & phát rương Ken"
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Tạo & Phát"
      cancelText="Huỷ"
      confirmLoading={createChest.isPending}
      destroyOnHidden
    >
      <Form
        form={form}
        layout="vertical"
        requiredMark={false}
        initialValues={{ rewardMode: 'fixed', maxRecipients: 100, durationSeconds: 90 }}
      >
        <Form.Item name="rewardMode" label="Chế độ thưởng">
          <Radio.Group
            optionType="button"
            buttonStyle="solid"
            options={[
              { label: 'Cố định', value: 'fixed' },
              { label: 'Ngẫu nhiên', value: 'random' },
            ]}
          />
        </Form.Item>

        {rewardMode === 'fixed' ? (
          <Form.Item
            name="kenAmount"
            label="Số KEN mỗi rương"
            rules={[{ required: true, message: 'Vui lòng nhập số KEN' }]}
          >
            <InputNumber min={1} style={{ width: '100%' }} placeholder="10000" />
          </Form.Item>
        ) : (
          <>
            <Form.Item
              name="kenMin"
              label="KEN tối thiểu"
              rules={[{ required: true, message: 'Vui lòng nhập KEN tối thiểu' }]}
            >
              <InputNumber min={1} style={{ width: '100%' }} placeholder="1000" />
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
            >
              <InputNumber min={1} style={{ width: '100%' }} placeholder="10000" />
            </Form.Item>
          </>
        )}

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
