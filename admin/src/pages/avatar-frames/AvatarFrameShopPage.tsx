import { useEffect, useMemo, useState } from 'react'
import {
  App,
  Button,
  Card,
  Form,
  Input,
  InputNumber,
  Modal,
  Select,
  Space,
  Switch,
  Table,
  Typography,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import { errorMessage } from '@/lib/apiError'
import { formatCount, kenNumberInputProps } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { AvatarFrameShopItem } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { AVATAR_FRAME_SECTION_LINKS } from '@/pages/shop/sections'
import { AddAvatarFramesModal } from './AddAvatarFramesModal'
import { AvatarFrameCell } from './AvatarFrameCell'
import {
  useAvatarFrameShopItems,
  useDeleteAvatarFrameShopItem,
  useUpdateAvatarFrameShopItem,
} from './useAvatarFrameQueries'
import { AVATAR_FRAME_SHOP_STATUS_OPTIONS } from './constants'
import { avatarFrameName, matchesAvatarFrameQuery } from './utils'
import { avatarFrameById } from '@ola/shared/lib/avatarFrame'

interface EditFormValues {
  kenPrice: number
  sortOrder: number
  isActive: boolean
}

type StatusFilter = 'active' | 'inactive'

export function AvatarFrameShopPage() {
  const { message, modal } = App.useApp()
  const [addOpen, setAddOpen] = useState(false)
  const [editing, setEditing] = useState<AvatarFrameShopItem | null>(null)
  const [search, setSearch] = useState('')
  const [status, setStatus] = useState<StatusFilter | undefined>()
  const [form] = Form.useForm<EditFormValues>()

  useEffect(() => {
    if (editing) {
      form.setFieldsValue({
        kenPrice: editing.kenPrice,
        sortOrder: editing.sortOrder,
        isActive: editing.isActive,
      })
    }
  }, [editing, form])

  const { data, isFetching } = useAvatarFrameShopItems()
  const updateItem = useUpdateAvatarFrameShopItem()
  const deleteItem = useDeleteAvatarFrameShopItem()

  const items = useMemo(() => data ?? [], [data])
  const shopFrameIds = useMemo(() => new Set(items.map((it) => it.frameId)), [items])
  const activeCount = items.filter((it) => it.isActive).length

  const filtered = useMemo(() => {
    const q = search.trim().toLowerCase()
    return items.filter((it) => {
      if (status === 'active' && !it.isActive) return false
      if (status === 'inactive' && it.isActive) return false
      if (!q) return true
      const frame = avatarFrameById(it.frameId)
      return frame ? matchesAvatarFrameQuery(frame, q) : it.frameId.includes(q)
    })
  }, [items, search, status])

  function toggleActive(item: AvatarFrameShopItem, isActive: boolean) {
    updateItem.mutate(
      { id: item.id, payload: { isActive } },
      {
        onSuccess: () => message.success(isActive ? 'Đã bật bán' : 'Đã tắt bán'),
        onError: (err) => message.error(errorMessage(err, 'Thao tác thất bại')),
      },
    )
  }

  function removeItem(item: AvatarFrameShopItem) {
    modal.confirm({
      title: 'Gỡ khung khỏi cửa hàng?',
      content: `${avatarFrameName(item.frameId)} (#${item.frameId}) sẽ không còn bán nữa. Người đã mua vẫn giữ khung.`,
      okText: 'Gỡ',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteItem.mutateAsync(item.id)
          message.success('Đã gỡ khỏi cửa hàng')
        } catch (err) {
          message.error(errorMessage(err, 'Gỡ thất bại'))
        }
      },
    })
  }

  async function onEditOk() {
    if (!editing) return
    const values = await form.validateFields()
    try {
      await updateItem.mutateAsync({
        id: editing.id,
        payload: {
          kenPrice: values.kenPrice,
          sortOrder: values.sortOrder ?? 0,
          isActive: values.isActive,
        },
      })
      message.success('Đã cập nhật')
      setEditing(null)
    } catch (err) {
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  const columns: TableColumnsType<AvatarFrameShopItem> = [
    {
      title: 'Khung',
      dataIndex: 'frameId',
      render: (frameId: string) => <AvatarFrameCell frameId={frameId} size={56} />,
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 140,
      sorter: (a, b) => a.kenPrice - b.kenPrice,
      render: (v: number) => <Typography.Text strong>{formatCount(v)}</Typography.Text>,
    },
    {
      title: 'Thứ tự',
      dataIndex: 'sortOrder',
      width: 100,
      sorter: (a, b) => a.sortOrder - b.sortOrder,
    },
    {
      title: 'Đang bán',
      dataIndex: 'isActive',
      width: 110,
      render: (isActive: boolean, item) => (
        <Switch
          checked={isActive}
          loading={updateItem.isPending && updateItem.variables?.id === item.id}
          onChange={(value) => toggleActive(item, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 150,
      render: (_, item) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => setEditing(item)}>
            Sửa
          </Button>
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeItem(item)} />
        </Space>
      ),
    },
  ]

  return (
    <Card title={<ShopSectionNav links={AVATAR_FRAME_SECTION_LINKS} />}>
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          flexWrap: 'wrap',
          gap: 12,
          justifyContent: 'space-between',
        }}
      >
        <Space wrap>
          <Input.Search
            allowClear
            placeholder="Tìm theo mã hoặc tên khung"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            style={{ width: 280 }}
          />
          <Select<StatusFilter>
            allowClear
            placeholder="Trạng thái"
            value={status}
            onChange={setStatus}
            options={AVATAR_FRAME_SHOP_STATUS_OPTIONS}
            style={{ width: 140 }}
          />
          <Typography.Text type="secondary">
            {formatCount(activeCount)} đang bán / {formatCount(items.length)} khung trong cửa hàng
          </Typography.Text>
        </Space>
        <Button type="primary" icon={<PlusOutlined />} onClick={() => setAddOpen(true)}>
          Thêm khung
        </Button>
      </div>
      <Table<AvatarFrameShopItem>
        rowKey="id"
        columns={columns}
        dataSource={filtered}
        loading={isFetching}
        scroll={{ x: 680 }}
        pagination={{
          pageSize: PAGE_SIZE,
          showSizeChanger: false,
          showTotal: (total) => `${formatCount(total)} khung`,
        }}
        locale={{ emptyText: 'Chưa có khung nào trong cửa hàng' }}
      />

      <AddAvatarFramesModal
        open={addOpen}
        shopFrameIds={shopFrameIds}
        onClose={() => setAddOpen(false)}
      />

      <Modal
        title={editing ? `Sửa: ${avatarFrameName(editing.frameId)} (#${editing.frameId})` : ''}
        open={editing != null}
        onOk={onEditOk}
        onCancel={() => setEditing(null)}
        okText="Lưu"
        cancelText="Huỷ"
        confirmLoading={updateItem.isPending}
        destroyOnHidden
      >
        {editing && (
          <div style={{ display: 'flex', justifyContent: 'center', marginBottom: 16 }}>
            <AvatarFrameCell frameId={editing.frameId} size={96} />
          </div>
        )}
        <Form form={form} layout="vertical" requiredMark={false}>
          <Form.Item
            name="kenPrice"
            label="Giá (KEN)"
            rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
          >
            <InputNumber min={0} style={{ width: '100%' }} {...kenNumberInputProps} />
          </Form.Item>
          <Form.Item name="sortOrder" label="Thứ tự sắp xếp (nhỏ hơn hiển thị trước)">
            <InputNumber min={0} style={{ width: '100%' }} placeholder="0" />
          </Form.Item>
          <Form.Item name="isActive" label="Đang bán" valuePropName="checked">
            <Switch />
          </Form.Item>
        </Form>
      </Modal>
    </Card>
  )
}
