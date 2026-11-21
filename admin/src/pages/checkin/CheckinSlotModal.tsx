import { useState } from 'react'
import type { ReactNode } from 'react'
import { Alert, App, Button, Card, Form, InputNumber, Modal, Select, Slider, Space, Switch, Tabs, Tag, Tooltip, Typography, theme } from 'antd'
import { DeleteOutlined, ExclamationCircleFilled, PlusOutlined, QuestionCircleOutlined } from '@ant-design/icons'
import { RewardItemRow } from '@/components/RewardItemRow'
import { ApiError, errorMessage } from '@/lib/apiError'
import type { CheckinMonthDetail } from '@/types'
import {
  CHECKIN_MAX_EXPIRY_DAYS,
  CHECKIN_MAX_GIFTS,
  CHECKIN_MAX_OPTIONS,
  CHECKIN_MIN_WEIGHT,
  CHECKIN_NEW_ITEM,
  CHECKIN_REWARD_TYPES,
  CHECKIN_SLOT_TASK_OPTIONS,
  CHECKIN_TOTAL_WEIGHT,
} from './constants'
import type { CheckinGiftFormValue, CheckinOptionFormValue, CheckinSlotFormValues } from './types'
import { useCheckinSetting, useSaveCheckinSlots } from './useCheckinQueries'
import {
  checkinTaskCostsKen,
  checkinTaskLabel,
  fillOptionsTotal,
  formToSlot,
  monthLabel,
  optionsTotal,
  rebalanceOptions,
  slotToForm,
} from './utils'

type SlotTab = 'gift' | 'task'

const MODAL_WIDTH = 920

const WEIGHT_CONTROL_WIDTH = 220

const SLOT_TAB_LABEL: Record<SlotTab, string> = {
  gift: 'Quà',
  task: 'Nhiệm vụ',
}

const SLOT_TAB_ORDER: SlotTab[] = ['gift', 'task']

interface SlotFlag {
  name: 'enabled' | 'featured' | 'requireVip'
  label: string
  hint: string
}

const ENABLED_FLAG: SlotFlag = {
  name: 'enabled',
  label: 'Có hộp quà',
  hint: 'Tắt thì ô này chỉ điểm danh, không có hộp và nhiệm vụ. Bật thì đặt quà và nhiệm vụ ở hai tab bên dưới.',
}

const BOX_FLAGS: SlotFlag[] = [
  { name: 'featured', label: 'Đặc biệt', hint: 'Hộp đặc biệt: màu vàng, to hơn các hộp khác trên lịch của người dùng.' },
  {
    name: 'requireVip',
    label: 'Có VIP để mở',
    hint: 'Phải đang có VIP mới mở được hộp. Xét lúc bấm Mở quà, sau khi đã làm xong nhiệm vụ. Chưa có VIP thì app báo Cần VIP (không có nút mua); có VIP trước 0h vẫn mở được.',
  },
]

function slotTabOf(field: string | number | undefined): SlotTab {
  return field === 'task' ? 'task' : 'gift'
}

interface CheckinSlotModalProps {
  detail: CheckinMonthDetail
  slot: number
  readOnly: boolean
  lockHint?: string
  onClose: () => void
}

