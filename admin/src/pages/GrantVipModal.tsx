import { useEffect } from 'react'
import { App, Form, Modal, Select } from 'antd'
import { useGrantVip } from '@/hooks/useUsers'
import { ApiError } from '@/lib/apiError'
import { VIP_CATALOG, vipIconUrl, vipName } from '@/lib/vipCatalog'
import type { GrantVipRequest } from '@/types'

interface GrantVipModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

const VIP_OPTIONS = VIP_CATALOG.map((v) => ({ value: v.id, label: `${v.name} (#${v.id})` }))

export function GrantVipModal({ open, userId, username, onClose }: GrantVipModalProps) {
  const { message, modal } = App.useApp()
  const [form] = Form.useForm<GrantVipRequest>()
  const grant = useGrantVip()

  useEffect(() => {
    if (open) form.resetFields()
  }, [open, form])

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    modal.confirm({
      title: 'Xác nhận tặng VIP?',
      content: `Tặng VIP "${vipName(values.vipTypeId)}"${username ? ` cho @${username}` : ''}?`,
      okText: 'Tặng',
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await grant.mutateAsync({ id: userId, payload: values })
          message.success(`Đã tặng VIP "${vipName(values.vipTypeId)}"`)
          onClose()
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Tặng VIP thất bại')
          throw err
        }
      },
    })
  }

  return (
    <Modal
      title={`Tặng VIP${username ? ` — @${username}` : ''}`}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Xác nhận"
      cancelText="Huỷ"
      confirmLoading={grant.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="vipTypeId"
          label="Loại VIP"
          rules={[{ required: true, message: 'Vui lòng chọn loại VIP' }]}
        >
          <Select
            showSearch
            placeholder="Chọn huy hiệu VIP..."
            optionFilterProp="label"
            options={VIP_OPTIONS}
            optionRender={(option) => (
              <div style={{ display: 'flex', alignItems: 'center', gap: 8 }}>
                <img
                  src={vipIconUrl(Number(option.value))}
                  alt=""
                  width={24}
                  height={24}
                  style={{ objectFit: 'contain' }}
                  onError={(e) => {
                    e.currentTarget.style.visibility = 'hidden'
                  }}
                />
                <span>{option.label}</span>
              </div>
            )}
          />
        </Form.Item>
      </Form>
    </Modal>
  )
}
