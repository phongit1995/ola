import { Alert, App, Button, Form, InputNumber, Modal, Space, Typography } from 'antd'
import { DeleteOutlined, PlusOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { MODERATION_SETTING_KEY, VIOLATION_POINTS, moderationSetting } from '@/lib/moderation'
import type { AppSetting, ModerationLockStep, ModerationSetting } from '@/types'
import {
  MODERATION_HOURS_MAX,
  MODERATION_LOCK_STEPS_MAX,
  MODERATION_POINTS_MAX,
  MODERATION_POINTS_MIN,
} from './constants'

const MODAL_TITLE = 'Cài đặt điểm vi phạm'

interface ModerationSettingsModalProps {
  onClose: () => void
}

export function ModerationSettingsModal({ onClose }: ModerationSettingsModalProps) {
  const { data: settings, isLoading, isError, refetch, isRefetching } = useAppSettings()

  if (isLoading) {
    return <Modal open loading title={MODAL_TITLE} onCancel={onClose} footer={null} />
  }
  if (isError || settings == null) {
    return (
      <Modal open title={MODAL_TITLE} onCancel={onClose} footer={null}>
        <Alert
          type="error"
          showIcon
          message="Không tải được cấu hình hiện tại"
          description="Không thể sửa khi chưa tải được cấu hình, vì lưu lúc này sẽ ghi đè cấu hình đang chạy."
          action={
            <Button size="small" loading={isRefetching} onClick={() => void refetch()}>
              Thử lại
            </Button>
          }
        />
      </Modal>
    )
  }
  const setting = settings.find((item) => item.key === MODERATION_SETTING_KEY)
  return (
    <ModerationSettingsForm
      key={setting?.updatedAt ?? 'empty'}
      setting={setting}
      initial={moderationSetting(settings)}
      onClose={onClose}
    />
  )
}

interface ModerationSettingsFormProps {
  setting?: AppSetting
  initial: ModerationSetting
  onClose: () => void
}

function pointsRules(label: string) {
  return [
    { required: true, message: `Nhập ${label}` },
    {
      type: 'number' as const,
      min: MODERATION_POINTS_MIN,
      max: MODERATION_POINTS_MAX,
      message: `Từ ${MODERATION_POINTS_MIN} đến ${MODERATION_POINTS_MAX} điểm`,
    },
  ]
}

function hoursRules(label: string) {
  return [
    { required: true, message: `Nhập ${label}` },
    {
      type: 'number' as const,
      min: 0,
      max: MODERATION_HOURS_MAX,
      message: `Từ 0 đến ${MODERATION_HOURS_MAX} giờ`,
    },
  ]
}

function lockStepsProblem(steps: readonly ModerationLockStep[] | undefined): string | null {
  if (steps == null || steps.length === 0) return 'Cần ít nhất 1 mốc khoá'
  for (let i = 1; i < steps.length; i += 1) {
    if (steps[i].points <= steps[i - 1].points) return 'Điểm của các mốc phải tăng dần'
  }
  if (steps.slice(0, -1).some((step) => step.hours === 0)) return 'Mốc khoá vĩnh viễn (0 giờ) phải là mốc cuối cùng'
  return null
}

const lockStepsRules = [
  {
    validator: (_: unknown, steps: ModerationLockStep[] | undefined) => {
      const problem = lockStepsProblem(steps)
      return problem == null ? Promise.resolve() : Promise.reject(new Error(problem))
    },
  },
]

function ModerationSettingsForm({ setting, initial, onClose }: ModerationSettingsFormProps) {
  const { message } = App.useApp()
  const putSetting = usePutAppSetting()
  const [form] = Form.useForm<ModerationSetting>()

  async function save(values: ModerationSetting) {
    try {
      await putSetting.mutateAsync({
        key: MODERATION_SETTING_KEY,
        expectedUpdatedAt: setting?.updatedAt,
        value: {
          deliberatePoints: values.deliberatePoints,
          expireHours: values.expireHours,
          lockSteps: values.lockSteps.map((step) => ({ points: step.points, hours: step.hours })),
        },
      })
      message.success('Đã lưu cài đặt điểm vi phạm')
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  const footer = (
    <Space>
      <Button onClick={onClose}>Đóng</Button>
      <Button type="primary" loading={putSetting.isPending} onClick={() => form.submit()}>
        Lưu cấu hình
      </Button>
    </Space>
  )

  return (
    <Modal open title={MODAL_TITLE} onCancel={onClose} footer={footer} width={600} destroyOnHidden>
      <Space direction="vertical" size={16} style={{ width: '100%' }}>
        <Alert
          type="info"
          showIcon
          message="Điểm vi phạm chạm mốc nào thì tài khoản tự bị khoá theo mốc đó và đăng xuất khỏi mọi thiết bị"
          description={`Mức "Vi phạm" luôn +${VIOLATION_POINTS} điểm, "Không tính điểm" chỉ ghi nhận. Mỗi nội dung chỉ bị tính 1 lần. Hết thời gian khoá hoặc được admin mở khoá, người dùng vẫn giữ điểm, nên mỗi lần bị cộng điểm sau đó đều bị khoá lại theo mốc cao nhất đã chạm. Gỡ hoặc xoá sạch điểm ở trang Người dùng không tự mở khoá tài khoản.`}
        />
        <Form<ModerationSetting>
          form={form}
          layout="vertical"
          initialValues={initial}
          onFinish={save}
          disabled={putSetting.isPending}
        >
          <Typography.Text strong style={{ display: 'block', marginBottom: 8 }}>
            Mốc khoá tài khoản
          </Typography.Text>
          <Form.List name="lockSteps" rules={lockStepsRules}>
            {(fields, { add, remove }, { errors }) => (
              <>
                {fields.map((field) => (
                  <Space key={field.key} align="baseline" wrap>
                    <Form.Item name={[field.name, 'points']} rules={pointsRules('số điểm')}>
                      <InputNumber<number>
                        min={MODERATION_POINTS_MIN}
                        max={MODERATION_POINTS_MAX}
                        precision={0}
                        prefix="Đủ"
                        suffix="điểm"
                        style={{ width: 150 }}
                      />
                    </Form.Item>
                    <Form.Item name={[field.name, 'hours']} rules={hoursRules('thời gian khoá')}>
                      <InputNumber<number>
                        min={0}
                        max={MODERATION_HOURS_MAX}
                        precision={0}
                        prefix="khoá"
                        suffix="giờ"
                        style={{ width: 170 }}
                      />
                    </Form.Item>
                    <Button
                      icon={<DeleteOutlined />}
                      aria-label="Xoá mốc"
                      disabled={fields.length <= 1}
                      onClick={() => remove(field.name)}
                    />
                  </Space>
                ))}
                <Form.Item extra="0 giờ = khoá vĩnh viễn (chỉ đặt ở mốc cuối). Ví dụ: đủ 2 điểm khoá 12 giờ, đủ 3 điểm khoá vĩnh viễn.">
                  <Button
                    type="dashed"
                    icon={<PlusOutlined />}
                    disabled={fields.length >= MODERATION_LOCK_STEPS_MAX}
                    onClick={() => add({ points: MODERATION_POINTS_MIN, hours: 0 })}
                  >
                    Thêm mốc
                  </Button>
                  <Form.ErrorList errors={errors} />
                </Form.Item>
              </>
            )}
          </Form.List>
          <Form.Item
            name="deliberatePoints"
            label='Điểm cho mức "Cố tình vi phạm"'
            rules={pointsRules('điểm cố tình vi phạm')}
          >
            <InputNumber<number>
              min={MODERATION_POINTS_MIN}
              max={MODERATION_POINTS_MAX}
              precision={0}
              suffix="điểm"
              style={{ width: 200 }}
            />
          </Form.Item>
          <Form.Item
            name="expireHours"
            label="Vi phạm hết hạn sau"
            rules={hoursRules('thời gian hết hạn')}
            extra="0 = không hết hạn, vi phạm được tính mãi. Chỉ cộng điểm các vi phạm trong khoảng này."
            style={{ marginBottom: 0 }}
          >
            <InputNumber<number>
              min={0}
              max={MODERATION_HOURS_MAX}
              precision={0}
              suffix="giờ"
              style={{ width: 200 }}
            />
          </Form.Item>
        </Form>
      </Space>
    </Modal>
  )
}
