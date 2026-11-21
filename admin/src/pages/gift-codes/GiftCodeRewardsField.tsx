import { Button, Divider, Form, Typography } from 'antd'
import { PlusOutlined } from '@ant-design/icons'
import { RewardItemRow } from '@/components/RewardItemRow'
import { GIFT_CODE_MAX_REWARDS } from './constants'
import { cleanRewards } from './utils'

export function GiftCodeRewardsField({ locked }: { locked: boolean }) {
  return (
    <>
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
              <RewardItemRow
                key={field.key}
                path={['rewards']}
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
        Ngày VIP tính từ lúc nhận, đang có VIP thì cộng dồn. Icon và khung luôn bị khoá (không chuyển được cho người khác); để trống ô ngày thì giữ vĩnh viễn, nhập số ngày thì hết hạn sau từng ấy ngày kể từ lúc nhập mã.
        Khung cần còn VIP mới đeo được. Ai đã có sẵn khung thì chỉ nhận các quà còn lại; mã chỉ có khung thì họ không nhận được và không mất lượt.
        Vé loa: mỗi vé phát được 1 loa miễn phí, không chuyển được; để trống ô ngày thì vé không hạn, tối đa 365 ngày.
      </Typography.Paragraph>
    </>
  )
}
