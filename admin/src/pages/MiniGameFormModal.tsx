import { useEffect } from 'react'
import { App, Form, Input, InputNumber, Modal, Switch } from 'antd'
import { useCreateMiniGame, useUpdateMiniGame } from '@/hooks/useMiniGames'
import { ApiError } from '@/lib/apiError'
import type { CreateMiniGameRequest, MiniGame } from '@/types'

interface MiniGameFormModalProps {
  open: boolean
  game: MiniGame | null
  onClose: () => void
}

export function MiniGameFormModal({ open, game, onClose }: MiniGameFormModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<CreateMiniGameRequest>()
  const createGame = useCreateMiniGame()
  const updateGame = useUpdateMiniGame()
  const isEdit = game != null

  useEffect(() => {
    if (open) {
      form.setFieldsValue({
        slug: game?.slug ?? '',
        name: game?.name ?? '',
        description: game?.description ?? '',
        iconUrl: game?.iconUrl ?? '',
        gameUrl: game?.gameUrl ?? '',
        sortOrder: game?.sortOrder ?? 0,
        isEnabled: game?.isEnabled ?? true,
      })
    }
  }, [open, game, form])

  async function onOk() {
    const values = await form.validateFields()
    try {
      if (isEdit && game) {
        const { slug: _slug, ...payload } = values
        await updateGame.mutateAsync({ id: game.id, payload })
        message.success('Đã cập nhật mini game')
      } else {
        await createGame.mutateAsync(values)
        message.success('Đã tạo mini game')
      }
      onClose()
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu mini game thất bại')
    }
  }

  return (
    <Modal
      title={isEdit ? 'Sửa mini game' : 'Tạo mini game'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Tạo'}
      cancelText="Huỷ"
      confirmLoading={createGame.isPending || updateGame.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item
          name="slug"
          label="Slug (mã game, trùng với gameId đăng ký ở server game)"
          rules={[
            { required: true, message: 'Vui lòng nhập slug' },
            {
              pattern: /^[a-z0-9]+(-[a-z0-9]+)*$/,
              message: 'Chỉ chữ thường, số và dấu gạch ngang',
            },
            { max: 50, message: 'Tối đa 50 ký tự' },
          ]}
        >
          <Input placeholder="Ví dụ: caro" disabled={isEdit} />
        </Form.Item>
        <Form.Item
          name="name"
          label="Tên game"
          rules={[
            { required: true, message: 'Vui lòng nhập tên game' },
            { max: 100, message: 'Tối đa 100 ký tự' },
          ]}
        >
          <Input placeholder="Ví dụ: Cờ Caro" />
        </Form.Item>
        <Form.Item
          name="description"
          label="Mô tả ngắn"
          rules={[{ max: 300, message: 'Tối đa 300 ký tự' }]}
        >
          <Input.TextArea
            rows={2}
            maxLength={300}
            showCount
            placeholder="Ví dụ: Ghép 5 quân liên tiếp để thắng, đấu online với bạn bè"
          />
        </Form.Item>
        <Form.Item
          name="iconUrl"
          label="URL icon"
          rules={[
            { type: 'url', message: 'URL không hợp lệ' },
            { max: 500, message: 'Tối đa 500 ký tự' },
          ]}
        >
          <Input placeholder="https://cdn.olachat.net/games/caro.webp" />
        </Form.Item>
        <Form.Item
          name="gameUrl"
          label="URL game"
          rules={[
            { required: true, message: 'Vui lòng nhập URL game' },
            { type: 'url', message: 'URL không hợp lệ' },
            { max: 500, message: 'Tối đa 500 ký tự' },
          ]}
        >
          <Input placeholder="https://game-dev.olachat.net/caro/" />
        </Form.Item>
        <Form.Item name="sortOrder" label="Thứ tự sắp xếp (nhỏ hơn hiển thị trước)">
          <InputNumber min={0} style={{ width: '100%' }} placeholder="0" />
        </Form.Item>
        <Form.Item name="isEnabled" label="Đang bật" valuePropName="checked">
          <Switch />
        </Form.Item>
      </Form>
    </Modal>
  )
}
