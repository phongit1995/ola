import { useEffect, useMemo } from 'react'
import { Link, useNavigate, useParams, useSearchParams } from 'react-router-dom'
import {
  Alert,
  App,
  Button,
  Card,
  Checkbox,
  Col,
  DatePicker,
  Divider,
  Form,
  Input,
  InputNumber,
  Row,
  Segmented,
  Select,
  Space,
  Spin,
  Switch,
  Typography,
} from 'antd'
import { ArrowLeftOutlined, DeleteOutlined, PlusOutlined, SaveOutlined, ThunderboltOutlined } from '@ant-design/icons'
import { errorMessage } from '@/lib/apiError'
import { formatCount } from '@/lib/format'
import { VIP_CATALOG, vipIconUrl } from '@/lib/vipCatalog'
import {
  GIFT_CODE_DATE_FORMAT,
  GIFT_CODE_DEFAULT_LENGTH,
  GIFT_CODE_LENGTH_MAX,
  GIFT_CODE_LENGTH_MIN,
  GIFT_CODE_MAX_BATCH,
  GIFT_CODE_MAX_REWARDS,
  GIFT_CODE_MAX_SHARED_USES,
  GIFT_CODE_MESSAGE_MAX,
  GIFT_CODE_PLATFORM_OPTIONS,
  GIFT_CODE_PREFIX_MAX,
  GIFT_CODE_SHARED_MAX,
  GIFT_CODE_SHARED_MIN,
  GIFT_CODE_SUMMARY_DATE_FORMAT,
} from './constants'
import { GiftCodeSuccessPreview } from './GiftCodeSuccessPreview'
import type { GiftCodeFormValues } from './types'
import { useGiftCodeCampaign, useSaveGiftCodeCampaign } from './useGiftCodeQueries'
import {
  GIFT_CODE_EMPTY_FORM,
  campaignToForm,
  cleanRewards,
  formToRequest,
  normalizeGiftCode,
  randomGiftCode,
  rewardsText,
  sampleGiftCode,
  successMessagePreview,
} from './utils'

const REWARD_TYPE_OPTIONS = [
  { value: 'vip_days', label: 'Ngày VIP' },
  { value: 'vip_icon', label: 'Icon VIP' },
]

const VIP_ICON_OPTIONS = VIP_CATALOG.map((entry) => ({
  value: entry.id,
  name: `#${entry.id} ${entry.name}`,
  label: (
    <Space>
      <img src={vipIconUrl(entry.id)} alt="" width={22} height={22} style={{ objectFit: 'contain' }} />
      <span>
        #{entry.id} — {entry.name}
      </span>
    </Space>
  ),
}))

