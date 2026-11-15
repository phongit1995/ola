import { Form, Typography } from 'antd'
import type { FormInstance } from 'antd'
import { PlatformRulesTable } from '@/components/PlatformRulesTable'
import type { PlatformRules } from '@/types'

export interface OddsVisibilityValues {
  oddsVisibility: PlatformRules
}

interface OddsVisibilityFieldProps {
  form: FormInstance<OddsVisibilityValues>
  initial: PlatformRules
}

export function OddsVisibilityField({ form, initial }: OddsVisibilityFieldProps) {
  return (
    <Form form={form} component={false} initialValues={{ oddsVisibility: initial }}>
      <Typography.Text strong style={{ display: 'block', marginBottom: 4 }}>
        Hiện tỷ lệ % trong danh sách quà
      </Typography.Text>
      <Typography.Paragraph type="secondary" style={{ marginBottom: 8 }}>
        Tắt nền tảng nào thì server không gửi tỷ lệ cho nền tảng đó, app bản cũ cũng tự ẩn. Apple và Google Play yêu
        cầu công bố tỷ lệ cho phần thưởng ngẫu nhiên mất phí, cân nhắc trước khi tắt Android/iOS.
      </Typography.Paragraph>
      <PlatformRulesTable name={['oddsVisibility']} />
    </Form>
  )
}
