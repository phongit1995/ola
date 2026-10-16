import { useState } from 'react'
import {
  App,
  Button,
  Card,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { CrownOutlined, DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import { useDeleteVipPackage, useUpdateVipPackage, useVipPackages } from '@/hooks/useVipPackages'
import { ApiError } from '@/lib/apiError'
import { VipPackageFormModal } from './VipPackageFormModal'
import type { VipPackage } from '@/types'

const PAGE_SIZE = 50

export function VipPackagesPage() {
  const { message, modal } = App.useApp()
  const [page, setPage] = useState(1)

  const [formOpen, setFormOpen] = useState(false)
  const [editing, setEditing] = useState<VipPackage | null>(null)

  const { data, isFetching } = useVipPackages({
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
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
          message.error(err instanceof ApiError ? err.message : 'Thao tác thất bại')
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
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
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
      width: 160,
      render: (_, pkg) => (
        <Space>
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
    <Card>
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          justifyContent: 'flex-end',
        }}
      >
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Tạo gói VIP
        </Button>
      </div>
      <Table<VipPackage>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching}
        scroll={{ x: 720 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} gói`,
          onChange: setPage,
        }}
      />
      <VipPackageFormModal open={formOpen} pkg={editing} onClose={() => setFormOpen(false)} />
    </Card>
  )
}
