import { Alert, App, Button, Form, Input, Modal, Radio, Space, Typography } from 'antd'
import { SendOutlined } from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { errorMessage, toApiError } from '@/lib/apiError'
import { HTTP_NOT_FOUND } from '@/lib/constants'
import { formatCount } from '@/lib/format'
import type { CreatePushCampaignRequest } from '@/types'
import { useCreatePushCampaign, usePushAudience } from './usePushCampaignQueries'
import { PUSH_AUDIENCE_LABEL, PUSH_AUDIENCE_OPTIONS, PUSH_BODY_MAX, PUSH_TITLE_MAX } from './constants'

interface PushComposeModalProps {
  open: boolean
  onClose: () => void
}

export function PushComposeModal({ open, onClose }: PushComposeModalProps) {
  return (
    <Modal title="Gửi push" open={open} onCancel={onClose} footer={null} width={600} destroyOnHidden>
      <PushComposeForm onClose={onClose} />
    </Modal>
  )
}

function PushComposeForm({ onClose }: { onClose: () => void }) {
  const { message, modal } = App.useApp()
  const [form] = Form.useForm<CreatePushCampaignRequest>()
  const audience = Form.useWatch('audience', form) ?? 'all'
  const rawUsername = Form.useWatch('username', form) ?? ''
  const username = useDebounce(rawUsername.trim())

  const reach = usePushAudience(audience, username)
  const createCampaign = useCreatePushCampaign()

  function reachText(): string {
    if (audience === 'user' && username === '') return 'Nhập username để xem số thiết bị'
    if (reach.isError) {
      return toApiError(reach.error).status === HTTP_NOT_FOUND
        ? 'Không tìm thấy người dùng này'
        : errorMessage(reach.error, 'Không đếm được người nhận')
    }
    if (reach.data == null) return 'Đang đếm người nhận...'
    return `Sẽ gửi tới ${formatCount(reach.data.users)} người dùng · ${formatCount(reach.data.devices)} thiết bị`
  }

  async function submit() {
    let values: CreatePushCampaignRequest
    try {
      values = await form.validateFields()
    } catch {
      return
    }
    const payload: CreatePushCampaignRequest = {
      audience: values.audience,
      title: values.title.trim(),
      body: values.body.trim(),
      username: values.audience === 'user' ? values.username?.trim() : undefined,
    }
    const target =
      payload.audience === 'user' ? `@${payload.username}` : PUSH_AUDIENCE_LABEL[payload.audience].toLowerCase()
    modal.confirm({
      title: 'Gửi push ngay?',
      content: `Gửi "${payload.title}" tới ${target}. ${reachText()}. Push đã gửi không thu hồi được.`,
      okText: 'Gửi',
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await createCampaign.mutateAsync(payload)
          message.success('Đã xếp lịch gửi push, theo dõi tiến độ ở bảng Lịch sử gửi')
          onClose()
        } catch (err) {
          message.error(errorMessage(err, 'Gửi push thất bại'))
        }
      },
    })
  }

  return (
    <>
      <Alert
        type="info"
        showIcon
        style={{ marginBottom: 16 }}
        message="Push gửi tới điện thoại Android và iOS đã đăng nhập."
      />
      <Form form={form} layout="vertical" requiredMark={false} initialValues={{ audience: 'all' }}>
        <Form.Item name="audience" label="Gửi tới">
          <Radio.Group options={PUSH_AUDIENCE_OPTIONS} optionType="button" />
        </Form.Item>
        {audience === 'user' && (
          <Form.Item
            name="username"
            label="Username"
            rules={[{ required: true, whitespace: true, message: 'Nhập username người nhận' }]}
          >
            <Input placeholder="vd: olame" />
          </Form.Item>
        )}
        <Form.Item
          name="title"
          label="Tiêu đề"
          rules={[{ required: true, whitespace: true, message: 'Nhập tiêu đề' }]}
        >
          <Input maxLength={PUSH_TITLE_MAX} showCount placeholder="vd: Sự kiện cuối tuần" />
        </Form.Item>
        <Form.Item
          name="body"
          label="Nội dung"
          rules={[{ required: true, whitespace: true, message: 'Nhập nội dung' }]}
        >
          <Input.TextArea
            rows={3}
            maxLength={PUSH_BODY_MAX}
            showCount
            placeholder="vd: Nhân đôi KEN khi nạp từ tối nay đến hết Chủ nhật!"
          />
        </Form.Item>
      </Form>
      <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 12, flexWrap: 'wrap' }}>
        <Typography.Text type={reach.isError ? 'danger' : 'secondary'}>{reachText()}</Typography.Text>
        <Space>
          <Button onClick={onClose}>Huỷ</Button>
          <Button
            type="primary"
            icon={<SendOutlined />}
            loading={createCampaign.isPending}
            onClick={() => void submit()}
          >
            Gửi push
          </Button>
        </Space>
      </div>
    </>
  )
}
