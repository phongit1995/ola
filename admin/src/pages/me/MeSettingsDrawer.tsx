import { App, Button, Card, Drawer, Form, Spin, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { PostLimitFields } from '@/components/PostLimitFields'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { useServerFormValues } from '@/hooks/useServerFormValues'
import { errorMessage } from '@/lib/apiError'
import type { PostLimitSetting } from '@/types'
import { DEFAULT_ME_POST_LIMIT_SETTING, ME_POST_LIMIT_SETTING_KEY, ME_SETTINGS_DRAWER_WIDTH } from './constants'
import { mePostLimitSetting } from './utils'

export function MeSettingsDrawer({ open, onClose }: { open: boolean; onClose: () => void }) {
  return (
    <Drawer open={open} onClose={onClose} size={ME_SETTINGS_DRAWER_WIDTH} title="Cài đặt Me" destroyOnHidden>
      <MeSettings />
    </Drawer>
  )
}

function MeSettings() {
  const { data: settings, isLoading, isError } = useAppSettings()

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

  return <MePostLimitCard current={mePostLimitSetting(settings)} />
}

function MePostLimitCard({ current }: { current: PostLimitSetting }) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const [form] = Form.useForm<PostLimitSetting>()
  const markSaved = useServerFormValues(form, current)
  const defaults = DEFAULT_ME_POST_LIMIT_SETTING

  async function save(values: PostLimitSetting) {
    try {
      await putSetting.mutateAsync({
        key: ME_POST_LIMIT_SETTING_KEY,
        value: { normalPerDay: values.normalPerDay, vipPerDay: values.vipPerDay },
      })
      markSaved(values)
      message.success('Đã lưu giới hạn đăng bài Me')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title="Giới hạn đăng bài">
      <Typography.Paragraph type="secondary">
        Số bài Me mỗi người được đăng trong một ngày, đếm theo ngày giờ Việt Nam. Chỉ tính bài Me cá nhân, bài đăng
        trong clan không bị tính. Bài đã đăng rồi xoá vẫn tính lượt. Hết lượt thì app báo cho người dùng, chỉ gợi ý mua
        VIP khi mức VIP cao hơn hoặc không giới hạn. Chưa lưu lần nào thì dùng mặc định: người chưa VIP {defaults.normalPerDay} bài, VIP {defaults.vipPerDay} bài.
      </Typography.Paragraph>
      <Form<PostLimitSetting> form={form} layout="vertical" initialValues={current} onFinish={save}>
        <PostLimitFields unit="bài" />
        <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
          Lưu
        </Button>
      </Form>
    </Card>
  )
}
