import { App, Button, Card, Col, Collapse, Form, Input, InputNumber, Row, Select, Spin, Switch } from 'antd'
import { DeleteOutlined, PlusOutlined, SaveOutlined } from '@ant-design/icons'
import { Typography } from 'antd'
import { useAppSettings, usePutAppSettings } from '@/hooks/useAppSettings'
import { env } from '@/config/env'
import { ApiError } from '@/lib/apiError'
import { VIETQR_BANKS, findBankByBin } from '@/lib/banks'
import type { AppSetting, TopupBankSetting, TopupBonusTierSetting, TopupSetting } from '@/types'

const BONUS_PERCENT_MAX = 500
const NEW_TIER: TopupBonusTierSetting = { minAmount: 100_000, percent: 10 }

function formatThousands(value: number | string | undefined) {
  return `${value ?? ''}`.replace(/\B(?=(\d{3})+(?!\d))/g, ',')
}

function parseThousands(value: string | undefined) {
  return Number((value ?? '').replace(/\D/g, ''))
}

const DEFAULT_BANK: TopupBankSetting = {
  bankName: '',
  bankBin: '',
  accountNumber: '',
  accountName: '',
  memoTemplate: '@{username}',
  sieuthicodeSecret: '',
  discordWebhookUrl: '',
}

const DEFAULT_TOPUP: TopupSetting = {
  enabled: true,
  enabledMobile: true,
  minAmount: 10_000,
  stepAmount: 1_000,
  presetAmounts: [10_000, 20_000, 50_000, 100_000, 200_000, 500_000],
  bonusTiers: [],
}

interface TopupSettingsFormValues {
  enabled: boolean
  enabledMobile: boolean
  bankBin?: string
  accountNumber: string
  accountName?: string
  memoTemplate?: string
  sieuthicodeSecret?: string
  discordWebhookUrl?: string
  minAmount: number
  stepAmount: number
  bonusTiers?: TopupBonusTierSetting[]
  presetAmounts: string[]
}

function settingValue<T>(settings: AppSetting[] | undefined, key: string, defaults: T): T {
  const found = settings?.find((item) => item.key === key)
  if (!found) return defaults
  return { ...defaults, ...(found.value as Partial<T>) }
}

function parsePresetAmounts(raw: string[]): number[] {
  const amounts = raw
    .map((item) => Number(String(item).replace(/\D/g, '')))
    .filter((value) => Number.isFinite(value) && value > 0)
  return [...new Set(amounts)].sort((a, b) => a - b)
}

