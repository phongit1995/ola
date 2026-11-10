import { App, Button, Card, Form, Space, Spin, Tabs, Typography } from 'antd'
import { ExclamationCircleFilled, SaveOutlined } from '@ant-design/icons'
import { useState, type ReactNode } from 'react'
import { useAppSettings, usePutAppSettings } from '@/hooks/useAppSettingQueries'
import { errorMessage } from '@/lib/apiError'
import { findBankByBin } from '@/lib/banks'
import { settingValue } from '@/lib/appSetting'
import { cleanPlatformRules } from '@/lib/platformRules'
import type { TopupBankSetting, TopupBonusTierSetting, TopupSetting } from '@/types'
import {
  DEFAULT_BANK,
  DEFAULT_TOPUP,
  TOPUP_SETTINGS_TAB_FIELDS,
  TOPUP_SETTINGS_TAB_LABEL,
  TOPUP_SETTINGS_TAB_ORDER,
} from './constants'
import {
  bankAccountLabel,
  parsePresetAmounts,
  sameSettingValue,
  topupSettingsFormValues,
  topupSettingsTabOf,
} from './utils'
import { TopupDisplayPanel, TopupBankPanel, TopupAmountsPanel, TopupIntegrationsPanel } from './TopupSettingsPanels'
import type { TopupSettingsFormValues, TopupTab } from './types'

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
  const [saved, setSaved] = useState(() => topupSettingsFormValues(topup, bank))
  const [dirtyTabs, setDirtyTabs] = useState<Set<TopupTab>>(() => new Set())
  const [errorTabs, setErrorTabs] = useState<Set<TopupTab>>(() => new Set())

  function refreshDirty(baseline: TopupSettingsFormValues) {
    const current = form.getFieldsValue(true) as TopupSettingsFormValues
    setDirtyTabs(new Set(TOPUP_SETTINGS_TAB_ORDER.filter((t) => TOPUP_SETTINGS_TAB_FIELDS[t].some((f) => !sameSettingValue(current[f], baseline[f])))))
  }

  function refreshErrors() {
    const tabs = new Set<TopupTab>()
    for (const field of form.getFieldsError()) {
      if (field.errors.length > 0) tabs.add(topupSettingsTabOf(field.name[0]))
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
      const next = topupSettingsFormValues(topupPayload, bankPayload)
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
          <span>Từ: {bankAccountLabel(saved.bankBin, saved.accountNumber)}</span>
          <span>
            Sang: <Typography.Text strong>{bankAccountLabel(values.bankBin, values.accountNumber.trim())}</Typography.Text>
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
        <span style={hasError ? { color: '#ff4d4f' } : undefined}>{TOPUP_SETTINGS_TAB_LABEL[key]}</span>
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
    display: <TopupDisplayPanel />,
    bank: <TopupBankPanel />,
    amounts: <TopupAmountsPanel />,
    integrations: <TopupIntegrationsPanel />,
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
          setTab(topupSettingsTabOf(errorFields[0]?.name[0]))
        }}
      >
        <Tabs
          activeKey={tab}
          onChange={(key) => setTab(key as TopupTab)}
          items={TOPUP_SETTINGS_TAB_ORDER.map((key) => ({ key, label: tabLabel(key), forceRender: true, children: panels[key] }))}
        />

        <Space align="center" size={12} wrap>
          <Button type="primary" htmlType="submit" icon={<SaveOutlined />} loading={putSettings.isPending}>
            Lưu cấu hình
          </Button>
          <Typography.Text type="secondary">
            {dirtyTabs.size > 0
              ? `Có thay đổi chưa lưu ở: ${TOPUP_SETTINGS_TAB_ORDER.filter((t) => dirtyTabs.has(t))
                  .map((t) => TOPUP_SETTINGS_TAB_LABEL[t])
                  .join(', ')}`
              : 'Một nút lưu cho cả 4 tab.'}
          </Typography.Text>
        </Space>
      </Form>
    </Card>
  )
}
