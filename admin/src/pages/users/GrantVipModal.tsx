import { useEffect } from 'react'
import { App, Form, Modal, Select } from 'antd'
import { useGrantVip } from '@/hooks/useUserQueries'
import { errorMessage } from '@/lib/apiError'
import { vipIconUrl, vipName } from '@/lib/vipCatalog'
import type { GrantVipRequest } from '@/types'
import { ITEM_GRANT_INITIAL_VALUES, VIP_OPTIONS } from './constants'
import { ItemGrantFields } from './ItemGrantFields'
import { itemGrantSummary } from './utils'

interface GrantVipModalProps {
  open: boolean
  userId: string | null
  username?: string
  onClose: () => void
}

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
      content: `Tặng VIP "${vipName(values.vipTypeId)}"${username ? ` cho @${username}` : ''} (${itemGrantSummary(values)})?`,
      okText: 'Tặng',
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await grant.mutateAsync({ id: userId, payload: { ...values, expiresInDays: values.expiresInDays ?? 0 } })
          message.success(`Đã tặng VIP "${vipName(values.vipTypeId)}"`)
          onClose()
        } catch (err) {
          message.error(errorMessage(err, 'Tặng VIP thất bại'))
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
      <Form form={form} layout="vertical" requiredMark={false} initialValues={ITEM_GRANT_INITIAL_VALUES}>
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
        <ItemGrantFields />
      </Form>
    </Modal>
  )
}
