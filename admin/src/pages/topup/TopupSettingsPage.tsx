import { App, Button, Card, Col, Form, Input, InputNumber, Row, Select, Space, Spin, Switch, Tabs, Typography } from 'antd'
import { DeleteOutlined, ExclamationCircleFilled, PlusOutlined, SaveOutlined } from '@ant-design/icons'
import { useState, type ReactNode } from 'react'
import { fillMemoTemplate } from '@ola/shared/lib/vietqr'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { useAppSettings, usePutAppSettings } from '@/hooks/useAppSettingQueries'
import { env } from '@/config/env'
import { errorMessage } from '@/lib/apiError'
import { VIETQR_BANKS, findBankByBin } from '@/lib/banks'
import { settingValue } from '@/lib/appSetting'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { PlatformRules, TopupBankSetting, TopupBonusTierSetting, TopupSetting } from '@/types'
import { BONUS_PERCENT_MAX, DEFAULT_BANK, DEFAULT_TOPUP, NEW_TIER } from './constants'
import { formatThousands, parsePresetAmounts, parseThousands, topupPlatforms } from './utils'

interface TopupSettingsFormValues {
  enabled: boolean
  platforms: PlatformRules
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

type TopupTab = 'display' | 'bank' | 'amounts' | 'integrations'
type FieldName = keyof TopupSettingsFormValues

const TAB_ORDER: TopupTab[] = ['display', 'bank', 'amounts', 'integrations']

const TAB_FIELDS: Record<TopupTab, FieldName[]> = {
  display: ['enabled', 'platforms'],
  bank: ['bankBin', 'accountNumber', 'accountName', 'memoTemplate'],
  amounts: ['minAmount', 'stepAmount', 'presetAmounts', 'bonusTiers'],
  integrations: ['sieuthicodeSecret', 'discordWebhookUrl'],
}

const TAB_LABEL: Record<TopupTab, string> = {
  display: 'Hiển thị',
  bank: 'Tài khoản nhận tiền',
  amounts: 'Mệnh giá & thưởng',
  integrations: 'Tích hợp',
}

const MEMO_PREVIEW_USERNAME = 'minhanh'

function tabOf(field: unknown): TopupTab {
  return TAB_ORDER.find((tab) => TAB_FIELDS[tab].includes(field as FieldName)) ?? 'display'
}

function sameValue(a: unknown, b: unknown) {
  return JSON.stringify(a ?? null) === JSON.stringify(b ?? null)
}

function formValuesOf(topup: TopupSetting, bank: TopupBankSetting): TopupSettingsFormValues {
  return {
    enabled: topup.enabled,
    platforms: topupPlatforms(topup),
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
  }
}

function accountLabel(bin: string | undefined, accountNumber: string) {
  const bankName = bin ? (findBankByBin(bin)?.name ?? bin) : 'chưa chọn ngân hàng'
  return `${accountNumber || '(trống)'} · ${bankName}`
}

function memoPreviewOf(template: string | undefined) {
  return fillMemoTemplate((template ?? '').trim() || DEFAULT_BANK.memoTemplate, MEMO_PREVIEW_USERNAME)
}

export function TopupSettingsPage() {
  const { data: settings, isLoading } = useAppSettings()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }

  return (
    <TopupSettingsForm
      topup={settingValue(settings, 'topup', DEFAULT_TOPUP)}
      bank={settingValue(settings, 'topup_bank', DEFAULT_BANK)}
    />
  )
}

