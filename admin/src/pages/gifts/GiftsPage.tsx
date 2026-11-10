import { useCallback, useState } from 'react'
import {
  App,
  Button,
  Card,
  Image,
  Select,
  Space,
  Switch,
  Typography,
  type TableColumnsType,
} from 'antd'
import {
  DeleteOutlined,
  EditOutlined,
  PlusOutlined,
} from '@ant-design/icons'
import { GiftFormModal } from './GiftFormModal'
import { useDeleteGift, useGiftOrder, useGifts, useUpdateGift } from './useGiftQueries'
import { GiftAnimationPreview } from './GiftAnimationPreview'
import type { GiftPreview } from './types'
import { GIFT_ANIMATION_OPTIONS } from './constants'
import { GIFT_ANIMATION_RANDOM } from '@ola/shared/constants'
import { pickGiftAnimation, toGiftAnimationSetting } from '@ola/shared/lib'
import { MoveToTopButton, RenumberButton } from '@/components/ListOrderButtons'
import { SortableTable } from '@/components/SortableTable'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { GIFT_SECTION_LINKS } from '@/pages/shop/sections'
import { errorMessage } from '@/lib/apiError'
import { formatCount } from '@/lib/format'
import type { GiftAnimationSetting } from '@ola/shared/types'
import type { AdminGift, UpdateGiftRequest } from '@/types'

const GIFT_THUMB_SIZE = 44
const GIFT_THUMB_BUTTON_STYLE = {
  padding: 0,
  border: 0,
  background: 'none',
  cursor: 'pointer',
  lineHeight: 0,
}

