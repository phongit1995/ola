import { App, Button, Card, Form, Select, Spin, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { validateDisableVersions } from '@/lib/platformRules'
import { APP_UPDATE_PLATFORMS, APP_UPDATE_SETTING_KEY } from './constants'
import type { AppUpdateSetting } from './types'
import { addedAppUpdateVersions, appUpdateSetting, cleanAppUpdateSetting } from './utils'

export function AppUpdateSettingsPage() {
  const { message, modal } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }

  if (isError) {
    return (
      <Card style={{ maxWidth: 680 }}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  const current = appUpdateSetting(settings)

  async function persist(value: AppUpdateSetting) {
    try {
      await putSetting.mutateAsync({ key: APP_UPDATE_SETTING_KEY, value: { ...value } })
      message.success('Đã lưu danh sách bản phải cập nhật')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: AppUpdateSetting) {
    const value = cleanAppUpdateSetting(values)
    const added = addedAppUpdateVersions(current, value)
    if (added.length > 0) {
      modal.confirm({
        title: 'Bắt buộc các bản này cập nhật?',
        content: `Người dùng đang ở ${added.join(', ')} sẽ phải cập nhật mới dùng tiếp được, ngay khi store có bản mới hơn bản họ đang cài. Máy không hỏi được store (không có Google Play…) thì bị chặn luôn.`,
        okText: 'Bắt buộc cập nhật',
        okButtonProps: { danger: true },
        cancelText: 'Huỷ',
        onOk: () => persist(value),
      })
      return
    }
    void persist(value)
  }

  return (
    <Card style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Người dùng đang ở các bản trong danh sách sẽ thấy hộp thoại “Bạn cần cập nhật bản mới nhất để có thể tiếp
        tục sử dụng.”, không đóng được, bấm nút là mở thẳng App Store / Google Play.
      </Typography.Paragraph>
      <Typography.Paragraph type="secondary">
        App hỏi store trước: chỉ khi store đã có bản mới hơn bản đang cài mới hỏi server (máy không hỏi được store
        thì hỏi luôn), nên thêm bản vào danh sách trước khi bản mới được duyệt cũng không chặn oan.
      </Typography.Paragraph>
      <Form<AppUpdateSetting> layout="vertical" initialValues={current} onFinish={save}>
        {APP_UPDATE_PLATFORMS.map(({ key, label }) => (
          <Form.Item
            key={key}
            name={key}
            label={`${label} — các bản phải cập nhật`}
            rules={[{ validator: validateDisableVersions }]}
          >
            <Select
              mode="tags"
              tokenSeparators={[',', ' ']}
              open={false}
              suffixIcon={null}
              placeholder="Nhập bản rồi Enter, VD 1.0.3"
            />
          </Form.Item>
        ))}
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 12 }}>
          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
            So theo tên bản (1.0.0), không tính build. Chỉ có tác dụng với app từ bản có tính năng này trở đi.
          </Typography.Text>
          <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSetting.isPending}>
            Lưu
          </Button>
        </div>
      </Form>
    </Card>
  )
}
