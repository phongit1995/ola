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
  useVipShopOrder,
} from './useVipShopQueries'
import { MoveToTopButton, RenumberButton } from '@/components/ListOrderButtons'
import { PositionField } from '@/components/PositionField'
import { SortableTable } from '@/components/SortableTable'
import { errorMessage } from '@/lib/apiError'
import { formatCount, kenNumberInputProps } from '@/lib/format'
import { VIP_CATALOG, vipIconUrl, vipName } from '@/lib/vipCatalog'
import type { VipShopItem } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { VIP_SECTION_LINKS } from '@/pages/shop/sections'

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

  const items = useMemo(() => data ?? [], [data])
  const order = useVipShopOrder(items)
  const isEdit = editing != null

  const availableTypes = useMemo(() => {
    const used = new Set(items.map((it) => it.vipTypeId))
    return VIP_CATALOG.filter((entry) => !used.has(entry.id))
  }, [items])

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
    form.setFieldsValue({
      vipTypeId: undefined,
      kenPrice: 100,
      sortOrder: order.nextPosition,
      isActive: true,
    })
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
          message.error(errorMessage(err, 'Thao tác thất bại')),
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
          message.error(errorMessage(err, 'Gỡ thất bại'))
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
      message.error(errorMessage(err, 'Lưu thất bại'))
    }
  }

  const columns: TableColumnsType<VipShopItem> = [
    {
      title: 'VIP',
      dataIndex: 'vipTypeId',
      render: (typeId: number) => (
        <Space>
          <img
            src={vipIconUrl(typeId)}
            alt={vipName(typeId)}
            width={36}
            height={36}
            style={{ objectFit: 'contain' }}
          />
          <Tag>{typeId}</Tag>
          <Typography.Text strong>{vipName(typeId)}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 140,
      render: (v: number) => formatCount(v),
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
      width: 200,
      render: (_, item) => (
        <Space>
          <MoveToTopButton
            name={vipName(item.vipTypeId)}
            disabled={order.isFirst(item) || order.saving}
            onClick={() => order.moveToTop(item)}
          />
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(item)}>
            Sửa
          </Button>
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeItem(item)} />
        </Space>
      ),
    },
  ]

  return (
    <Card title={<ShopSectionNav links={VIP_SECTION_LINKS} />}>
      <div style={{ marginBottom: 16, display: 'flex', justifyContent: 'space-between' }}>
        <Typography.Text type="secondary">
          Chọn VIP để bán trong shop. Chỉ những VIP ở đây mới hiển thị cho người dùng mua.
        </Typography.Text>
        <Space>
          <RenumberButton disabled={order.numbered || order.saving} onClick={order.renumber} />
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Thêm VIP
          </Button>
        </Space>
      </div>
      <SortableTable<VipShopItem>
        items={items}
        columns={columns}
        loading={isFetching}
        scroll={{ x: 770 }}
        pagination={false}
        footer={() => `${items.length} VIP đang bán. Kéo biểu tượng đầu dòng để đổi thứ tự.`}
        reorderDisabled={order.saving}
        onReorder={order.save}
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
                filterOption={(input, option) =>
                  String(option?.name ?? '').toLowerCase().includes(input.toLowerCase())
                }
                options={availableTypes.map((entry) => ({
                  value: entry.id,
                  name: `#${entry.id} ${entry.name}`,
                  label: (
                    <Space>
                      <img
                        src={vipIconUrl(entry.id)}
                        alt=""
                        width={22}
                        height={22}
                        style={{ objectFit: 'contain' }}
                      />
                      <span>
                        #{entry.id} — {entry.name}
                      </span>
                    </Space>
                  ),
                }))}
              />
            </Form.Item>
          )}
          <Form.Item
            name="kenPrice"
            label="Giá (KEN)"
            rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
          >
            <InputNumber min={0} style={{ width: '100%' }} placeholder="100" {...kenNumberInputProps} />
          </Form.Item>
          <PositionField />
          <Form.Item name="isActive" label="Đang bán" valuePropName="checked">
            <Switch />
          </Form.Item>
        </Form>
      </Modal>
    </Card>
  )
}