export function GiftsPage() {
  const { message, modal } = App.useApp()
  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<AdminGift | null>(null)
  const [preview, setPreview] = useState<GiftPreview | null>(null)
  const { data, isFetching } = useGifts()
  const updateGift = useUpdateGift()
  const deleteGift = useDeleteGift()
  const gifts = data ?? []
  const order = useGiftOrder(gifts)
  const closePreview = useCallback(() => setPreview(null), [])

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
  }

  function openEdit(gift: AdminGift) {
    setEditing(gift)
    setFormOpen(true)
  }

  function savingField(gift: AdminGift, field: 'isActive' | 'announceEnabled') {
    const saving = updateGift.variables
    return updateGift.isPending && saving?.id === gift.id && saving.payload[field] !== undefined
  }

  function saveToggle(gift: AdminGift, payload: UpdateGiftRequest, successText: string) {
    updateGift.mutate(
      { id: gift.id, payload },
      {
        onSuccess: () => message.success(successText),
        onError: (err) => message.error(errorMessage(err, 'Thao tác thất bại')),
      },
    )
  }

  function toggleAnnounce(gift: AdminGift, announceEnabled: boolean) {
    saveToggle(gift, { announceEnabled }, announceEnabled ? 'Đã bật loa' : 'Đã tắt loa')
  }

  function toggleActive(gift: AdminGift, isActive: boolean) {
    saveToggle(gift, { isActive }, isActive ? 'Đã bật bán' : 'Đã tắt bán')
  }

  function animationOf(gift: AdminGift): GiftAnimationSetting {
    const pending =
      updateGift.isPending && updateGift.variables?.id === gift.id
        ? updateGift.variables.payload.animation
        : undefined
    return pending ?? toGiftAnimationSetting(gift.animation) ?? GIFT_ANIMATION_RANDOM
  }

  function changeAnimation(gift: AdminGift, animation: GiftAnimationSetting) {
    updateGift.mutate(
      { id: gift.id, payload: { animation } },
      {
        onSuccess: () => message.success('Đã đổi hiệu ứng'),
        onError: (err) => message.error(errorMessage(err, 'Thao tác thất bại')),
      },
    )
  }

  function playPreview(gift: AdminGift) {
    setPreview({
      imageUrl: gift.imageUrl,
      name: gift.name,
      animation: pickGiftAnimation(animationOf(gift), Math.random(), null),
    })
  }

  function removeGift(gift: AdminGift) {
    modal.confirm({
      title: 'Xoá quà?',
      content: `${gift.name} sẽ không còn bán. Tường quà và lịch sử của người dùng vẫn giữ nguyên.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteGift.mutateAsync(gift.id)
          message.success('Đã xoá quà')
        } catch (err) {
          message.error(errorMessage(err, 'Xoá thất bại'))
        }
      },
    })
  }

  const columns: TableColumnsType<AdminGift> = [
    {
      title: 'Quà',
      key: 'gift',
      width: 190,
      render: (_, gift) => (
        <Space>
          <button
            type="button"
            title="Bấm để xem hiệu ứng"
            aria-label={`Xem hiệu ứng ${gift.name}`}
            style={GIFT_THUMB_BUTTON_STYLE}
            onClick={() => playPreview(gift)}
          >
            <Image
              src={gift.imageUrl}
              width={GIFT_THUMB_SIZE}
              height={GIFT_THUMB_SIZE}
              style={{ objectFit: 'contain' }}
              preview={false}
            />
          </button>
          <div>
            <Typography.Text strong>{gift.name}</Typography.Text>
            {gift.nameEn ? (
              <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
                {gift.nameEn}
              </Typography.Text>
            ) : null}
          </div>
        </Space>
      ),
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 100,
      align: 'right',
      render: (value: number) => formatCount(value),
    },
    {
      title: 'Sức hút',
      dataIndex: 'charmPoints',
      width: 90,
      align: 'right',
      render: (value: number) => formatCount(value),
    },
    {
      title: 'Người tặng được',
      dataIndex: 'senderCharmPercent',
      width: 110,
      align: 'right',
      render: (value: number) => (value > 0 ? `${value}%` : 'Tắt'),
    },
    {
      title: 'Hiệu ứng',
      key: 'animation',
      width: 200,
      render: (_, gift) => (
        <Select<GiftAnimationSetting>
          size="small"
          style={{ width: '100%' }}
          value={animationOf(gift)}
          options={GIFT_ANIMATION_OPTIONS}
          onChange={(animation) => changeAnimation(gift, animation)}
        />
      ),
    },
    {
      title: 'Thứ tự',
      dataIndex: 'sortOrder',
      width: 75,
      align: 'right',
    },
    {
      title: 'Đang bán',
      dataIndex: 'isActive',
      width: 95,
      render: (isActive: boolean, gift) => (
        <Switch
          checked={isActive}
          loading={savingField(gift, 'isActive')}
          onChange={(value) => toggleActive(gift, value)}
        />
      ),
    },
    {
      title: 'Loa',
      dataIndex: 'announceEnabled',
      width: 80,
      render: (announceEnabled: boolean, gift) => (
        <Switch
          checked={announceEnabled}
          loading={savingField(gift, 'announceEnabled')}
          onChange={(value) => toggleAnnounce(gift, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 180,
      render: (_, gift) => (
        <Space>
          <MoveToTopButton
            name={gift.name}
            disabled={order.isFirst(gift) || order.saving}
            onClick={() => order.moveToTop(gift)}
          />
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(gift)}>
            Sửa
          </Button>
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeGift(gift)} />
        </Space>
      ),
    },
  ]

  return (
    <Card
      title={<ShopSectionNav links={GIFT_SECTION_LINKS} />}
      extra={
        <Space>
          <RenumberButton disabled={order.numbered || order.saving} onClick={order.renumber} />
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Thêm quà
          </Button>
        </Space>
      }
    >
      <Typography.Paragraph type="secondary">
        Quà người dùng tặng nhau trong chat 1-1 và trang cá nhân. Người tặng trả KEN, người nhận
        được sức hút và quà hiện trên tường quà (không nhận KEN).
      </Typography.Paragraph>
      <SortableTable<AdminGift>
        items={gifts}
        columns={columns}
        loading={isFetching}
        scroll={{ x: 1090 }}
        pagination={false}
        footer={() => `${gifts.length} món quà. Kéo biểu tượng đầu dòng để đổi thứ tự.`}
        locale={{ emptyText: 'Chưa có quà nào, bấm "Thêm quà" để tạo' }}
        reorderDisabled={order.saving}
        onReorder={order.save}
      />
      <GiftFormModal
        open={formOpen}
        gift={editing}
        nextPosition={order.nextPosition}
        onClose={() => setFormOpen(false)}
      />
      {preview != null && (
        <GiftAnimationPreview preview={preview} onClose={closePreview} />
      )}
    </Card>
  )
}