export function TopupSettingsPage() {
  const { message } = App.useApp()
  const { data: settings, isLoading } = useAppSettings()
  const putSettings = usePutAppSettings()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }

  const bank = settingValue(settings, 'topup_bank', DEFAULT_BANK)
  const topup = settingValue(settings, 'topup', DEFAULT_TOPUP)

  async function save(values: TopupSettingsFormValues) {
    const presetAmounts = parsePresetAmounts(values.presetAmounts)
    if (presetAmounts.length === 0) {
      message.error('Cần ít nhất một mệnh giá gợi ý')
      return
    }
    const bonusTiers = [...(values.bonusTiers ?? [])].sort((a, b) => a.minAmount - b.minAmount)
    const tierMins = bonusTiers.map((tier) => tier.minAmount)
    if (new Set(tierMins).size !== tierMins.length) {
      message.error('Mỗi mốc thưởng chỉ được khai báo một lần')
      return
    }
    const bankBin = values.bankBin ?? ''
    const bankPayload: TopupBankSetting = {
      bankBin,
      bankName: findBankByBin(bankBin)?.name ?? '',
      accountNumber: values.accountNumber.trim(),
      accountName: (values.accountName ?? '').trim().toUpperCase(),
      memoTemplate: (values.memoTemplate ?? '').trim() || DEFAULT_BANK.memoTemplate,
      sieuthicodeSecret: (values.sieuthicodeSecret ?? '').trim(),
      discordWebhookUrl: (values.discordWebhookUrl ?? '').trim(),
    }
    const topupPayload: TopupSetting = {
      enabled: values.enabled,
      enabledMobile: values.enabledMobile,
      minAmount: values.minAmount,
      stepAmount: values.stepAmount,
      bonusTiers,
      presetAmounts,
    }
    try {
      await putSettings.mutateAsync([
        { key: 'topup', value: { ...topupPayload } },
        { key: 'topup_bank', value: { ...bankPayload } },
      ])
      message.success('Đã lưu cấu hình nạp KEN')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
    }
  }

  return (
    <Card title="Nạp KEN" style={{ maxWidth: 680 }}>
      <Form<TopupSettingsFormValues>
        layout="vertical"
        initialValues={{
          enabled: topup.enabled,
          enabledMobile: topup.enabledMobile,
          bankBin: bank.bankBin || undefined,
          accountNumber: bank.accountNumber,
          accountName: bank.accountName,
          memoTemplate: bank.memoTemplate,
          sieuthicodeSecret: bank.sieuthicodeSecret,
          discordWebhookUrl: bank.discordWebhookUrl,
          minAmount: topup.minAmount,
          stepAmount: topup.stepAmount,
          bonusTiers: topup.bonusTiers ?? [],
          presetAmounts: topup.presetAmounts.map(String),
        }}
        onFinish={save}
      >
        <Form.Item
          name="enabled"
          label="Cho phép nạp KEN"
          valuePropName="checked"
          extra="Tắt thì app ẩn menu Nạp KEN và khoá màn nạp."
        >
          <Switch />
        </Form.Item>

        <Form.Item
          name="enabledMobile"
          label="Hiển thị trên mobile"
          valuePropName="checked"
          extra="Tắt thì chỉ app mobile ẩn nút Nạp KEN, web vẫn hiển thị bình thường."
        >
          <Switch />
        </Form.Item>

        <Form.Item
          name="bankBin"
          label="Ngân hàng nhận tiền (VietQR)"
          extra="Chọn ngân hàng để app hiển thị được mã VietQR. Chưa chọn thì app chỉ hiện số tài khoản."
        >
          <Select
            allowClear
            showSearch
            placeholder="Chọn ngân hàng"
            optionFilterProp="label"
            options={VIETQR_BANKS.map((item) => ({
              value: item.bin,
              label: `${item.name} (${item.code})`,
            }))}
          />
        </Form.Item>
        <Form.Item
          name="accountNumber"
          label="Số tài khoản"
          rules={[
            { required: true, message: 'Nhập số tài khoản' },
            { pattern: /^[A-Za-z0-9]+$/, message: 'Chỉ gồm chữ và số, không khoảng trắng' },
          ]}
        >
          <Input placeholder="0123456789" maxLength={30} />
        </Form.Item>
        <Form.Item name="accountName" label="Chủ tài khoản">
          <Input placeholder="NGUYEN VAN A" maxLength={100} />
        </Form.Item>
        <Form.Item
          name="memoTemplate"
          label="Nội dung chuyển khoản"
          extra={
            <Typography.Text type="secondary">
              {'{username}'} sẽ được thay bằng username của người nạp, ví dụ @minhanh. Nên đặt dấu
              @ ngay trước {'{username}'} (vd DONATE @{'{username}'}): nếu người nạp gõ thừa chữ,
              hệ thống sẽ báo cần duyệt tay thay vì cộng nhầm cho user khác.
            </Typography.Text>
          }
        >
          <Input placeholder="@{username}" maxLength={50} />
        </Form.Item>

        <Form.Item
          name="sieuthicodeSecret"
          label="SieuThiCode webhook secret (tự động cộng KEN)"
          extra={
            <Typography.Text type="secondary">
              Dán secret (Api Key) của SieuThiCode vào đây. Bên SieuThiCode cấu hình webhook gọi{' '}
              <Typography.Text code copyable>
                {`${env.apiUrl}/topup/webhook/sieuthicode`}
              </Typography.Text>{' '}
              kèm header <Typography.Text code>signature</Typography.Text>. Để trống thì webhook bị
              khoá.
            </Typography.Text>
          }
        >
          <Input.Password placeholder="Secret bí mật" maxLength={120} autoComplete="new-password" />
        </Form.Item>

        <Form.Item
          name="discordWebhookUrl"
          label="Discord webhook thông báo nạp KEN"
          rules={[{ type: 'url', message: 'URL không hợp lệ' }]}
          extra={
            <Typography.Text type="secondary">
              Bắn thông báo vào kênh Discord khi có giao dịch nạp: ai nạp, số tiền, KEN trước → sau,
              và cả các giao dịch không khớp user / dưới mức tối thiểu cần xử lý tay. Để trống thì
              tắt thông báo.
            </Typography.Text>
          }
        >
          <Input placeholder="https://discord.com/api/webhooks/..." maxLength={300} />
        </Form.Item>

        <Collapse
          ghost
          style={{ marginBottom: 16 }}
          items={[
            {
              key: 'topup-detail',
              label: 'Cấu hình nạp KEN (số tiền tối thiểu, mệnh giá, thưởng %)',
              forceRender: true,
              children: (
                <>
                  <Row gutter={12}>
                    <Col span={12}>
                      <Form.Item
                        name="minAmount"
                        label="Số tiền tối thiểu (VNĐ)"
                        rules={[{ required: true, message: 'Nhập số tiền tối thiểu' }]}
                      >
                        <InputNumber min={1000} step={1000} style={{ width: '100%' }} />
                      </Form.Item>
                    </Col>
                    <Col span={12}>
                      <Form.Item
                        name="stepAmount"
                        label="Bội số (VNĐ)"
                        rules={[{ required: true, message: 'Nhập bội số' }]}
                      >
                        <InputNumber min={1} step={1000} style={{ width: '100%' }} />
                      </Form.Item>
                    </Col>
                  </Row>
                  <Form.Item
                    name="presetAmounts"
                    label="Mệnh giá gợi ý (VNĐ)"
                    extra="Gõ số tiền rồi Enter để thêm. Mỗi mệnh giá phải từ mức tối thiểu và là bội số ở trên."
                    rules={[{ required: true, message: 'Cần ít nhất một mệnh giá' }]}
                  >
                    <Select mode="tags" tokenSeparators={[',', ' ']} open={false} suffixIcon={null} />
                  </Form.Item>

                  <Typography.Text strong>Thưởng KEN theo mốc nạp</Typography.Text>
                  <Typography.Paragraph type="secondary" style={{ marginTop: 4, marginBottom: 8 }}>
                    Tỉ lệ gốc luôn là 1 VNĐ = 1 KEN. Mỗi dòng cộng thêm % KEN cho số tiền từ mốc đó
                    đến trước mốc kế tiếp, mốc lớn nhất áp dụng cho mọi số tiền lớn hơn. Không có dòng
                    nào thì không thưởng. Ví dụ mốc 100.000 thưởng 10%: nạp 100.000đ nhận 110.000 KEN.
                  </Typography.Paragraph>
                  <Form.List name="bonusTiers">
                    {(fields, { add, remove }) => (
                      <>
                        {fields.length > 0 && (
                          <Row gutter={12}>
                            <Col span={10}>
                              <Typography.Text type="secondary">Nạp từ (VNĐ)</Typography.Text>
                            </Col>
                            <Col span={10}>
                              <Typography.Text type="secondary">Thưởng (%)</Typography.Text>
                            </Col>
                          </Row>
                        )}
                        {fields.map((field) => (
                          <Row gutter={12} key={field.key} style={{ marginTop: 8 }}>
                            <Col span={10}>
                              <Form.Item
                                name={[field.name, 'minAmount']}
                                rules={[{ required: true, message: 'Nhập mốc tiền' }]}
                                noStyle
                              >
                                <InputNumber<number>
                                  min={0}
                                  precision={0}
                                  step={10_000}
                                  style={{ width: '100%' }}
                                  formatter={formatThousands}
                                  parser={parseThousands}
                                />
                              </Form.Item>
                            </Col>
                            <Col span={10}>
                              <Form.Item
                                name={[field.name, 'percent']}
                                rules={[{ required: true, message: 'Nhập % thưởng' }]}
                                noStyle
                              >
                                <InputNumber
                                  min={0}
                                  max={BONUS_PERCENT_MAX}
                                  precision={0}
                                  addonAfter="%"
                                  style={{ width: '100%' }}
                                />
                              </Form.Item>
                            </Col>
                            <Col span={4}>
                              <Button icon={<DeleteOutlined />} onClick={() => remove(field.name)} />
                            </Col>
                          </Row>
                        ))}
                        <Button
                          type="dashed"
                          icon={<PlusOutlined />}
                          onClick={() => add({ ...NEW_TIER })}
                          style={{ marginTop: 12 }}
                        >
                          Thêm mốc thưởng
                        </Button>
                      </>
                    )}
                  </Form.List>
                </>
              ),
            },
          ]}
        />

        <Button
          type="primary"
          htmlType="submit"
          icon={<SaveOutlined />}
          loading={putSettings.isPending}
        >
          Lưu cấu hình
        </Button>
      </Form>
    </Card>
  )
}
