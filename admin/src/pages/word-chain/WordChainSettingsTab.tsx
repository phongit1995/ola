import { App, Button, Form, InputNumber, Spin, Switch, Typography } from 'antd'
import { SaveOutlined } from '@ant-design/icons'
import { useAppSettings, usePutAppSetting } from '@/hooks/useAppSettings'
import { ApiError } from '@/lib/apiError'
import { kenNumberInputProps } from '@/lib/format'
import type { WordChainSetting } from '@/types'
import {
  WORD_CHAIN_PRICE_MAX,
  WORD_CHAIN_SETTING_KEY,
  wordChainSetting,
} from './wordChainMeta'

export function WordChainSettingsTab() {
  const { message, modal } = App.useApp()
  const { data: settings, isLoading, isError } = useAppSettings()
  const putSetting = usePutAppSetting()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
        <Spin />
      </div>
    )
  }

  if (isError) {
    return (
      <Typography.Text type="danger">
        Không tải được cấu hình hiện tại. Tải lại trang trước khi chỉnh sửa để tránh ghi đè nhầm.
      </Typography.Text>
    )
  }

  const current = wordChainSetting(settings)

  async function persist(values: WordChainSetting) {
    try {
      await putSetting.mutateAsync({
        key: WORD_CHAIN_SETTING_KEY,
        value: {
          enabled: values.enabled,
          hintPrice: values.hintPrice,
          guessPrice: values.guessPrice,
        },
      })
      message.success('Đã lưu cấu hình phòng nối từ')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
    }
  }

  function save(values: WordChainSetting) {
    if (current.enabled && !values.enabled) {
      modal.confirm({
        title: 'Ẩn phòng nối từ?',
        content:
          'Mục Phòng nối từ sẽ biến mất khỏi danh sách phòng. Người đang ở trong phòng sẽ không nối từ, mua gợi ý hay mua thêm lượt được nữa.',
        okText: 'Ẩn phòng',
        okButtonProps: { danger: true },
        cancelText: 'Huỷ',
        onOk: () => persist(values),
      })
      return
    }
    void persist(values)
  }

  return (
    <div style={{ maxWidth: 560 }}>
      <Typography.Paragraph type="secondary">
        Chưa lưu lần nào thì hệ thống dùng giá trị mặc định: hiển thị phòng, gợi ý 500 KEN mỗi lần
        và mua thêm lượt 500 KEN mỗi lần.
      </Typography.Paragraph>
      <Form<WordChainSetting> layout="vertical" initialValues={current} onFinish={save}>
        <Form.Item
          name="enabled"
          label="Hiển thị phòng nối từ"
          valuePropName="checked"
          extra="Tắt thì ẩn mục Phòng nối từ khỏi danh sách phòng, server từ chối vào phòng, nối từ, mua gợi ý và mua thêm lượt. Lịch sử, điểm và trận thắng vẫn giữ nguyên."
        >
          <Switch />
        </Form.Item>
        <Form.Item
          name="hintPrice"
          label="Giá mỗi lần gợi ý"
          rules={[{ required: true, message: 'Nhập giá gợi ý' }]}
          extra="Số KEN trừ mỗi lần người chơi bấm Gợi ý. Không tìm được từ gợi ý thì không trừ."
        >
          <InputNumber<number>
            min={1}
            max={WORD_CHAIN_PRICE_MAX}
            precision={0}
            suffix="KEN"
            style={{ width: 240 }}
            {...kenNumberInputProps}
          />
        </Form.Item>
        <Form.Item
          name="guessPrice"
          label="Giá mỗi lần mua thêm lượt"
          rules={[{ required: true, message: 'Nhập giá mua thêm lượt' }]}
          extra="Số KEN trừ mỗi lần người chơi đã hết 3 lượt đoán mua thêm 3 lượt cho từ đang trả lời. Lượt mua thêm chỉ dùng cho từ đó, từ đổi thì mất. Mua bao nhiêu lần cũng được."
        >
          <InputNumber<number>
            min={1}
            max={WORD_CHAIN_PRICE_MAX}
            precision={0}
            suffix="KEN"
            style={{ width: 240 }}
            {...kenNumberInputProps}
          />
        </Form.Item>
        <Button
          type="primary"
          htmlType="submit"
          icon={<SaveOutlined />}
          loading={putSetting.isPending}
        >
          Lưu cấu hình
        </Button>
      </Form>
    </div>
  )
}
