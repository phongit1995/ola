import { App, Button, Card, Col, Form, InputNumber, Row, Spin, Switch, Typography } from 'antd'
import { DeleteOutlined, PlusOutlined, SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { errorMessage } from '@/lib/apiError'
import { settingValue } from '@/lib/appSetting'
import { cleanPlatformRules, platformRulesOrMobile } from '@/lib/platformRules'
import type { PlatformRules, UsernameChangeSetting, UsernameChangeTierSetting } from '@/types'
import { DEFAULT_USERNAME_CHANGE } from './constants'

interface UsernameChangeFormValues {
  enabled: boolean
  platforms: PlatformRules
  tiers: UsernameChangeTierSetting[]
}

export function UsernameChangeSettingsPage() {
  const { message } = App.useApp()
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
      <Card title="Đổi nickname" style={{ maxWidth: 680 }}>
        <Typography.Text type="danger">
          Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
        </Typography.Text>
      </Card>
    )
  }

  const current = settingValue(settings, 'username_change', DEFAULT_USERNAME_CHANGE)

  async function save(values: UsernameChangeFormValues) {
    const tiers = [...values.tiers].sort((a, b) => a.minLength - b.minLength)
    const minLengths = tiers.map((tier) => tier.minLength)
    if (new Set(minLengths).size !== minLengths.length) {
      message.error('Mỗi mốc số ký tự chỉ được khai báo một lần')
      return
    }
    if (tiers[0]?.minLength !== 2) {
      message.error('Phải có mốc 2 ký tự để mọi độ dài nickname đều có giá')
      return
    }
    const payload: UsernameChangeSetting = {
      enabled: values.enabled,
      platforms: cleanPlatformRules(values.platforms),
      tiers,
    }
    try {
      await putSetting.mutateAsync({ key: 'username_change', value: { ...payload } })
      message.success('Đã lưu cấu hình đổi nickname')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Card title="Đổi nickname" style={{ maxWidth: 680 }}>
      <Typography.Paragraph type="secondary">
        Phí đổi nickname (username) tính bằng KEN theo độ dài tên mới. Mỗi dòng là một mốc: áp dụng
        cho tên có số ký tự từ mốc đó đến trước mốc kế tiếp; mốc lớn nhất áp dụng cho mọi tên dài
        hơn. Chưa lưu lần nào thì hệ thống dùng đúng bảng giá mặc định đang hiển thị.
      </Typography.Paragraph>
      <Form<UsernameChangeFormValues>
        layout="vertical"
        initialValues={{
          enabled: current.enabled,
          platforms: platformRulesOrMobile(current.platforms, current.enabledMobile),
          tiers: current.tiers,
        }}
        onFinish={save}
      >
        <Form.Item
          name="enabled"
          label="Cho phép đổi nickname"
          valuePropName="checked"
          extra="Công tắc tổng: tắt thì mọi nền tảng ẩn mục Đổi nickname và server từ chối đổi."
        >
          <Switch />
        </Form.Item>

        <Form.Item
          label="Theo nền tảng"
          extra="Tắt nền tảng nào thì nền tảng đó ẩn mục Đổi nickname và server từ chối đổi. So theo tên bản (1.0.0), không tính build."
        >
          <PlatformRulesTable name={['platforms']} />
        </Form.Item>

        <Form.List
          name="tiers"
          rules={[
            {
              validator: (_, tiers: UsernameChangeTierSetting[]) =>
                tiers && tiers.length > 0
                  ? Promise.resolve()
                  : Promise.reject(new Error('Cần ít nhất một mốc giá')),
            },
          ]}
        >
          {(fields, { add, remove }, { errors }) => (
            <>
              <Row gutter={12}>
                <Col span={10}>
                  <Typography.Text strong>Số ký tự tối thiểu</Typography.Text>
                </Col>
                <Col span={10}>
                  <Typography.Text strong>Giá (KEN)</Typography.Text>
                </Col>
              </Row>
              {fields.map((field) => (
                <Row gutter={12} key={field.key} style={{ marginTop: 8 }}>
                  <Col span={10}>
                    <Form.Item
                      name={[field.name, 'minLength']}
                      rules={[{ required: true, message: 'Nhập số ký tự' }]}
                      noStyle
                    >
                      <InputNumber min={2} max={20} precision={0} style={{ width: '100%' }} />
                    </Form.Item>
                  </Col>
                  <Col span={10}>
                    <Form.Item
                      name={[field.name, 'cost']}
                      rules={[{ required: true, message: 'Nhập giá KEN' }]}
                      noStyle
                    >
                      <InputNumber<number>
                        min={0}
                        precision={0}
                        step={100_000}
                        style={{ width: '100%' }}
                        formatter={(value) => `${value}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}
                        parser={(value) => Number((value ?? '').replace(/\D/g, ''))}
                      />
                    </Form.Item>
                  </Col>
                  <Col span={4}>
                    <Button
                      icon={<DeleteOutlined />}
                      onClick={() => remove(field.name)}
                      disabled={fields.length <= 1}
                    />
                  </Col>
                </Row>
              ))}
              <Form.ErrorList errors={errors} />
              <Button
                type="dashed"
                icon={<PlusOutlined />}
                onClick={() => add({ minLength: 2, cost: 0 })}
                style={{ marginTop: 12 }}
              >
                Thêm mốc giá
              </Button>
            </>
          )}
        </Form.List>

        <Button
          type="primary"
          htmlType="submit"
          icon={<SaveOutlined />}
          loading={putSetting.isPending}
          style={{ marginTop: 16 }}
        >
          Lưu cấu hình
        </Button>
      </Form>
    </Card>
  )
}
