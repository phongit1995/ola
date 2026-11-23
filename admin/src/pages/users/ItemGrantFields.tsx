import { Checkbox, Form, InputNumber } from 'antd'
import { ITEM_GRANT_MAX_DAYS } from './constants'

export function ItemGrantFields() {
  const form = Form.useFormInstance()
  const expiresInDays = Form.useWatch('expiresInDays', form) as number | null | undefined
  const timed = (expiresInDays ?? 0) > 0

  return (
    <>
      <Form.Item
        name="expiresInDays"
        label="Hạn (ngày)"
        extra="Để trống = vĩnh viễn. Món có hạn luôn bị khoá, hết hạn tự tháo và ẩn khỏi kho của user."
      >
        <InputNumber
          min={0}
          max={ITEM_GRANT_MAX_DAYS}
          precision={0}
          placeholder="Vĩnh viễn"
          style={{ width: '100%' }}
          onChange={(value) => {
            if ((value ?? 0) > 0) form.setFieldValue('locked', true)
          }}
        />
      </Form.Item>
      <Form.Item name="locked" valuePropName="checked" style={{ marginBottom: 0 }}>
        <Checkbox disabled={timed}>Khoá (không cho chuyển, tặng lại, giao dịch)</Checkbox>
      </Form.Item>
    </>
  )
}
