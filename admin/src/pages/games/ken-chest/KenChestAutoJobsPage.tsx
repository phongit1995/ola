import { useState } from 'react'
import {
  App,
  Button,
  Space,
  Switch,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { DeleteOutlined, EditOutlined, PlusOutlined } from '@ant-design/icons'
import {
  useDeleteKenAutoJob,
  useKenAutoJobs,
  useKenAutoSettings,
  useUpdateKenAutoJob,
  useUpdateKenAutoSettings,
} from '@/hooks/useKenChests'
import { ApiError } from '@/lib/apiError'
import { formatDateTime } from '@/lib/format'
import { KenChestAutoJobModal } from './KenChestAutoJobModal'
import type { KenChestAutoJob, KenChestAutoJobRequest } from '@/types'

function jobToRequest(job: KenChestAutoJob): KenChestAutoJobRequest {
  return {
    name: job.name,
    enabled: job.enabled,
    scheduleType: job.scheduleType,
    intervalMinMinutes: job.intervalMinMinutes,
    intervalMaxMinutes: job.intervalMaxMinutes,
    dailyTimes: job.dailyTimes,
    rewardMode: job.rewardMode,
    kenAmount: job.kenAmount,
    kenMin: job.kenMin,
    kenMax: job.kenMax,
    maxRecipients: job.maxRecipients,
    durationSeconds: job.durationSeconds,
    remainingRuns: job.remainingRuns,
  }
}

function rewardText(job: KenChestAutoJob): string {
  if (job.rewardMode === 'fixed') {
    return `${(job.kenAmount ?? 0).toLocaleString('vi-VN')} KEN`
  }
  return `${(job.kenMin ?? 0).toLocaleString('vi-VN')} – ${(job.kenMax ?? 0).toLocaleString('vi-VN')} KEN`
}

function scheduleText(job: KenChestAutoJob): string {
  if (job.scheduleType === 'interval') {
    const min = job.intervalMinMinutes ?? 0
    const max = job.intervalMaxMinutes ?? 0
    return min === max ? `Mỗi ${min} phút` : `Mỗi ${min}–${max} phút`
  }
  return `Giờ: ${(job.dailyTimes ?? []).join(', ')}`
}

export function KenChestAutoJobs() {
  const { message, modal } = App.useApp()
  const [modalOpen, setModalOpen] = useState(false)
  const [editingJob, setEditingJob] = useState<KenChestAutoJob | null>(null)

  const { data: jobs, isFetching } = useKenAutoJobs()
  const { data: settings } = useKenAutoSettings()
  const updateSettings = useUpdateKenAutoSettings()
  const updateJob = useUpdateKenAutoJob()
  const deleteJob = useDeleteKenAutoJob()

  function openCreate() {
    setEditingJob(null)
    setModalOpen(true)
  }

  function openEdit(job: KenChestAutoJob) {
    setEditingJob(job)
    setModalOpen(true)
  }

  async function toggleMaster(enabled: boolean) {
    try {
      await updateSettings.mutateAsync(enabled)
      message.success(enabled ? 'Đã bật tất cả lịch tự động' : 'Đã tắt tất cả lịch tự động')
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Cập nhật thất bại')
    }
  }

  async function toggleJob(job: KenChestAutoJob, enabled: boolean) {
    try {
      await updateJob.mutateAsync({ id: job.id, payload: { ...jobToRequest(job), enabled } })
    } catch (err) {
      message.error(err instanceof ApiError ? err.message : 'Cập nhật thất bại')
    }
  }

  function removeJob(job: KenChestAutoJob) {
    modal.confirm({
      title: 'Xoá lịch tự động?',
      content: 'Các rương đã phát trước đó không bị ảnh hưởng.',
      okText: 'Xoá',
      okButtonProps: { danger: true },
      cancelText: 'Đóng',
      onOk: async () => {
        try {
          await deleteJob.mutateAsync(job.id)
          message.success('Đã xoá lịch')
        } catch (err) {
          message.error(err instanceof ApiError ? err.message : 'Xoá thất bại')
        }
      },
    })
  }

  const columns: TableColumnsType<KenChestAutoJob> = [
    {
      title: 'Tên lịch',
      dataIndex: 'name',
      render: (name: string) => <Typography.Text strong>{name}</Typography.Text>,
    },
    {
      title: 'Bật',
      key: 'enabled',
      width: 80,
      render: (_, job) => (
        <Switch size="small" checked={job.enabled} onChange={(checked) => toggleJob(job, checked)} />
      ),
    },
    {
      title: 'Chu kỳ',
      key: 'schedule',
      render: (_, job) => scheduleText(job),
    },
    {
      title: 'Phần thưởng',
      key: 'reward',
      render: (_, job) => (
        <div>
          <Typography.Text>{rewardText(job)}</Typography.Text>
          <div style={{ fontSize: 12, color: '#6b7785' }}>
            {job.rewardMode === 'fixed' ? 'Cố định' : 'Ngẫu nhiên'} · {job.maxRecipients} người
          </div>
        </div>
      ),
    },
    {
      title: 'Lần chạy kế',
      dataIndex: 'nextRunAt',
      width: 170,
      render: (v?: string) => (v ? formatDateTime(v) : <Tag>—</Tag>),
    },
    {
      title: 'Số lần chạy',
      key: 'runs',
      width: 130,
      render: (_, job) => (
        <Space size={4}>
          <Tag color={job.remainingRuns == null ? 'green' : 'orange'}>
            {job.remainingRuns == null ? 'Không giới hạn' : `Còn ${job.remainingRuns}`}
          </Tag>
          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
            đã chạy {job.runCount}
          </Typography.Text>
        </Space>
      ),
    },
    {
      title: 'Thao tác',
      key: 'actions',
      width: 130,
      render: (_, job) => (
        <Space>
          <Button size="small" icon={<EditOutlined />} onClick={() => openEdit(job)} />
          <Button size="small" danger icon={<DeleteOutlined />} onClick={() => removeJob(job)} />
        </Space>
      ),
    },
  ]

  return (
    <>
      <div
        style={{
          marginBottom: 16,
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
        }}
      >
        <Space>
          <Typography.Text strong>Bật tất cả lịch tự động</Typography.Text>
          <Switch
            checked={settings?.enabled ?? false}
            loading={updateSettings.isPending}
            onChange={toggleMaster}
          />
        </Space>
        <Button type="primary" icon={<PlusOutlined />} onClick={openCreate}>
          Thêm lịch
        </Button>
      </div>
      <Table<KenChestAutoJob>
        rowKey="id"
        columns={columns}
        dataSource={jobs ?? []}
        loading={isFetching}
        scroll={{ x: 820 }}
        pagination={false}
      />
      <KenChestAutoJobModal open={modalOpen} job={editingJob} onClose={() => setModalOpen(false)} />
    </>
  )
}
