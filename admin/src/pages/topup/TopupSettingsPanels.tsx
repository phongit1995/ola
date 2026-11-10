import { Button, Col, Form, Input, InputNumber, Row, Select, Space, Switch, Typography } from 'antd'
import { DeleteOutlined, PlusOutlined } from '@ant-design/icons'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import { env } from '@/config/env'
import { VIETQR_BANKS } from '@/lib/banks'
import { BONUS_PERCENT_MAX, NEW_TIER, TOPUP_MEMO_PREVIEW_USERNAME } from './constants'
import { formatThousands, parseThousands, topupMemoPreview } from './utils'
import type { TopupSettingsFormValues } from './types'

export function TopupDisplayPanel() {
  return (
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
  )
}

export function TopupBankPanel() {
  const form = Form.useFormInstance<TopupSettingsFormValues>()
  const memoTemplate = Form.useWatch('memoTemplate', form)
  return (
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
              User @{TOPUP_MEMO_PREVIEW_USERNAME} sẽ thấy: <Typography.Text code>{topupMemoPreview(memoTemplate)}</Typography.Text>
            </Typography.Text>
          </Space>
        }
      >
        <Input placeholder="@{username}" maxLength={50} />
      </Form.Item>
    </>
  )
}

export function TopupAmountsPanel() {
  return (
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
  )
}

export function TopupIntegrationsPanel() {
  return (
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
  )
}
