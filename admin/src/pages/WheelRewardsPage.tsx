import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { App, Button, Card, Space, Table, Tag, Typography } from 'antd'
import type { ColumnsType } from 'antd/es/table'
import {
  BarChartOutlined,
  DeleteOutlined,
  EditOutlined,
  HistoryOutlined,
  PlusOutlined,
} from '@ant-design/icons'
import { useDeleteWheel, useWheels } from '@/hooks/useWheel'
import { ApiError } from '@/lib/apiError'
import type { Wheel } from '@/types'
import { WheelEditorModal } from './WheelEditorModal'
import { WheelHistoryModal } from './WheelHistoryModal'

export function WheelRewardsPage() {
  const { message, modal } = App.useApp()
  const navigate = useNavigate()
  const { data: apiWheels, isFetching } = useWheels()
  const deleteWheel = useDeleteWheel()

  const [editorOpen, setEditorOpen] = useState(false)
  const [editingWheel, setEditingWheel] = useState<Wheel | null>(null)
  const [historyOpen, setHistoryOpen] = useState(false)

  const wheels = apiWheels ?? []

  function openCreate() {
    setEditingWheel(null)
    setEditorOpen(true)
  }

  function openEdit(wheel: Wheel) {
    setEditingWheel(wheel)
    setEditorOpen(true)
  }

  function removeWheel(wheel: Wheel) {
    modal.confirm({
      title: 'Xoá vòng quay?',
      content: `${wheel.name} — xoá cả các ô và lựa chọn bên trong.`,
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await deleteWheel.mutateAsync(wheel.id)
          message.success('Đã xoá vòng quay')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: ColumnsType<Wheel> = [
    {
      title: 'Vòng quay',
      dataIndex: 'name',
      render: (name: string) => (
        <Space>
          <span style={{ fontSize: 18 }}>🎡</span>
          <Typography.Text strong>{name}</Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Giá/lượt',
      dataIndex: 'kenCost',
      width: 130,
      align: 'right',
      render: (value: number) => `${value.toLocaleString('vi-VN')} Ken`,
    },
    {
      title: 'Free/ngày',
      dataIndex: 'freeDailyEnabled',
      width: 110,
      align: 'center',
      render: (enabled: boolean) => (
        <Tag color={enabled ? 'blue' : 'default'}>{enabled ? 'Bật' : 'Tắt'}</Tag>
      ),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'isEnabled',
      width: 120,
      align: 'center',
      render: (enabled: boolean) => (
        <Tag color={enabled ? 'green' : 'default'}>{enabled ? 'Đang bật' : 'Tắt'}</Tag>
      ),
    },
    {
      title: 'Số ô',
      key: 'segments',
      width: 80,
      align: 'center',
      render: (_, wheel) => wheel.segments?.length ?? 0,
    },
    {
      title: '',
      key: 'actions',
      width: 90,
      align: 'right',
      render: (_, wheel) => (
        <Space size={2}>
          <Button
            size="small"
            type="text"
            icon={<EditOutlined />}
            onClick={(e) => {
              e.stopPropagation()
              openEdit(wheel)
            }}
          />
          <Button
            size="small"
            type="text"
            danger
            icon={<DeleteOutlined />}
            onClick={(e) => {
              e.stopPropagation()
              removeWheel(wheel)
            }}
          />
        </Space>
      ),
    },
  ]

  return (
    <Card
      title="Vòng quay may mắn"
      extra={
        <Space>
          <Button icon={<BarChartOutlined />} onClick={() => navigate('/games/wheel/stats')}>
            Thống kê
          </Button>
          <Button icon={<HistoryOutlined />} onClick={() => setHistoryOpen(true)}>
            Lịch sử quay
          </Button>
          <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
            Thêm vòng quay
          </Button>
        </Space>
      }
    >
      <Table<Wheel>
        rowKey="id"
        loading={isFetching && wheels.length === 0}
        columns={columns}
        dataSource={wheels}
        pagination={false}
        locale={{ emptyText: 'Chưa có vòng quay — bấm "Thêm vòng quay" để tạo' }}
        onRow={(wheel) => ({
          onClick: () => openEdit(wheel),
          style: { cursor: 'pointer' },
        })}
      />

      <WheelEditorModal
        open={editorOpen}
        wheel={editingWheel}
        nextSortOrder={wheels.length}
        onClose={() => setEditorOpen(false)}
      />

      <WheelHistoryModal open={historyOpen} onClose={() => setHistoryOpen(false)} />
    </Card>
  )
}