export function CheckinSlotModal({ detail, slot, readOnly, lockHint, onClose }: CheckinSlotModalProps) {
  const { message } = App.useApp()
  const { token } = theme.useToken()
  const [form] = Form.useForm<CheckinSlotFormValues>()
  const [tab, setTab] = useState<SlotTab>('gift')
  const [errorTabs, setErrorTabs] = useState<Set<SlotTab>>(new Set())
  const saveSlots = useSaveCheckinSlots()
  const setting = useCheckinSetting()
  const current = detail.slots[slot - 1]
  const initialValues = slotToForm(current)
  const gifts = Form.useWatch('gifts', form)
  const task = Form.useWatch('task', form)
  const enabled = Form.useWatch('enabled', form) ?? initialValues.enabled
  const giftCount = gifts?.length ?? 0

  function refreshErrors() {
    const tabs = new Set<SlotTab>()
    for (const field of form.getFieldsError()) {
      if (field.errors.length > 0) tabs.add(slotTabOf(field.name[0]))
    }
    setErrorTabs(tabs)
  }

  async function submit(values: CheckinSlotFormValues) {
    try {
      await saveSlots.mutateAsync({ month: detail.month, slots: [formToSlot(slot, values, current.updatedAt)] })
      message.success(`Đã lưu ô ${slot}`)
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Lưu ô thất bại'))
      if (err instanceof ApiError && err.status === 409) onClose()
    }
  }

  function addGift(add: (value: CheckinGiftFormValue) => void) {
    add({ options: [{ ...CHECKIN_NEW_ITEM, weight: CHECKIN_TOTAL_WEIGHT }] })
    if (form.getFieldValue('task') == null) form.setFieldValue('task', 'random')
  }

  function optionsPath(giftIndex: number): ['gifts', number, 'options'] {
    return ['gifts', giftIndex, 'options']
  }

  function readOptions(giftIndex: number): CheckinOptionFormValue[] {
    return form.getFieldValue(optionsPath(giftIndex)) ?? []
  }

  function writeOptions(giftIndex: number, options: CheckinOptionFormValue[]) {
    form.setFieldValue(optionsPath(giftIndex), options)
    void form.validateFields([optionsPath(giftIndex)]).catch(() => undefined)
  }

  function rebalanceAt(giftIndex: number, optionIndex: number, value: number) {
    writeOptions(giftIndex, rebalanceOptions(readOptions(giftIndex), optionIndex, value))
  }

  function commitWeight(giftIndex: number, optionIndex: number) {
    const options = readOptions(giftIndex)
    if (optionsTotal(options) === CHECKIN_TOTAL_WEIGHT) return
    rebalanceAt(giftIndex, optionIndex, options[optionIndex]?.weight ?? CHECKIN_MIN_WEIGHT)
  }

  function addOption(giftIndex: number, add: (value: CheckinOptionFormValue) => void) {
    const remaining = CHECKIN_TOTAL_WEIGHT - optionsTotal(readOptions(giftIndex))
    if (remaining >= CHECKIN_MIN_WEIGHT) {
      add({ ...CHECKIN_NEW_ITEM, weight: remaining })
      return
    }
    add({ ...CHECKIN_NEW_ITEM, weight: CHECKIN_MIN_WEIGHT })
    const options = readOptions(giftIndex)
    writeOptions(giftIndex, rebalanceOptions(options, options.length - 1, Math.floor(CHECKIN_TOTAL_WEIGHT / options.length)))
  }

  function removeOptionAt(giftIndex: number, optionIndex: number, remove: (index: number) => void) {
    remove(optionIndex)
    writeOptions(giftIndex, fillOptionsTotal(readOptions(giftIndex)))
  }

  function onValuesChange(changed: Partial<CheckinSlotFormValues>) {
    if (changed.enabled && (form.getFieldValue('gifts') ?? []).length === 0) {
      form.setFieldsValue({ gifts: [{ options: [{ ...CHECKIN_NEW_ITEM, weight: CHECKIN_TOTAL_WEIGHT }] }] })
      if (form.getFieldValue('task') == null) form.setFieldValue('task', 'random')
    }
    if (!changed.gifts) return
    const stale = form
      .getFieldsError()
      .filter((field) => field.errors.length > 0 && field.name[0] === 'gifts' && field.name[field.name.length - 1] === 'options')
      .map((field) => field.name)
    if (stale.length > 0) void form.validateFields(stale).catch(() => undefined)
  }

  function tabLabel(key: SlotTab): ReactNode {
    const hasError = errorTabs.has(key)
    const count = key === 'gift' && giftCount > 0 ? ` (${giftCount})` : ''
    return (
      <Space size={6}>
        <span style={hasError ? { color: token.colorError } : undefined}>
          {SLOT_TAB_LABEL[key]}
          {count}
        </span>
        {hasError ? <ExclamationCircleFilled style={{ color: token.colorError, marginInlineEnd: 0 }} /> : null}
      </Space>
    )
  }

  const header = (
    <div
      style={{
        display: 'flex',
        gap: 16,
        flexWrap: 'wrap',
        alignItems: 'center',
        padding: '10px 12px',
        marginBottom: 12,
        border: `1px solid ${token.colorBorderSecondary}`,
        borderRadius: token.borderRadiusLG,
      }}
    >
      {[ENABLED_FLAG, ...(enabled ? BOX_FLAGS : [])].map((flag, index) => (
        <Space
          key={flag.name}
          size={8}
          style={index === 0 ? { paddingRight: 16 } : index === 1 ? { borderLeft: `1px solid ${token.colorBorderSecondary}`, paddingLeft: 16 } : undefined}
        >
          <Form.Item name={flag.name} valuePropName="checked" noStyle>
            <Switch />
          </Form.Item>
          <Typography.Text strong>{flag.label}</Typography.Text>
          <Tooltip title={flag.hint}>
            <QuestionCircleOutlined style={{ color: token.colorTextTertiary }} />
          </Tooltip>
        </Space>
      ))}
    </div>
  )

  const giftPanel = (
    <>
      <Typography.Paragraph type="secondary" style={{ marginBottom: 12 }}>
        Mở hộp nhận đủ các quà bên dưới. Mỗi quà bốc 1 món trong danh sách của nó theo tỉ lệ, tổng 100%. Muốn quà cố định thì để danh sách 1 món
        100%.
      </Typography.Paragraph>
      <Form.List
        name="gifts"
        rules={[
          {
            validator: async (_, value: CheckinGiftFormValue[] | undefined) => {
              if (form.getFieldValue('enabled') && (!value || value.length === 0)) {
                throw new Error('Thêm ít nhất một quà, hoặc tắt Có hộp quà để ô này chỉ điểm danh')
              }
            },
          },
        ]}
      >
        {(fields, { add, remove }, { errors: giftErrors }) => (
          <>
            {fields.map((field, index) => {
              const options = gifts?.[index]?.options ?? []
              const total = optionsTotal(options)
              return (
                <Card
                  key={field.key}
                  size="small"
                  style={{ marginBottom: 12 }}
                  title={
                    <Space size={8}>
                      <span>Quà {index + 1}</span>
                      <Typography.Text type="secondary" style={{ fontSize: 12, fontWeight: 400 }}>
                        {options.length > 1 ? `bốc 1 trong ${options.length} món` : 'cố định'}
                      </Typography.Text>
                    </Space>
                  }
                  extra={
                    <Button type="text" danger icon={<DeleteOutlined />} onClick={() => remove(field.name)}>
                      Xoá quà
                    </Button>
                  }
                >
                  <Form.List
                    name={[field.name, 'options']}
                    rules={[
                      {
                        validator: async (_, value: CheckinOptionFormValue[] | undefined) => {
                          if (!value || value.length === 0) throw new Error('Quà cần ít nhất một món')
                          if (optionsTotal(value) !== CHECKIN_TOTAL_WEIGHT) throw new Error(`Tổng tỉ lệ phải bằng ${CHECKIN_TOTAL_WEIGHT}%`)
                        },
                      },
                    ]}
                  >
                    {(optionFields, { add: addOptionField, remove: removeOption }, { errors }) => (
                      <>
                        {optionFields.map((optionField) => (
                          <RewardItemRow
                            key={optionField.key}
                            path={['gifts', field.name, 'options']}
                            name={optionField.name}
                            disabled={readOnly}
                            types={CHECKIN_REWARD_TYPES}
                            maxExpiryDays={CHECKIN_MAX_EXPIRY_DAYS}
                            kenRandom
                            prefix={
                              <div style={{ display: 'flex', alignItems: 'flex-start', gap: 8, width: WEIGHT_CONTROL_WIDTH, flexShrink: 0 }}>
                                <Form.Item name={[optionField.name, 'weight']} noStyle>
                                  <Slider
                                    min={0}
                                    max={CHECKIN_TOTAL_WEIGHT}
                                    step={1}
                                    disabled={readOnly || optionFields.length === 1}
                                    tooltip={{ formatter: (value) => `${value}%` }}
                                    style={{ flex: 1, margin: '11px 6px' }}
                                    onChange={(value: number) => rebalanceAt(index, optionField.name, value)}
                                  />
                                </Form.Item>
                                <Form.Item
                                  name={[optionField.name, 'weight']}
                                  rules={[{ required: true, message: 'Nhập %' }]}
                                  style={{ width: 88, flexShrink: 0, marginBottom: 12 }}
                                >
                                  <InputNumber
                                    min={CHECKIN_MIN_WEIGHT}
                                    max={CHECKIN_TOTAL_WEIGHT}
                                    precision={0}
                                    addonAfter="%"
                                    disabled={readOnly || optionFields.length === 1}
                                    style={{ width: '100%' }}
                                    onStep={(value) => rebalanceAt(index, optionField.name, value)}
                                    onBlur={() => commitWeight(index, optionField.name)}
                                    onPressEnter={() => commitWeight(index, optionField.name)}
                                  />
                                </Form.Item>
                              </div>
                            }
                            onRemove={optionFields.length > 1 ? () => removeOptionAt(index, optionField.name, removeOption) : undefined}
                          />
                        ))}
                        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 12 }}>
                          <Button
                            type="dashed"
                            size="small"
                            icon={<PlusOutlined />}
                            disabled={readOnly || optionFields.length >= CHECKIN_MAX_OPTIONS}
                            onClick={() => addOption(index, addOptionField)}
                          >
                            Thêm món vào danh sách
                          </Button>
                          <Typography.Text strong type={total === CHECKIN_TOTAL_WEIGHT ? 'success' : 'danger'} style={{ fontSize: 13 }}>
                            Tổng {total}%{total === CHECKIN_TOTAL_WEIGHT ? ' ✓' : ` (cần ${CHECKIN_TOTAL_WEIGHT}%)`}
                          </Typography.Text>
                        </div>
                        {errors.length > 0 ? (
                          <Form.Item style={{ marginBottom: 0 }}>
                            <Form.ErrorList errors={errors} />
                          </Form.Item>
                        ) : null}
                      </>
                    )}
                  </Form.List>
                </Card>
              )
            })}
            <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', gap: 12 }}>
              <Button type="dashed" icon={<PlusOutlined />} disabled={readOnly || fields.length >= CHECKIN_MAX_GIFTS} onClick={() => addGift(add)}>
                Thêm quà
              </Button>
              <Typography.Text type="secondary">
                {fields.length === 0 ? 'Chưa có quà nào' : `Mở hộp nhận ${fields.length} món, mỗi quà 1 món`}
              </Typography.Text>
            </div>
            {giftErrors.length > 0 ? (
              <Form.Item style={{ marginBottom: 0 }}>
                <Form.ErrorList errors={giftErrors} />
              </Form.Item>
            ) : null}
          </>
        )}
      </Form.List>
      <Typography.Paragraph type="secondary" style={{ fontSize: 13, marginTop: 8, marginBottom: 0 }}>
        Mọi món phải chọn đủ icon VIP hoặc khung mới lưu được. Icon và khung luôn bị khoá, hạn tối đa 365 ngày, để trống ô ngày thì vĩnh viễn. Vé loa tối đa 100 vé, hạn tối đa 365 ngày. KEN tối đa 10.000 mỗi món, cộng thẳng vào số dư. KEN ngẫu nhiên bốc một số tròn 100 trong khoảng đã nhập (mặc định 100–1.000), mỗi mức có cơ hội như nhau.
      </Typography.Paragraph>
    </>
  )

  const randomTasks = setting.data?.randomTasks ?? []

  const taskPanel = (
    <>
      <Typography.Paragraph type="secondary" style={{ marginBottom: 12 }}>
        Người dùng điểm danh xong mới thấy nhiệm vụ, làm xong mới bấm Mở quà được. Không làm trước 0h thì mất hộp ô này, hôm sau đi tiếp ô sau.
      </Typography.Paragraph>
      <Form.Item name="task" label="Nhiệm vụ" rules={[{ required: true, message: 'Ô có quà phải có nhiệm vụ' }]}>
        <Select options={CHECKIN_SLOT_TASK_OPTIONS} style={{ maxWidth: 360 }} />
      </Form.Item>
      {task === 'random' ? (
        <div style={{ marginTop: -8, marginBottom: 16 }}>
          <Typography.Text type="secondary" style={{ fontSize: 13 }}>
            Mỗi người bốc một trong {randomTasks.length} nhiệm vụ (sửa danh sách ở tab Cài đặt):
          </Typography.Text>
          <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginTop: 6 }}>
            {randomTasks.map((code) => (
              <Tag key={code} color={checkinTaskCostsKen(code) ? 'orange' : undefined} style={{ marginInlineEnd: 0 }}>
                {checkinTaskLabel(code)}
                {checkinTaskCostsKen(code) ? ' (tốn KEN)' : ''}
              </Tag>
            ))}
          </div>
        </div>
      ) : null}
    </>
  )

  const panels: Record<SlotTab, ReactNode> = { gift: giftPanel, task: taskPanel }

  return (
    <Modal
      open
      title={`${readOnly ? 'Xem' : 'Sửa'} ô ${slot} · ${monthLabel(detail.month)}`}
      width={MODAL_WIDTH}
      onCancel={onClose}
      onOk={() => form.submit()}
      okText="Lưu"
      cancelText={readOnly ? 'Đóng' : 'Huỷ'}
      okButtonProps={{ style: readOnly ? { display: 'none' } : undefined }}
      confirmLoading={saveSlots.isPending}
      destroyOnHidden
      styles={{ body: { maxHeight: '72vh', overflowY: 'auto', paddingRight: 8 } }}
    >
      <Form<CheckinSlotFormValues>
        form={form}
        layout="vertical"
        initialValues={initialValues}
        onFinish={submit}
        onFieldsChange={refreshErrors}
        onValuesChange={onValuesChange}
        onFinishFailed={({ errorFields }) => {
          refreshErrors()
          setTab(slotTabOf(errorFields[0]?.name[0]))
        }}
        disabled={readOnly}
      >
        {readOnly && lockHint ? <Alert type="info" showIcon style={{ marginBottom: 8 }} title={`Ô ${slot} đã khoá. ${lockHint}`} /> : null}
        {header}
        {enabled ? (
          <Tabs
            activeKey={tab}
            onChange={(key) => setTab(key as SlotTab)}
            tabBarStyle={{ position: 'sticky', top: 0, zIndex: 2, background: token.colorBgElevated }}
            items={SLOT_TAB_ORDER.map((key) => ({ key, label: tabLabel(key), forceRender: true, children: panels[key] }))}
          />
        ) : (
          <Typography.Paragraph type="secondary" style={{ marginBottom: 0 }}>
            Ô này chỉ điểm danh: người dùng bấm Điểm danh là xong, không có hộp quà và không có nhiệm vụ. Bật Có hộp quà để đặt quà và nhiệm vụ.
          </Typography.Paragraph>
        )}
      </Form>
    </Modal>
  )
}
