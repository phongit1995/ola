import { Alert, App, Form, Modal } from 'antd'
import { avatarFrameById, avatarFrameLabel } from '@ola/shared/lib/avatarFrame'
import { AvatarFrameSelect } from '@/components/AvatarFrameSelect'
import { useGrantUserAvatarFrame } from '@/hooks/useUserQueries'
import { errorMessage } from '@/lib/apiError'
import type { GrantUserAvatarFrameRequest } from '@/types'
import { ITEM_GRANT_INITIAL_VALUES } from './constants'
import { ItemGrantFields } from './ItemGrantFields'
import { itemGrantSummary } from './utils'

const NO_DISABLED_FRAMES: ReadonlySet<string> = new Set()

interface GrantAvatarFrameModalProps {
  open: boolean
  userId: string | null
  username?: string
  ownedFrameIds: ReadonlySet<string>
  vipActive: boolean
  onClose: () => void
}

export function GrantAvatarFrameModal({
  open,
  userId,
  username,
  ownedFrameIds,
  vipActive,
  onClose,
}: GrantAvatarFrameModalProps) {
  const { message, modal } = App.useApp()
  const [form] = Form.useForm<GrantUserAvatarFrameRequest>()
  const frameId = Form.useWatch('frameId', form)
  const expiresInDays = Form.useWatch('expiresInDays', form)
  const frame = avatarFrameById(frameId)
  const disabledIds = (expiresInDays ?? 0) > 0 ? NO_DISABLED_FRAMES : ownedFrameIds
  const grant = useGrantUserAvatarFrame()

  async function onOk() {
    if (!userId) return
    const values = await form.validateFields()
    const label = `"${avatarFrameLabel(values.frameId)}" (#${values.frameId})`
    modal.confirm({
      title: 'Xác nhận tặng khung?',
      content: `Tặng khung ${label}${username ? ` cho @${username}` : ''} (${itemGrantSummary(values)})?`,
      okText: 'Tặng',
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await grant.mutateAsync({ id: userId, payload: { ...values, expiresInDays: values.expiresInDays ?? 0 } })
          message.success(`Đã tặng khung ${label}`)
          onClose()
        } catch (err) {
          message.error(errorMessage(err, 'Tặng khung thất bại'))
          throw err
        }
      },
    })
  }

  return (
    <Modal
      title={`Tặng khung avatar${username ? ` — @${username}` : ''}`}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText="Xác nhận"
      cancelText="Huỷ"
      confirmLoading={grant.isPending}
      destroyOnHidden
    >
      {!vipActive && (
        <Alert
          type="warning"
          showIcon
          style={{ marginBottom: 16 }}
          title="User đang hết VIP: vẫn tặng được, nhưng phải có VIP mới đeo và hiện khung."
        />
      )}
      <Form form={form} layout="vertical" requiredMark={false} clearOnDestroy initialValues={ITEM_GRANT_INITIAL_VALUES}>
        <Form.Item
          name="frameId"
          label="Khung avatar"
          extra="Tặng vĩnh viễn: khung user đã có vĩnh viễn bị làm mờ. Tặng có hạn: user đang có bản có hạn thì cộng thêm ngày. Bản có hạn và bản vĩnh viễn là 2 món riêng, không nâng bản có hạn lên vĩnh viễn."
          rules={[{ required: true, message: 'Vui lòng chọn khung' }]}
        >
          <AvatarFrameSelect disabledIds={disabledIds} />
        </Form.Item>
        <ItemGrantFields />
      </Form>
      {frame && (
        <div style={{ display: 'flex', justifyContent: 'center' }}>
          <img src={frame.url} alt={avatarFrameLabel(frame.id)} width={120} height={120} style={{ objectFit: 'contain' }} />
        </div>
      )}
    </Modal>
  )
}
