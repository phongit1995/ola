import { useMemo, useState } from 'react'
import {
  App,
  Button,
  Card,
  Form,
  InputNumber,
  Modal,
  Select,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import {
  useCreateVipShopItem,
  useDeleteVipShopItem,
  useUpdateVipShopItem,
  useVipShopItems,
} from '@/hooks/useVipShop'
import { ApiError } from '@/lib/apiError'
import { VIP_CATALOG, vipName } from '@/lib/vipCatalog'
import type { VipShopItem } from '@/types'

interface ShopFormValues {
  vipTypeId: number
  kenPrice: number
  sortOrder: number
  isActive: boolean
}

export function VipShopPage() {
  const { message, modal } = App.useApp()
  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<VipShopItem | null>(null)
  const [form] = Form.useForm<ShopFormValues>()

  const { data, isFetching } = useVipShopItems()
  const createItem = useCreateVipShopItem()
  const updateItem = useUpdateVipShopItem()
  const deleteItem = useDeleteVipShopItem()

  const items = data ?? []
  const isEdit = editing != null

  const availableTypes = useMemo(() => {
    const used = new Set(items.map((it) => it.vipTypeId))
    return VIP_CATALOG.filter((entry) => !used.has(entry.id))
  }, [items])

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
    form.setFieldsValue({ vipTypeId: undefined, kenPrice: 100, sortOrder: 0, isActive: true })
  }

  function openEdit(item: VipShopItem) {
    setEditing(item)
    setFormOpen(true)
    form.setFieldsValue({
      vipTypeId: item.vipTypeId,
      kenPrice: item.kenPrice,
      sortOrder: item.sortOrder,
      isActive: item.isActive,
    })
  }

  function toggleActive(item: VipShopItem, isActive: boolean) {
    updateItem.mutate(
      { id: item.id, payload: { isActive } },
      {
        onSuccess: () => message.success(isActive ? 'Đã bật bán' : 'Đã tắt bán'),
        onError: (err) =>
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại'),
      },
    )
  }

  function removeItem(item: VipShopItem) {
    modal.confirm({
      title: 'Gỡ VIP khỏi shop?',
      content: `${vipName(item.vipTypeId)} — sẽ không còn bán nữa.`,
      okText: 'Gỡ',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteItem.mutateAsync(item.id)
          message.success('Đã gỡ khỏi shop')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Gỡ thất bại')
        }
      },
    })
  }

  async function onOk() {
    const values = await form.validateFields()
    try {
      if (isEdit && editing) {
        await updateItem.mutateAsync({
          id: editing.id,
          payload: {
            kenPrice: values.kenPrice,
            sortOrder: values.sortOrder,
            isActive: values.isActive,
          },
        })
        message.success('Đã cập nhật')
      } else {
        await createItem.mutateAsync({
          vipTypeId: values.vipTypeId,
          kenPrice: values.kenPrice,
          sortOrder: values.sortOrder,
          isActive: values.isActive,
        })
        message.success('Đã thêm VIP vào shop')
      }
      setFormOpen(false)
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Lưu thất bại')
    }
  }

  const columns: TableColumnsType<VipShopItem> = [
    {
      title: 'VIP',
      dataIndex: 'vipTypeId',
      render: (typeId: number) => (
        <Space>
          <Tag>{typeId}</Tag>
          <Typography.Text strong>{vipName(typeId)}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 140,
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Thứ tự',
      dataIndex: 'sortOrder',
      width: 90,
    },
    {
      title: 'Đang bán',
      dataIndex: 'isActive',
      width: 110,
      render: (isActive: boolean, item) => (
        <Switch
          checked={isActive}
          loading={updateItem.isPending}
          onChange={(value) => toggleActive(item, value)}
        />
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 160,
      render: (_, item) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(item)}>
            Sửa
          </Button>
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeItem(item)} />
        </Space>
      ),
    },
  ]

  return (
    <Card>
      <div style={{ marginBottom: 16, display: 'flex', justifyContent: 'space-between' }}>
        <Typography.Text type="secondary">
          Chọn VIP để bán trong shop. Chỉ những VIP ở đây mới hiển thị cho người dùng mua.
        </Typography.Text>
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Thêm VIP
        </Button>
      </div>
      <Table<VipShopItem>
        rowKey="id"
        columns={columns}
        dataSource={items}
        loading={isFetching}
        scroll={{ x: 680 }}
        pagination={{ pageSize: 20, showTotal: (total) => `${total} VIP đang bán` }}
      />

      <Modal
        title={isEdit ? `Sửa: ${vipName(editing.vipTypeId)}` : 'Thêm VIP vào shop'}
        open={formOpen}
        onOk={onOk}
        onCancel={() => setFormOpen(false)}
        okText={isEdit ? 'Lưu' : 'Thêm'}
        cancelText="Huỷ"
        confirmLoading={createItem.isPending || updateItem.isPending}
        destroyOnHidden
      >
        <Form form={form} layout="vertical" requiredMark={false}>
          {!isEdit && (
            <Form.Item
              name="vipTypeId"
              label="Chọn VIP"
              rules={[{ required: true, message: 'Vui lòng chọn VIP' }]}
            >
              <Select
                showSearch
                placeholder="Tìm và chọn VIP..."
                optionFilterProp="label"
                options={availableTypes.map((entry) => ({
                  value: entry.id,
                  label: `#${entry.id} — ${entry.name}`,
                }))}
              />
            </Form.Item>
          )}
          <Form.Item
            name="kenPrice"
            label="Giá (KEN)"
            rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
          >
            <InputNumber min={0} style={{ width: '100%' }} placeholder="100" />
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