export function GiftCodeFormPage() {
  const { message } = App.useApp()
  const navigate = useNavigate()
  const { id } = useParams<{ id: string }>()
  const [searchParams] = useSearchParams()
  const cloneFrom = id ? undefined : searchParams.get('from') ?? undefined
  const sourceId = id ?? cloneFrom
  const isEdit = id != null
  const [form] = Form.useForm<GiftCodeFormValues>()
  const source = useGiftCodeCampaign(sourceId)
  const save = useSaveGiftCodeCampaign()

  const locked = isEdit && (source.data?.usedCount ?? 0) > 0

  useEffect(() => {
    if (sourceId == null) {
      form.setFieldsValue(GIFT_CODE_EMPTY_FORM)
      return
    }
    if (source.data) form.setFieldsValue(campaignToForm(source.data, !isEdit))
  }, [form, isEdit, source.data, sourceId])

  const kind = Form.useWatch('kind', form) ?? 'shared'
  const code = Form.useWatch('code', form) ?? ''
  const codePrefix = Form.useWatch('codePrefix', form) ?? ''
  const codeLength = Form.useWatch('codeLength', form) ?? GIFT_CODE_DEFAULT_LENGTH
  const totalUses = Form.useWatch('totalUses', form) ?? 0
  const rewardValues = Form.useWatch('rewards', form)
  const successMessage = Form.useWatch('successMessage', form) ?? ''
  const sendNotification = Form.useWatch('sendNotification', form) ?? true
  const onePerDevice = Form.useWatch('onePerDevice', form) ?? true
  const startsAt = Form.useWatch('startsAt', form)
  const endsAt = Form.useWatch('endsAt', form)

  const rewards = useMemo(() => cleanRewards(rewardValues), [rewardValues])
  const sample = sampleGiftCode(codePrefix, codeLength)
  const preview = successMessagePreview(successMessage, rewards)

  async function submit() {
    let values: GiftCodeFormValues
    try {
      values = await form.validateFields()
    } catch {
      return
    }
    try {
      const saved = await save.mutateAsync({ id, payload: formToRequest(values) })
      message.success(isEdit ? 'Đã lưu đợt' : 'Đã tạo đợt mã quà tặng')
      navigate(`/gift-codes/${saved.id}`)
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  if (sourceId != null && source.isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }

  const title = isEdit ? 'Sửa đợt mã quà tặng' : cloneFrom ? 'Nhân bản đợt' : 'Tạo đợt mã quà tặng'
  const backTo = isEdit ? `/gift-codes/${id}` : '/gift-codes'
  const timeText = `${startsAt ? startsAt.format(GIFT_CODE_SUMMARY_DATE_FORMAT) : 'lúc lưu'} đến ${
    endsAt ? endsAt.format(GIFT_CODE_SUMMARY_DATE_FORMAT) : '…'
  }`
  const perText = onePerDevice ? 'mỗi người và mỗi thiết bị 1 lần' : 'mỗi người 1 lần'
  const giftText = rewardsText(rewards, true) || '…'

  return (
    <Card
      title={
        <Space>
          <Link to={backTo}>
            <ArrowLeftOutlined />
          </Link>
          {title}
        </Space>
      }
      style={{ maxWidth: 860 }}
    >
      {cloneFrom && source.data && (
        <Alert
          type="success"
          showIcon
          style={{ marginBottom: 20 }}
          title={
            <span>
              Đã chép cài đặt từ đợt <b>{source.data.name}</b>. Mã cũ không được chép, kiểm tra lại mã và thời gian trước
              khi tạo.
            </span>
          }
        />
      )}
      {locked && (
        <Alert
          type="warning"
          showIcon
          style={{ marginBottom: 20 }}
          title="Đã có người nhận nên không đổi được loại mã, dạng mã và quà. Vẫn sửa được tên, lời nhắn, thời gian, điều kiện và tổng lượt (mã chung)."
        />
      )}
      <Form form={form} layout="vertical" requiredMark={false} initialValues={GIFT_CODE_EMPTY_FORM}>
        <Form.Item name="name" label="Tên đợt" extra="Chỉ admin thấy." rules={[{ required: true, whitespace: true, message: 'Nhập tên đợt' }]}>
          <Input maxLength={100} placeholder="vd: Tết 2027" />
        </Form.Item>
        <Form.Item
          name="kind"
          label="Loại mã"
          extra={
            kind === 'shared'
              ? 'Một mã dùng chung, mỗi người nhập được 1 lần.'
              : 'Server sinh sẵn nhiều mã, mỗi mã chỉ dùng 1 lần. Một người cũng chỉ nhận được 1 lần trong đợt.'
          }
        >
          <Segmented
            block
            disabled={locked}
            options={[
              { value: 'shared', label: 'Mã chung' },
              { value: 'unique', label: 'Mã riêng (sinh hàng loạt)' },
            ]}
          />
        </Form.Item>

        {kind === 'shared' ? (
          <Row gutter={16}>
            <Col xs={24} md={12}>
              <Form.Item label="Mã" required extra="4–20 ký tự chữ và số, người dùng nhập hoa hay thường đều được.">
                <Space.Compact style={{ width: '100%' }}>
                  <Form.Item
                    name="code"
                    noStyle
                    normalize={normalizeGiftCode}
                    rules={[
                      { required: true, message: 'Nhập mã' },
                      {
                        pattern: new RegExp(`^[A-Z0-9]{${GIFT_CODE_SHARED_MIN},${GIFT_CODE_SHARED_MAX}}$`),
                        message: 'Mã gồm 4–20 ký tự chữ và số',
                      },
                    ]}
                  >
                    <Input disabled={locked} maxLength={GIFT_CODE_SHARED_MAX} style={{ fontWeight: 600, letterSpacing: 1 }} placeholder="TET2027" />
                  </Form.Item>
                  <Button disabled={locked} icon={<ThunderboltOutlined />} onClick={() => form.setFieldValue('code', randomGiftCode())}>
                    Tạo ngẫu nhiên
                  </Button>
                </Space.Compact>
              </Form.Item>
            </Col>
            <Col xs={24} md={12}>
              <Form.Item
                name="totalUses"
                label="Tổng lượt dùng"
                extra={locked ? `Đã dùng ${formatCount(source.data?.usedCount ?? 0)} lượt, chỉ tăng được.` : 'Hết lượt thì mã ngừng nhận.'}
                rules={[{ required: true, message: 'Nhập tổng lượt' }]}
              >
                <InputNumber
                  min={Math.max(1, source.data?.usedCount ?? 0)}
                  max={GIFT_CODE_MAX_SHARED_USES}
                  style={{ width: '100%' }}
                  addonAfter="lượt"
                />
              </Form.Item>
            </Col>
          </Row>
        ) : (
          <>
            <Row gutter={16}>
              <Col xs={24} md={8}>
                <Form.Item
                  name="codePrefix"
                  label="Tiền tố"
                  extra="Không bắt buộc, tối đa 8 ký tự."
                  normalize={normalizeGiftCode}
                  rules={[{ pattern: /^[A-Z0-9-]*$/, message: 'Chỉ dùng chữ, số và dấu gạch ngang' }]}
                >
                  <Input disabled={locked} maxLength={GIFT_CODE_PREFIX_MAX} style={{ fontWeight: 600, letterSpacing: 1 }} placeholder="TET27-" />
                </Form.Item>
              </Col>
              <Col xs={24} md={8}>
                <Form.Item name="codeLength" label="Độ dài phần ngẫu nhiên" extra="6–16 ký tự." rules={[{ required: true, message: 'Nhập độ dài' }]}>
                  <InputNumber disabled={locked} min={GIFT_CODE_LENGTH_MIN} max={GIFT_CODE_LENGTH_MAX} style={{ width: '100%' }} addonAfter="ký tự" />
                </Form.Item>
              </Col>
              <Col xs={24} md={8}>
                <Form.Item
                  name="totalUses"
                  label="Số mã cần sinh"
                  extra={isEdit ? 'Muốn thêm mã thì dùng "Sinh thêm mã" ở trang chi tiết.' : 'Sau khi tạo vẫn sinh thêm được.'}
                  rules={[{ required: true, message: 'Nhập số mã' }]}
                >
                  <InputNumber disabled={isEdit} min={1} max={GIFT_CODE_MAX_BATCH} style={{ width: '100%' }} addonAfter="mã" />
                </Form.Item>
              </Col>
            </Row>
            <Alert
              type="info"
              style={{ marginBottom: 20, marginTop: -4 }}
              title={
                <span>
                  Mã sẽ có dạng <Typography.Text code strong>{sample}</Typography.Text>. Không dùng 0, O, 1, I, L để người dùng khỏi gõ nhầm.
                </span>
              }
            />
          </>
        )}

        <Row gutter={16}>
          <Col xs={24} md={12}>
            <Form.Item name="startsAt" label="Bắt đầu" extra="Giờ Việt Nam. Để trống là chạy ngay khi lưu.">
              <DatePicker showTime format={GIFT_CODE_DATE_FORMAT} style={{ width: '100%' }} placeholder="Ngay khi lưu" />
            </Form.Item>
          </Col>
          <Col xs={24} md={12}>
            <Form.Item
              name="endsAt"
              label="Kết thúc"
              dependencies={['startsAt']}
              rules={[
                { required: true, message: 'Chọn ngày kết thúc' },
                ({ getFieldValue }) => ({
                  validator(_, value) {
                    const start = getFieldValue('startsAt')
                    if (!value || !start || value.isAfter(start)) return Promise.resolve()
                    return Promise.reject(new Error('Kết thúc phải sau bắt đầu'))
                  },
                }),
              ]}
            >
              <DatePicker showTime format={GIFT_CODE_DATE_FORMAT} style={{ width: '100%' }} />
            </Form.Item>
          </Col>
        </Row>

        <Divider titlePlacement="start" plain style={{ margin: '4px 0 16px' }}>
          Quà nhận được
        </Divider>
        <Form.List
          name="rewards"
          rules={[
            {
              validator: async (_, value) => {
                if (cleanRewards(value).length === 0) throw new Error('Thêm ít nhất một món quà')
              },
            },
          ]}
        >
          {(fields, { add, remove }, { errors }) => (
            <>
              {fields.map((field) => (
                <RewardRow
                  key={field.key}
                  name={field.name}
                  disabled={locked}
                  onRemove={fields.length > 1 ? () => remove(field.name) : undefined}
                />
              ))}
              <Button
                type="dashed"
                icon={<PlusOutlined />}
                disabled={locked || fields.length >= GIFT_CODE_MAX_REWARDS}
                onClick={() => add({ type: 'vip_icon' })}
                style={{ marginBottom: 8 }}
              >
                Thêm quà
              </Button>
              <Form.ErrorList errors={errors} />
            </>
          )}
        </Form.List>
        <Typography.Paragraph type="secondary" style={{ fontSize: 13 }}>
          Ngày VIP tính từ lúc nhận, đang có VIP thì cộng dồn. Icon giữ vĩnh viễn nhưng không chuyển được cho người khác.
        </Typography.Paragraph>

        <Divider titlePlacement="start" plain style={{ margin: '4px 0 16px' }}>
          Thông báo cho người nhận
        </Divider>
        <Form.Item
          name="successMessage"
          label="Lời nhắn khi nhận thành công"
          extra={
            <span>
              <Typography.Text code>{'{quà}'}</Typography.Text> tự thay bằng danh sách quà. Để trống thì dùng câu mặc định "Bạn
              nhận được {'{quà}'}."
            </span>
          }
        >
          <Input.TextArea rows={2} maxLength={GIFT_CODE_MESSAGE_MAX} showCount placeholder="vd: Chúc mừng năm mới! Bạn nhận được {quà}." />
        </Form.Item>
        <Form.Item name="sendNotification" valuePropName="checked" style={{ marginBottom: 4 }}>
          <Checkbox>Gửi thêm vào thông báo hệ thống của app</Checkbox>
        </Form.Item>
        <Typography.Paragraph type="secondary" style={{ fontSize: 13, marginLeft: 24 }}>
          Để người nhận xem lại được, kể cả khi đóng hộp thoại quá nhanh.
        </Typography.Paragraph>
        <div style={{ marginBottom: 20 }}>
          <GiftCodeSuccessPreview message={preview} rewards={rewards} notify={sendNotification} />
        </div>

        <Divider titlePlacement="start" plain style={{ margin: '4px 0 16px' }}>
          Điều kiện
        </Divider>
        <Alert
          type="info"
          showIcon
          style={{ marginBottom: 16 }}
          title={
            <span>
              Yêu cầu xác thực email áp dụng chung cho mọi đợt, bật tắt ở <Link to="/gift-codes/settings">Cài đặt</Link>.
            </span>
          }
        />
        <Row gutter={16}>
          <Col xs={24} md={10}>
            <Form.Item name="minAccountAgeDays" label="Tuổi tài khoản tối thiểu" extra="Chặn nick mới tạo để nhận mã.">
              <InputNumber min={0} max={365} addonAfter="ngày" style={{ width: '100%' }} />
            </Form.Item>
          </Col>
          <Col xs={24} md={14}>
            <Form.Item
              name="platforms"
              label="Nền tảng được nhập mã"
              extra="iOS nên tắt: Apple không cho dùng mã để mở khoá nội dung. Người dùng iPhone nhập trên web."
              rules={[{ required: true, type: 'array', min: 1, message: 'Chọn ít nhất một nền tảng' }]}
            >
              <Checkbox.Group options={GIFT_CODE_PLATFORM_OPTIONS} />
            </Form.Item>
          </Col>
        </Row>
        <Form.Item
          name="onePerDevice"
          valuePropName="checked"
          label="Chống nhiều nick"
          extra="Theo mã máy của app. Trên web là mã trình duyệt, xoá dữ liệu trình duyệt là đổi được, nên web chỉ chặn được người dùng bình thường."
        >
          <Checkbox>Mỗi thiết bị chỉ nhận 1 lần trong đợt</Checkbox>
        </Form.Item>
        <Form.Item name="enabled" valuePropName="checked" label="Bật đợt">
          <Switch />
        </Form.Item>

        <Alert
          type="info"
          showIcon
          style={{ marginBottom: 20 }}
          title={
            kind === 'shared' ? (
              <span>
                Mã <b>{code || '…'}</b> dùng được cho <b>{formatCount(totalUses || 0)} người</b>, {perText}, từ {timeText}. Mỗi
                người nhận <b>{giftText}</b>.
              </span>
            ) : (
              <span>
                {isEdit ? 'Đợt có' : 'Sinh'} <b>{formatCount(totalUses || 0)} mã</b> dạng <b>{sample}</b>, mỗi mã dùng 1 lần, {perText},
                từ {timeText}. Mỗi người nhận <b>{giftText}</b>.
              </span>
            )
          }
        />
        <Space>
          <Button type="primary" icon={<SaveOutlined />} loading={save.isPending} onClick={() => void submit()}>
            {isEdit ? 'Lưu' : 'Tạo đợt'}
          </Button>
          <Button onClick={() => navigate(backTo)}>Huỷ</Button>
        </Space>
      </Form>
    </Card>
  )
}

function RewardRow({ name, disabled, onRemove }: { name: number; disabled: boolean; onRemove?: () => void }) {
  const form = Form.useFormInstance<GiftCodeFormValues>()
  const type = Form.useWatch(['rewards', name, 'type'], form)
  return (
    <div style={{ display: 'flex', gap: 8, alignItems: 'flex-start' }}>
      <Form.Item name={[name, 'type']} style={{ width: 160, marginBottom: 12 }}>
        <Select disabled={disabled} options={REWARD_TYPE_OPTIONS} />
      </Form.Item>
      {type === 'vip_icon' ? (
        <Form.Item name={[name, 'vipIconId']} style={{ flex: 1, marginBottom: 12 }} rules={[{ required: true, message: 'Chọn icon VIP' }]}>
          <Select
            disabled={disabled}
            showSearch
            placeholder="Tìm và chọn icon VIP..."
            options={VIP_ICON_OPTIONS}
            filterOption={(input, option) => String(option?.name ?? '').toLowerCase().includes(input.toLowerCase())}
          />
        </Form.Item>
      ) : (
        <Form.Item name={[name, 'days']} style={{ flex: 1, marginBottom: 12 }} rules={[{ required: true, message: 'Nhập số ngày' }]}>
          <InputNumber disabled={disabled} min={1} max={3650} addonAfter="ngày" style={{ width: '100%' }} />
        </Form.Item>
      )}
      <Button type="text" danger icon={<DeleteOutlined />} disabled={disabled || onRemove == null} onClick={onRemove} />
    </div>
  )
}