function TopupSettingsForm({ topup, bank }: { topup: TopupSetting; bank: TopupBankSetting }) {
  const { message, modal } = App.useApp()
  const putSettings = usePutAppSettings()
  const [form] = Form.useForm<TopupSettingsFormValues>()
  const [tab, setTab] = useState<TopupTab>('display')
  const [saved, setSaved] = useState(() => formValuesOf(topup, bank))
  const [dirtyTabs, setDirtyTabs] = useState<Set<TopupTab>>(() => new Set())
  const [errorTabs, setErrorTabs] = useState<Set<TopupTab>>(() => new Set())
  const memoTemplate = Form.useWatch('memoTemplate', form)

  function refreshDirty(baseline: TopupSettingsFormValues) {
    const current = form.getFieldsValue(true) as TopupSettingsFormValues
    setDirtyTabs(new Set(TAB_ORDER.filter((t) => TAB_FIELDS[t].some((f) => !sameValue(current[f], baseline[f])))))
  }

  function refreshErrors() {
    const tabs = new Set<TopupTab>()
    for (const field of form.getFieldsError()) {
      if (field.errors.length > 0) tabs.add(tabOf(field.name[0]))
    }
    setErrorTabs(tabs)
  }

  async function persist(values: TopupSettingsFormValues, presetAmounts: number[], bonusTiers: TopupBonusTierSetting[]) {
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
      platforms: cleanPlatformRules(values.platforms),
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
      const next = formValuesOf(topupPayload, bankPayload)
      form.setFieldsValue(next)
      setSaved(next)
      refreshDirty(next)
      message.success('Đã lưu cấu hình nạp KEN')
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  function save(values: TopupSettingsFormValues) {
    const presetAmounts = parsePresetAmounts(values.presetAmounts)
    if (presetAmounts.length === 0) {
      setTab('amounts')
      message.error('Cần ít nhất một mệnh giá gợi ý')
      return
    }
    const bonusTiers = [...(values.bonusTiers ?? [])].sort((a, b) => a.minAmount - b.minAmount)
    const tierMins = bonusTiers.map((tier) => tier.minAmount)
    if (new Set(tierMins).size !== tierMins.length) {
      setTab('amounts')
      message.error('Mỗi mốc thưởng chỉ được khai báo một lần')
      return
    }

    const accountChanged =
      (values.bankBin ?? '') !== (saved.bankBin ?? '') || values.accountNumber.trim() !== saved.accountNumber.trim()
    if (!accountChanged) {
      void persist(values, presetAmounts, bonusTiers)
      return
    }
    modal.confirm({
      title: 'Đổi tài khoản nhận tiền?',
      content: (
        <Space direction="vertical" size={4}>
          <span>Từ: {accountLabel(saved.bankBin, saved.accountNumber)}</span>
          <span>
            Sang: <Typography.Text strong>{accountLabel(values.bankBin, values.accountNumber.trim())}</Typography.Text>
          </span>
          <Typography.Text type="secondary">
            Người nạp sẽ chuyển tiền vào tài khoản mới từ lần mở màn nạp sau. Kiểm tra kỹ số tài khoản trước khi lưu.
          </Typography.Text>
        </Space>
      ),
      okText: 'Lưu tài khoản mới',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: () => persist(values, presetAmounts, bonusTiers),
      onCancel: () => setTab('bank'),
    })
  }

  function tabLabel(key: TopupTab): ReactNode {
    const hasError = errorTabs.has(key)
    return (
      <Space size={6}>
        <span style={hasError ? { color: '#ff4d4f' } : undefined}>{TAB_LABEL[key]}</span>
        {hasError ? (
          <ExclamationCircleFilled style={{ color: '#ff4d4f', marginInlineEnd: 0 }} />
        ) : (
          dirtyTabs.has(key) && (
            <span
              title="Có thay đổi chưa lưu"
              style={{ display: 'inline-block', width: 7, height: 7, borderRadius: '50%', background: '#faad14' }}
            />
          )
        )}
      </Space>
    )
  }

  const panels: Record<TopupTab, ReactNode> = {
    display: (
      <>
        <Form.Item
          name="enabled"
          label="Cho phép nạp KEN"
          valuePropName="checked"
          extra="Công tắc tổng: tắt thì mọi nền tảng ẩn Nạp KEN và tiền chuyển khoản tới sẽ không được tự cộng KEN."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          label="Hiển thị theo nền tảng"
          extra="Tắt nền tảng nào thì nền tảng đó ẩn nút và màn Nạp KEN, không ảnh hưởng việc cộng KEN. So theo tên bản (1.0.0), không tính build. Có hiệu lực ở lần mở màn nạp sau."
        >
          <PlatformRulesTable name={['platforms']} />
        </Form.Item>
      </>
    ),
    bank: (
      <>
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
          extra="Đổi số tài khoản hoặc ngân hàng sẽ được hỏi xác nhận trước khi lưu."
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
            <Space direction="vertical" size={2}>
              <Typography.Text type="secondary">
                {'{username}'} sẽ được thay bằng username của người nạp. Nên đặt dấu @ ngay trước {'{username}'} (vd
                DONATE @{'{username}'}): nếu người nạp gõ thừa chữ, hệ thống sẽ báo cần duyệt tay thay vì cộng nhầm cho
                user khác.
              </Typography.Text>
              <Typography.Text type="secondary">
                User @{MEMO_PREVIEW_USERNAME} sẽ thấy: <Typography.Text code>{memoPreviewOf(memoTemplate)}</Typography.Text>
              </Typography.Text>
            </Space>
          }
        >
          <Input placeholder="@{username}" maxLength={50} />
        </Form.Item>
      </>
    ),
    amounts: (
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
            <Form.Item name="stepAmount" label="Bội số (VNĐ)" rules={[{ required: true, message: 'Nhập bội số' }]}>
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
          Tỉ lệ gốc luôn là 1 VNĐ = 1 KEN. Mỗi dòng cộng thêm % KEN cho số tiền từ mốc đó đến trước mốc kế tiếp, mốc
          lớn nhất áp dụng cho mọi số tiền lớn hơn. Không có dòng nào thì không thưởng. Ví dụ mốc 100.000 thưởng 10%:
          nạp 100.000đ nhận 110.000 KEN.
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
                      <InputNumber min={0} max={BONUS_PERCENT_MAX} precision={0} addonAfter="%" style={{ width: '100%' }} />
                    </Form.Item>
                  </Col>
                  <Col span={4}>
                    <Button icon={<DeleteOutlined />} onClick={() => remove(field.name)} />
                  </Col>
                </Row>
              ))}
              <Button type="dashed" icon={<PlusOutlined />} onClick={() => add({ ...NEW_TIER })} style={{ marginTop: 12 }}>
                Thêm mốc thưởng
              </Button>
            </>
          )}
        </Form.List>
      </>
    ),
    integrations: (
      <>
        <Form.Item
          name="sieuthicodeSecret"
          label="SieuThiCode webhook secret (tự động cộng KEN)"
          extra={
            <Typography.Text type="secondary">
              Dán secret (Api Key) của SieuThiCode vào đây. Bên SieuThiCode cấu hình webhook gọi{' '}
              <Typography.Text code copyable>
                {`${env.apiUrl}/topup/webhook/sieuthicode`}
              </Typography.Text>{' '}
              kèm header <Typography.Text code>signature</Typography.Text>. Để trống thì webhook bị khoá.
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
              Bắn thông báo vào kênh Discord khi có giao dịch nạp: ai nạp, số tiền, KEN trước → sau, và cả các giao dịch
              không khớp user / dưới mức tối thiểu cần xử lý tay. Để trống thì tắt thông báo.
            </Typography.Text>
          }
        >
          <Input placeholder="https://discord.com/api/webhooks/..." maxLength={300} />
        </Form.Item>
      </>
    ),
  }

  return (
    <Card title="Nạp KEN" style={{ maxWidth: 720 }}>
      <Form<TopupSettingsFormValues>
        form={form}
        layout="vertical"
        initialValues={saved}
        onFinish={save}
        onFieldsChange={() => {
          refreshDirty(saved)
          refreshErrors()
        }}
        onFinishFailed={({ errorFields }) => {
          refreshErrors()
          setTab(tabOf(errorFields[0]?.name[0]))
        }}
      >
        <Tabs
          activeKey={tab}
          onChange={(key) => setTab(key as TopupTab)}
          items={TAB_ORDER.map((key) => ({ key, label: tabLabel(key), forceRender: true, children: panels[key] }))}
        />

        <Space align="center" size={12} wrap>
          <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSettings.isPending}>
            Lưu cấu hình
          </Button>
          <Typography.Text type="secondary">
            {dirtyTabs.size > 0
              ? `Có thay đổi chưa lưu ở: ${TAB_ORDER.filter((t) => dirtyTabs.has(t))
                  .map((t) => TAB_LABEL[t])
                  .join(', ')}`
              : 'Một nút lưu cho cả 4 tab.'}
          </Typography.Text>
        </Space>
      </Form>
    </Card>
  )
}
