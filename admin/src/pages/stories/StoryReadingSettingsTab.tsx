import { App, Button, Card, Form, InputNumber, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import type { StoryReadingSetting } from '@/types'
import {
  DEFAULT_STORY_READING_SETTING,
  STORY_FREE_CHAPTERS_MAX,
  STORY_READING_SETTING_KEY,
  STORY_UNLOCK_CHARS_MAX,
  STORY_UNLOCK_CHARS_MIN,
} from './constants'
import { storyReadingSetting } from './utils'

export function StoryReadingSettingsTab() {
  const { message, modal } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

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

  const current = storyReadingSetting(settings)

  async function persist(values: StoryReadingSetting) {
    try {
      await putSetting.mutateAsync({
        key: STORY_READING_SETTING_KEY,
        value: {
          enabled: values.enabled,
          freeChaptersPerDay: values.freeChaptersPerDay,
          commentUnlockMinChars: values.commentUnlockMinChars,
        },
      })
      message.success('Đã lưu giới hạn đọc truyện')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: StoryReadingSetting) {
    if (!current.enabled && values.enabled) {
      modal.confirm({
        title: 'Bật giới hạn đọc?',
        content: `Người dùng không có VIP chỉ đọc miễn phí ${values.freeChaptersPerDay} chương mỗi ngày. Muốn đọc tiếp truyện nào thì cần bình luận ít nhất ${values.commentUnlockMinChars} ký tự ở truyện đó.`,
        okText: 'Bật giới hạn',
        cancelText: 'Huỷ',
        onOk: () => persist(values),
      })
      return
    }
    void persist(values)
  }

  return (
    <Card style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Tắt thì ai cũng đọc được mọi chương. Khi bật, người có VIP vẫn đọc không giới hạn.
        Người không có VIP được đọc miễn phí một số chương mỗi ngày, tính theo ngày giờ Việt Nam, mỗi
        chương khác nhau tính một lượt, đọc lại chương đã mở trong ngày không tính thêm. Bình luận đủ
        số ký tự ở một truyện thì mở khoá truyện đó vĩnh viễn cho người bình luận, xoá bình luận cũng
        không khoá lại. Chưa lưu lần nào thì dùng mặc định: bật, {DEFAULT_STORY_READING_SETTING.freeChaptersPerDay}{' '}
        chương mỗi ngày, bình luận {DEFAULT_STORY_READING_SETTING.commentUnlockMinChars} ký tự. Lưu xong máy chủ áp dụng
        trong vòng 1 phút.
      </Typography.Paragraph>
      <Form<StoryReadingSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          name="enabled"
          label="Bật giới hạn đọc"
          valuePropName="checked"
          extra="Tắt thì mọi người đọc tự do. Có hiệu lực ngay với lượt mở chương tiếp theo."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="freeChaptersPerDay"
          label="Số chương miễn phí mỗi ngày"
          rules={[{ required: true, message: 'Nhập số chương miễn phí' }]}
          extra="Áp dụng cho người không có VIP, cộng dồn mọi truyện trong ngày. Đặt 0 thì chỉ đọc được truyện đã mở khoá bằng bình luận."
        >
          <InputNumber<number>
            min={0}
            max={STORY_FREE_CHAPTERS_MAX}
            precision={0}
            suffix="chương"
            style={{ width: 240 }}
          />
        </Form.Item>
        <Form.Item
          name="commentUnlockMinChars"
          label="Số ký tự tối thiểu để bình luận mở khoá truyện"
          rules={[{ required: true, message: 'Nhập số ký tự tối thiểu' }]}
          extra="Bình luận có từ chừng này ký tự trở lên mở khoá vĩnh viễn truyện được bình luận cho chính người viết."
        >
          <InputNumber<number>
            min={STORY_UNLOCK_CHARS_MIN}
            max={STORY_UNLOCK_CHARS_MAX}
            precision={0}
            suffix="ký tự"
            style={{ width: 240 }}
          />
        </Form.Item>
        <Button
          type="primary"
          htmlType="submit"
          icon={<SaveOutlined />}
          loading={putSetting.isPending}
        >
          Lưu cấu hình
        </Button>
      </Form>
    </Card>
  )
}
