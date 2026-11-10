import { useEffect } from 'react'
import { App, Button, Form, Image, Input, InputNumber, Modal, Select, Space, Switch, Upload } from 'antd'
import { UploadOutlined } from '@ant-design/icons'
import { useCreateGift, useUpdateGift } from './useGiftQueries'
import { PositionField } from '@/components/PositionField'
import { GIFT_ANIMATION_OPTIONS, GIFT_KEN_PRICE_MAX, GIFT_SENDER_CHARM_PERCENT_DEFAULT } from './constants'
import { GIFT_ANIMATION_RANDOM } from '@ola/shared/constants'
import { useImageUpload } from '@/hooks/useImageUpload'
import { errorMessage } from '@/lib/apiError'
import { kenNumberInputProps } from '@/lib/format'
import type { AdminGift, CreateGiftRequest } from '@/types'

interface GiftFormModalProps {
  open: boolean
  gift: AdminGift | null
  nextPosition: number
  onClose: () => void
}

type GiftFormValues = Required<CreateGiftRequest>

const GIFT_IMAGE_PREVIEW_SIZE = 96

export function GiftFormModal({ open, gift, nextPosition, onClose }: GiftFormModalProps) {
  const { message } = App.useApp()
  const [form] = Form.useForm<GiftFormValues>()
  const createGift = useCreateGift()
  const updateGift = useUpdateGift()
  const imageUpload = useImageUpload()
  const isEdit = gift != null
  const imageUrl = Form.useWatch('imageUrl', form)
  const kenPrice = Form.useWatch('kenPrice', form)

  useEffect(() => {
    if (open) {
      form.setFieldsValue({
        name: gift?.name ?? '',
        nameEn: gift?.nameEn ?? '',
        imageUrl: gift?.imageUrl ?? '',
        kenPrice: gift?.kenPrice ?? 10,
        charmPoints: gift?.charmPoints ?? 10,
        sortOrder: gift?.sortOrder ?? nextPosition,
        isActive: gift?.isActive ?? true,
        animation: gift?.animation ?? GIFT_ANIMATION_RANDOM,
        senderCharmPercent: gift?.senderCharmPercent ?? GIFT_SENDER_CHARM_PERCENT_DEFAULT,
        announceEnabled: gift?.announceEnabled ?? true,
      })
    }
  }, [open, gift, nextPosition, form])

  async function handleUpload(file: File) {
    try {
      const url = await imageUpload.mutateAsync(file)
      form.setFieldValue('imageUrl', url)
      void form.validateFields(['imageUrl'])
      message.success('Đã tải ảnh quà lên')
    } catch (err) {
      message.error(errorMessage(err, 'Tải ảnh thất bại'))
    }
  }

  async function onOk() {
    const values = await form.validateFields()
    try {
      if (isEdit && gift) {
        await updateGift.mutateAsync({ id: gift.id, payload: values })
        message.success('Đã cập nhật quà')
      } else {
        await createGift.mutateAsync(values)
        message.success('Đã thêm quà')
      }
      onClose()
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  return (
    <Modal
      title={isEdit ? `Sửa quà: ${gift.name}` : 'Thêm quà'}
      open={open}
      onOk={onOk}
      onCancel={onClose}
      okText={isEdit ? 'Lưu' : 'Thêm'}
      cancelText="Huỷ"
      confirmLoading={createGift.isPending || updateGift.isPending}
      destroyOnHidden
    >
      <Form form={form} layout="vertical" requiredMark={false}>
        <Form.Item label="Ảnh quà" required extra="PNG/WebP nền trong, khoảng 256×256.">
          <Space align="center" size={16}>
            {imageUrl ? (
              <Image
                src={imageUrl}
                width={GIFT_IMAGE_PREVIEW_SIZE}
                height={GIFT_IMAGE_PREVIEW_SIZE}
                style={{ objectFit: 'contain', background: '#f5f5f5', borderRadius: 8 }}
              />
            ) : null}
            <Upload
              accept="image/png,image/webp,image/jpeg,image/gif"
              showUploadList={false}
              beforeUpload={(file) => {
                void handleUpload(file)
                return false
              }}
            >
              <Button icon={<UploadOutlined />} loading={imageUpload.isPending}>
                {imageUrl ? 'Đổi ảnh' : 'Tải ảnh lên'}
              </Button>
            </Upload>
          </Space>
        </Form.Item>
        <Form.Item
          name="imageUrl"
          rules={[
            { required: true, message: 'Vui lòng tải ảnh quà' },
            { type: 'url', message: 'URL ảnh không hợp lệ' },
          ]}
          style={{ marginTop: -16 }}
        >
          <Input placeholder="Hoặc dán URL ảnh" />
        </Form.Item>
        <Space.Compact block>
          <Form.Item
            name="name"
            label="Tên (tiếng Việt)"
            rules={[
              { required: true, whitespace: true, message: 'Vui lòng nhập tên quà' },
              { max: 60, message: 'Tối đa 60 ký tự' },
            ]}
            style={{ flex: 1, marginRight: 12 }}
          >
            <Input placeholder="Hoa hồng" />
          </Form.Item>
          <Form.Item
            name="nameEn"
            label="Tên (tiếng Anh)"
            rules={[{ max: 60, message: 'Tối đa 60 ký tự' }]}
            style={{ flex: 1 }}
          >
            <Input placeholder="Rose" />
          </Form.Item>
        </Space.Compact>
        <Space.Compact block>
          <Form.Item
            name="kenPrice"
            label="Giá (KEN)"
            rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
            style={{ flex: 1, marginRight: 12 }}
          >
            <InputNumber
              min={1}
              max={GIFT_KEN_PRICE_MAX}
              precision={0}
              style={{ width: '100%' }}
              {...kenNumberInputProps}
            />
          </Form.Item>
          <Form.Item
            name="charmPoints"
            label="Sức hút người nhận được"
            rules={[{ required: true, message: 'Vui lòng nhập sức hút' }]}
            extra={
              <Button
                type="link"
                size="small"
                style={{ padding: 0 }}
                onClick={() => form.setFieldValue('charmPoints', kenPrice ?? 0)}
              >
                Bằng giá KEN
              </Button>
            }
            style={{ flex: 1 }}
          >
            <InputNumber min={0} precision={0} style={{ width: '100%' }} {...kenNumberInputProps} />
          </Form.Item>
        </Space.Compact>
        <Form.Item
          name="senderCharmPercent"
          label="Sức hút người tặng được (% so với người nhận)"
          rules={[{ required: true, message: 'Vui lòng nhập %' }]}
          extra="Ví dụ 50%: người nhận được 30 sức hút thì người tặng được 15 (làm tròn xuống). Đặt 0 để tắt."
        >
          <InputNumber min={0} max={100} precision={0} addonAfter="%" style={{ width: '100%' }} />
        </Form.Item>
        <Form.Item
          name="announceEnabled"
          label="Cho phép thông báo loa"
          valuePropName="checked"
          extra="Bật thì khi tặng quà này, người tặng được chọn thông báo cho mọi người. Thông báo cho người nhận không bị ảnh hưởng."
        >
          <Switch />
        </Form.Item>
        <Space.Compact block>
          <PositionField style={{ flex: 1, marginRight: 12 }} />
          <Form.Item name="isActive" label="Đang bán" valuePropName="checked" style={{ flex: 1 }}>
            <Switch />
          </Form.Item>
        </Space.Compact>
        <Form.Item
          name="animation"
          label="Hiệu ứng khi tặng"
          extra="Ngẫu nhiên: mỗi lần tặng chọn một kiểu bất kỳ trong 12 kiểu."
        >
          <Select options={GIFT_ANIMATION_OPTIONS} />
        </Form.Item>
      </Form>
    </Modal>
  )
}
