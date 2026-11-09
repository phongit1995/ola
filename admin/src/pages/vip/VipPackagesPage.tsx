import { useState } from 'react'
import {
  App,
  Button,
  Card,
  Space,
  Switch,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { CrownOutlined, DeleteOutlined, EditOutlined, PlusOutlined, SettingOutlined } from '@ant-design/icons'
import {
  useDeleteVipPackage,
  useUpdateVipPackage,
  useVipPackageOrder,
  useVipPackages,
} from './useVipPackageQueries'
import { MoveToTopButton, RenumberButton } from '@/components/ListOrderButtons'
import { SortableTable } from '@/components/SortableTable'
import { errorMessage } from '@/lib/apiError'
import { VipDayTransferSettingsModal } from './VipDayTransferSettingsModal'
import { VipPackageFormModal } from './VipPackageFormModal'
import type { VipPackage } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { VIP_SECTION_LINKS } from '@/pages/shop/sections'

export function VipPackagesPage() {
  const { message, modal } = App.useApp()
  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<VipPackage | null>(null)
  const [transferSettingsOpen, setTransferSettingsOpen] = useState(false)

  const { data, isFetching } = useVipPackages()
  const packages = data ?? []
  const order = useVipPackageOrder(packages)
  const updatePackage = useUpdateVipPackage()
  const deletePackage = useDeleteVipPackage()

  function openCreate() {
    setEditing(null)
    setFormOpen(true)
  }

  function openEdit(pkg: VipPackage) {
    setEditing(pkg)
    setFormOpen(true)
  }

  function toggleActive(pkg: VipPackage, isActive: boolean) {
    modal.confirm({
      title: isActive ? 'Bật gói này?' : 'Tắt gói này?',
      content: isActive
        ? 'Gói sẽ hiển thị cho người dùng mua.'
        : 'Gói sẽ bị ẩn, người dùng không mua được.',
      okText: isActive ? 'Bật' : 'Tắt',
      okButtonProps: { danger: !isActive },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await updatePackage.mutateAsync({ id: pkg.id, payload: { isActive } })
          message.success(isActive ? 'Đã bật gói' : 'Đã tắt gói')
        } catch (err) {
          message.error(errorMessage(err, 'Thao tác thất bại'))
        }
      },
    })
  }

  function removePackage(pkg: VipPackage) {
    modal.confirm({
      title: 'Xoá gói VIP?',
      content: `${pkg.name} — hành động này không thể hoàn tác.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deletePackage.mutateAsync(pkg.id)
          message.success('Đã xoá gói VIP')
        } catch (err) {
          message.error(errorMessage(err, 'Xoá thất bại'))
        }
      },
    })
  }

  const columns: TableColumnsType<VipPackage> = [
    {
      title: 'Gói VIP',
      dataIndex: 'name',
      render: (_, pkg) => (
        <Space>
          <CrownOutlined style={{ color: '#faad14', fontSize: 18 }} />
          <Typography.Text strong>{pkg.name}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Số ngày',
      dataIndex: 'days',
      width: 120,
      render: (v: number) => `${v} ngày`,
    },
    {
      title: 'Giá (KEN)',
      dataIndex: 'kenPrice',
      width: 130,
      render: (v: number) => v.toLocaleString('vi-VN'),
    },
    {
      title: 'Thứ tự',
      dataIndex: 'sortOrder',
      width: 90,
      render: (v: number) => v ?? 0,
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isActive',
      width: 130,
      render: (isActive: boolean, pkg) => (
        <Space>
          <Switch
            checked={isActive}
            loading={updatePackage.isPending}
            onChange={(value) => toggleActive(pkg, value)}
          />
          <Tag color={isActive ? 'green' : 'default'}>{isActive ? 'Bật' : 'Tắt'}</Tag>
        </Space>
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 200,
      render: (_, pkg) => (
        <Space>
          <MoveToTopButton
            name={pkg.name}
            disabled={order.isFirst(pkg) || order.saving}
            onClick={() => order.moveToTop(pkg)}
          />
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(pkg)}>
            Sửa
          </Button>
          <Button
            size="small"
            danger
            icon={<DeleteOutlined />}
            onClick={() => removePackage(pkg)}
          />
        </Space>
      ),
    },
  ]

  return (
    <Card title={<ShopSectionNav links={VIP_SECTION_LINKS} />}>
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          justifyContent: 'flex-end',
        }}
      >
        <Space>
          <RenumberButton disabled={order.numbered || order.saving} onClick={order.renumber} />
          <Button icon={<SettingOutlined />} onClick={() => setTransferSettingsOpen(true)}>
            Cài đặt chuyển NSD
          </Button>
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Tạo gói VIP
          </Button>
        </Space>
      </div>
      <SortableTable<VipPackage>
        items={packages}
        columns={columns}
        loading={isFetching}
        scroll={{ x: 810 }}
        pagination={false}
        footer={() => `${packages.length} gói. Kéo biểu tượng đầu dòng để đổi thứ tự.`}
        reorderDisabled={order.saving}
        onReorder={order.save}
      />
      <VipPackageFormModal
        open={formOpen}
        pkg={editing}
        nextPosition={order.nextPosition}
        onClose={() => setFormOpen(false)}
      />
      <VipDayTransferSettingsModal
        open={transferSettingsOpen}
        onClose={() => setTransferSettingsOpen(false)}
      />
    </Card>
  )
}
