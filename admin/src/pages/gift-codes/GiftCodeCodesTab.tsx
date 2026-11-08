import { useState } from 'react'
import {
  App,
  Button,
  Form,
  Input,
  InputNumber,
  Modal,
  Select,
  Space,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { DownloadOutlined, LockOutlined, PlusOutlined, UnlockOutlined } from '@ant-design/icons'
import { UserBriefCell } from '@/components/UserBriefCell'
import { useDebounce } from '@/hooks/useDebounce'
import { errorMessage } from '@/lib/apiError'
import { PAGE_SIZE } from '@/lib/constants'
import { formatCount, formatDateTime } from '@/lib/format'
import { AdminGiftCodeService } from '@/services/adminGiftCode.service'
import type { GiftCodeCampaign, GiftCodeCodeStatus, GiftCodeItem } from '@/types'
import { GIFT_CODE_CODE_STATUS_META, GIFT_CODE_LOCK_REASON_MAX, GIFT_CODE_MAX_BATCH } from './constants'
import { useGenerateGiftCodes, useGiftCodes, useSetGiftCodeLock } from './useGiftCodeQueries'
import { csvFileName, downloadCsv } from './utils'

export function GiftCodeCodesTab({ campaign }: { campaign: GiftCodeCampaign }) {
  const { message } = App.useApp()
  const [search, setSearch] = useState('')
  const [status, setStatus] = useState<GiftCodeCodeStatus>()
  const [page, setPage] = useState(1)
  const [exporting, setExporting] = useState(false)
  const [locking, setLocking] = useState<GiftCodeItem | null>(null)
  const [generateOpen, setGenerateOpen] = useState(false)
  const [lockForm] = Form.useForm<{ reason: string }>()
  const [generateForm] = Form.useForm<{ count: number }>()
  const debouncedSearch = useDebounce(search.trim())

  const { data, isFetching } = useGiftCodes(campaign.id, {
    status,
    search: debouncedSearch || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const setLock = useSetGiftCodeLock()
  const generate = useGenerateGiftCodes()
  const counts = data?.counts

  function unlock(item: GiftCodeItem) {
    setLock.mutate(
      { id: campaign.id, codeId: item.id, locked: false, reason: '' },
      {
        onSuccess: () => message.success(`Đã mở khoá ${item.code}`),
        onError: (err) => message.error(errorMessage(err, 'Mở khoá thất bại')),
      },
    )
  }

  async function confirmLock() {
    if (!locking) return
    const { reason } = await lockForm.validateFields()
    try {
      await setLock.mutateAsync({ id: campaign.id, codeId: locking.id, locked: true, reason })
      message.success(`Đã khoá ${locking.code}`)
      setLocking(null)
    } catch (err) {
      message.error(errorMessage(err, 'Khoá mã thất bại'))
    }
  }

  async function confirmGenerate() {
    const { count } = await generateForm.validateFields()
    try {
      const result = await generate.mutateAsync({ id: campaign.id, count })
      message.success(`Đã sinh thêm ${formatCount(result.generated)} mã, đợt có ${formatCount(result.totalUses)} mã`)
      setGenerateOpen(false)
    } catch (err) {
      message.error(errorMessage(err, 'Sinh mã thất bại'))
    }
  }

  async function exportCsv() {
    setExporting(true)
    try {
      const all = await AdminGiftCodeService.exportCodes(campaign.id, { status, search: debouncedSearch || undefined })
      downloadCsv(
        csvFileName(campaign.name, 'ma'),
        ['Mã', 'Trạng thái', 'Nickname', 'Lúc dùng', 'Lý do khoá'],
        all.items.map((item) => [
          item.code,
          GIFT_CODE_CODE_STATUS_META[item.status].label,
          item.user?.username ?? '',
          item.usedAt ? formatDateTime(item.usedAt) : '',
          item.lockReason ?? '',
        ]),
      )
    } catch (err) {
      message.error(errorMessage(err, 'Xuất CSV thất bại'))
    } finally {
      setExporting(false)
    }
  }

  const columns: TableColumnsType<GiftCodeItem> = [
    { title: 'Mã', dataIndex: 'code', render: (value: string) => <Typography.Text code copyable>{value}</Typography.Text> },
    {
      title: 'Trạng thái',
      dataIndex: 'status',
      width: 130,
      render: (value: GiftCodeCodeStatus) => {
        const meta = GIFT_CODE_CODE_STATUS_META[value]
        return (
          <Tag color={meta.color} icon={value === 'locked' ? <LockOutlined /> : undefined}>
            {meta.label}
          </Tag>
        )
      },
    },
    {
      title: 'Người dùng',
      key: 'user',
      render: (_, item) => {
        if (item.user) return <UserBriefCell user={item.user} />
        if (item.status === 'locked') {
          return (
            <Typography.Text type="secondary">
              Khoá bởi {item.lockedBy?.username ?? 'admin'} · {formatDateTime(item.lockedAt)} · {item.lockReason}
            </Typography.Text>
          )
        }
        return <Typography.Text type="secondary">—</Typography.Text>
      },
    },
    { title: 'Thời gian', dataIndex: 'usedAt', width: 160, render: (value?: string) => (value ? formatDateTime(value) : '—') },
    {
      title: '',
      key: 'actions',
      width: 120,
      render: (_, item) => {
        if (item.status === 'used') return null
        if (item.status === 'locked') {
          return (
            <Button size="small" icon={<UnlockOutlined />} onClick={() => unlock(item)}>
              Mở khoá
            </Button>
          )
        }
        return (
          <Button
            size="small"
            danger
            icon={<LockOutlined />}
            onClick={() => {
              lockForm.resetFields()
              setLocking(item)
            }}
          >
            Khoá
          </Button>
        )
      },
    },
  ]

  return (
    <>
      <Space style={{ marginBottom: 16 }} wrap>
        <Input.Search
          allowClear
          placeholder="Tìm mã"
          style={{ width: 220 }}
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
        <Select
          allowClear
          placeholder="Tất cả mã"
          style={{ width: 170 }}
          value={status}
          onChange={(value) => {
            setStatus(value)
            setPage(1)
          }}
          options={[
            { value: 'unused', label: `Chưa dùng (${formatCount(counts?.unused ?? 0)})` },
            { value: 'used', label: `Đã dùng (${formatCount(counts?.used ?? 0)})` },
            { value: 'locked', label: `Đã khoá (${formatCount(counts?.locked ?? 0)})` },
          ]}
        />
        <Button icon={<DownloadOutlined />} loading={exporting} onClick={() => void exportCsv()}>
          Xuất CSV
        </Button>
        {campaign.kind === 'unique' && (
          <Button
            icon={<PlusOutlined />}
            onClick={() => {
              generateForm.setFieldsValue({ count: 20 })
              setGenerateOpen(true)
            }}
          >
            Sinh thêm mã
          </Button>
        )}
      </Space>
      <Table<GiftCodeItem>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching && data == null}
        scroll={{ x: 900 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${formatCount(total)} mã`,
          onChange: setPage,
        }}
      />
      <Typography.Paragraph type="secondary" style={{ fontSize: 13, marginTop: 12, marginBottom: 0 }}>
        Khoá mã phải ghi lý do. Mã đã dùng thì không khoá được vì quà đã phát.
      </Typography.Paragraph>

      <Modal
        title={locking ? `Khoá mã ${locking.code}` : 'Khoá mã'}
        open={locking != null}
        onOk={() => void confirmLock()}
        onCancel={() => setLocking(null)}
        okText="Khoá mã"
        okButtonProps={{ danger: true }}
        cancelText="Huỷ"
        confirmLoading={setLock.isPending}
        destroyOnHidden
      >
        <Form form={lockForm} layout="vertical" requiredMark={false}>
          <Form.Item name="reason" label="Lý do" rules={[{ required: true, whitespace: true, message: 'Nhập lý do khoá' }]}>
            <Input.TextArea rows={2} maxLength={GIFT_CODE_LOCK_REASON_MAX} showCount placeholder="vd: Lộ trên group Facebook" />
          </Form.Item>
        </Form>
      </Modal>

      <Modal
        title="Sinh thêm mã"
        open={generateOpen}
        onOk={() => void confirmGenerate()}
        onCancel={() => setGenerateOpen(false)}
        okText="Sinh mã"
        cancelText="Huỷ"
        confirmLoading={generate.isPending}
        destroyOnHidden
      >
        <Form form={generateForm} layout="vertical" requiredMark={false}>
          <Form.Item
            name="count"
            label="Số mã cần sinh thêm"
            extra={`Đợt đang có ${formatCount(campaign.totalUses)} mã. Mỗi lần tối đa ${formatCount(GIFT_CODE_MAX_BATCH)} mã, mỗi đợt tối đa 100.000 mã.`}
            rules={[{ required: true, message: 'Nhập số mã' }]}
          >
            <InputNumber min={1} max={GIFT_CODE_MAX_BATCH} style={{ width: '100%' }} addonAfter="mã" />
          </Form.Item>
        </Form>
      </Modal>
    </>
  )
}
