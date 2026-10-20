import { App, Button, Card, Form, Input, InputNumber, Space, Spin, Switch, Tabs, Tag, Typography } from 'antd'
import { SaveOutlined, UndoOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import type { ChatBotPrompt, ChatBotSetting, ChatBotType } from '@/types'
import { useChatBotDefaults } from './useChatBotSettingQueries'
import { chatBotFormValues, chatBotSettingValue, disabledChatBots } from './utils'
import {
  CHAT_BOT_DAILY_LIMIT_MAX,
  CHAT_BOT_LABEL,
  CHAT_BOT_PROMPT_MAX,
  CHAT_BOT_REMINDER_MAX,
  CHAT_BOT_SETTING_KEY,
  CHAT_BOT_TYPES,
} from './constants'

type PromptField = keyof ChatBotPrompt

function DefaultTag({ value, fallback }: { value?: string; fallback: string }) {
  return (value ?? '').trim() === fallback.trim() ? <Tag color="blue">Đang dùng mặc định</Tag> : <Tag color="gold">Đã chỉnh</Tag>
}

export function ChatBotSettingsPage() {
  const { message, modal } = App.useApp()
  const [form] = Form.useForm<ChatBotSetting>()
  const settings = useAppSettings()
  const defaults = useChatBotDefaults()
  const putSetting = usePutAppSetting()
  const watchedBots = Form.useWatch('bots', form)

  if (settings.isLoading || defaults.isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
        <Spin />
      </div>
    )
  }

  if (settings.isError || defaults.isError || defaults.data == null) {
    return (
      <Typography.Text type="danger">
        Không tải được cấu hình chat-bot. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
      </Typography.Text>
    )
  }

  const defaultPrompts = defaults.data
  const current = chatBotFormValues(settings.data, defaultPrompts)

  async function persist(values: ChatBotSetting) {
    try {
      await putSetting.mutateAsync({
        key: CHAT_BOT_SETTING_KEY,
        value: chatBotSettingValue(values, defaultPrompts),
      })
      message.success('Đã lưu cấu hình chat-bot')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: ChatBotSetting) {
    const turnedOff = disabledChatBots(current, values)
    if (turnedOff.length > 0) {
      modal.confirm({
        title: 'Tắt chat-bot?',
        content: `${turnedOff.map((type) => CHAT_BOT_LABEL[type]).join(', ')} sẽ biến mất khỏi danh bạ, người đang chat sẽ nhận thông báo bot đang tạm nghỉ.`,
        okText: 'Tắt bot',
        okButtonProps: { danger: true },
        cancelText: 'Huỷ',
        onOk: () => persist(values),
      })
      return
    }
    void persist(values)
  }

  function resetField(type: ChatBotType, field: PromptField) {
    form.setFieldValue(['bots', type, field], defaultPrompts[type][field])
  }

  function botTab(type: ChatBotType) {
    const bot = watchedBots?.[type]
    return {
      key: type,
      label: CHAT_BOT_LABEL[type],
      forceRender: true,
      children: (
        <>
          <Form.Item
            name={['bots', type, 'enabled']}
            label="Bật bot"
            valuePropName="checked"
            extra="Tắt thì bot ẩn khỏi danh bạ trên web và app, server từ chối mọi tin nhắn gửi tới bot."
          >
            <Switch />
          </Form.Item>
          <Form.Item
            label={
              <Space>
                Câu lệnh hướng dẫn (system prompt)
                <DefaultTag value={bot?.systemPrompt} fallback={defaultPrompts[type].systemPrompt} />
              </Space>
            }
            extra="Quy định tính cách, cách xưng hô và giới hạn của bot. Được gắn vào đầu mỗi cuộc trò chuyện."
          >
            <Form.Item
              name={['bots', type, 'systemPrompt']}
              noStyle
              rules={[{ required: true, whitespace: true, message: 'Không được để trống' }]}
            >
              <Input.TextArea rows={14} maxLength={CHAT_BOT_PROMPT_MAX} showCount />
            </Form.Item>
          </Form.Item>
          <Button
            icon={<UndoOutlined />}
            style={{ marginTop: -8, marginBottom: 24 }}
            onClick={() => resetField(type, 'systemPrompt')}
          >
            Dùng lại câu mặc định
          </Button>
          <Form.Item
            label={
              <Space>
                Câu nhắc danh tính
                <DefaultTag value={bot?.identityReminder} fallback={defaultPrompts[type].identityReminder} />
              </Space>
            }
            extra="Gắn vào cuối cuộc trò chuyện để bot không quên mình là ai."
          >
            <Form.Item
              name={['bots', type, 'identityReminder']}
              noStyle
              rules={[{ required: true, whitespace: true, message: 'Không được để trống' }]}
            >
              <Input.TextArea rows={5} maxLength={CHAT_BOT_REMINDER_MAX} showCount />
            </Form.Item>
          </Form.Item>
          <Button icon={<UndoOutlined />} style={{ marginTop: -8 }} onClick={() => resetField(type, 'identityReminder')}>
            Dùng lại câu mặc định
          </Button>
        </>
      ),
    }
  }

  return (
    <Card>
      <Typography.Paragraph type="secondary" style={{ maxWidth: 820 }}>
        Sửa câu lệnh của bot tại đây thay vì sửa code. Câu giống hệt mặc định được lưu là "mặc định", nên
        khi đội kỹ thuật cập nhật câu mặc định trong code thì bot tự dùng câu mới.
      </Typography.Paragraph>
      <Form<ChatBotSetting> form={form} layout="vertical" initialValues={current} onFinish={save} style={{ maxWidth: 820 }}>
        <Form.Item
          name="dailyLimit"
          label="Giới hạn lượt chat mỗi người mỗi ngày"
          extra="Tính chung cho mọi bot, đặt lại lúc 0h giờ Việt Nam. 0 = không giới hạn. Lượt bị lỗi phía bot được hoàn lại."
          rules={[{ required: true, message: 'Nhập giới hạn' }]}
        >
          <InputNumber<number> min={0} max={CHAT_BOT_DAILY_LIMIT_MAX} precision={0} style={{ width: 220 }} />
        </Form.Item>
        <Tabs items={CHAT_BOT_TYPES.map(botTab)} />
        <Button
          type="primary"
          htmlType="submit"
          icon={<SaveOutlined />}
          loading={putSetting.isPending}
          style={{ marginTop: 24 }}
        >
          Lưu cấu hình
        </Button>
      </Form>
    </Card>
  )
}
