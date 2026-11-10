import { useState } from 'react'
import dayjs from 'dayjs'
import { Alert, Card, Col, Input, Row, Segmented, Select, Space, Statistic, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { StopOutlined } from '@ant-design/icons'
import { UserBriefCell } from '@/components/UserBriefCell'
import { useDebounce } from '@/hooks/useDebounce'
import { PAGE_SIZE } from '@/lib/constants'
import { formatCount, formatDateTime } from '@/lib/format'
import type {
  GiftCodeAttempt,
  GiftCodeAttemptDevice,
  GiftCodeAttemptRange,
  GiftCodeAttemptReason,
  GiftCodeAttemptUser,
} from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { GIFT_CODE_SECTION_LINKS } from '@/pages/shop/sections'
import {
  GIFT_CODE_ATTEMPT_RANGE_OPTIONS,
  GIFT_CODE_HEAVY_FAILURES,
  GIFT_CODE_MULTI_ACCOUNT,
  GIFT_CODE_REASON_META,
  GIFT_CODE_REASON_OPTIONS,
} from './constants'
import {
  useGiftCodeAttemptDevices,
  useGiftCodeAttemptSummary,
  useGiftCodeAttemptUsers,
  useGiftCodeAttempts,
} from './useGiftCodeQueries'
import { attemptDeviceLabel } from './utils'

type AttemptView = 'users' | 'devices' | 'log'

const DANGER = '#d4380d'

function ReasonTag({ reason }: { reason: GiftCodeAttemptReason }) {
  const meta = GIFT_CODE_REASON_META[reason] ?? { label: reason }
  return <Tag color={meta.color}>{meta.label}</Tag>
}

export function GiftCodeAttemptsPage() {
  const [view, setView] = useState<AttemptView>('users')
  const [range, setRange] = useState<GiftCodeAttemptRange>('24h')
  const [reason, setReason] = useState<GiftCodeAttemptReason>()
  const [search, setSearch] = useState('')
  const [page, setPage] = useState(1)
  const debouncedSearch = useDebounce(search.trim())

  const params = {
    range,
    reason: view === 'devices' ? undefined : reason,
    search: debouncedSearch || undefined,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  }
  const summary = useGiftCodeAttemptSummary({ range })
  const users = useGiftCodeAttemptUsers(params, view === 'users')
  const devices = useGiftCodeAttemptDevices(params, view === 'devices')
  const log = useGiftCodeAttempts(params, view === 'log')

  const resetPage = <T,>(setter: (v: T) => void) => (value: T) => {
    setter(value)
    setPage(1)
  }

  const pagination = (total: number | undefined, noun: string) => ({
    current: page,
    pageSize: PAGE_SIZE,
    total: total ?? 0,
    showTotal: (count: number) => `${formatCount(count)} ${noun}`,
    onChange: setPage,
  })

  const userColumns: TableColumnsType<GiftCodeAttemptUser> = [
    { title: 'Người dùng', dataIndex: 'user', width: 220, render: (_, row) => <UserBriefCell user={row.user} /> },
    { title: 'Thiết bị', key: 'device', width: 180, render: (_, row) => attemptDeviceLabel(row.platform, row.deviceName) },
    {
      title: 'Số lần lỗi',
      dataIndex: 'failures',
      width: 110,
      render: (value: number) => <b style={{ color: value >= GIFT_CODE_HEAVY_FAILURES ? DANGER : undefined }}>{formatCount(value)}</b>,
    },
    { title: 'Lỗi nhiều nhất', dataIndex: 'topReason', width: 170, render: (value: GiftCodeAttemptReason) => <ReasonTag reason={value} /> },
    {
      title: 'Mã đã thử gần đây',
      dataIndex: 'recentCodes',
      render: (codes: string[]) => (
        <Space size={4} wrap>
          {codes.map((code) => (
            <Typography.Text key={code} code style={{ whiteSpace: 'nowrap' }}>
              {code}
            </Typography.Text>
          ))}
        </Space>
      ),
    },
    { title: 'Lần cuối', dataIndex: 'lastAt', width: 160, render: (value: string) => formatDateTime(value) },
    {
      title: 'Trạng thái',
      dataIndex: 'blockedUntil',
      width: 150,
      fixed: 'right',
      render: (value?: string) =>
        value ? (
          <Tag color="red" icon={<StopOutlined />}>
            Chặn đến {dayjs(value).format('HH:mm')}
          </Tag>
        ) : (
          <Typography.Text type="secondary">Bình thường</Typography.Text>
        ),
    },
  ]

  const deviceColumns: TableColumnsType<GiftCodeAttemptDevice> = [
    {
      title: 'Thiết bị',
      key: 'device',
      render: (_, row) => (
        <div>
          <b>{attemptDeviceLabel(row.platform, row.deviceName)}</b>
          <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12, fontFamily: 'monospace' }}>
            {row.deviceId.length > 24 ? `${row.deviceId.slice(0, 12)}…${row.deviceId.slice(-6)}` : row.deviceId}
          </Typography.Text>
        </div>
      ),
    },
    {
      title: 'Các nick đã dùng thiết bị này',
      dataIndex: 'accounts',
      render: (_, row) => (
        <Space size={4} wrap>
          {row.accounts.map((u) => (
            <Tag key={u.id} style={{ marginInlineEnd: 0 }}>
              {u.username}
            </Tag>
          ))}
        </Space>
      ),
    },
    {
      title: 'Số nick',
      key: 'count',
      width: 90,
      render: (_, row) => (
        <b style={{ color: row.accounts.length >= GIFT_CODE_MULTI_ACCOUNT ? DANGER : undefined }}>{row.accounts.length}</b>
      ),
    },
    { title: 'Lần lỗi', dataIndex: 'failures', width: 100, render: (value: number) => formatCount(value) },
    { title: 'Nhận thành công', dataIndex: 'successes', width: 130, render: (value: number) => formatCount(value) },
    { title: 'Lần cuối', dataIndex: 'lastAt', width: 160, render: (value: string) => formatDateTime(value) },
  ]

  const logColumns: TableColumnsType<GiftCodeAttempt> = [
    { title: 'Lúc', dataIndex: 'createdAt', width: 160, render: (value: string) => formatDateTime(value) },
    { title: 'Người dùng', dataIndex: 'user', width: 220, render: (_, row) => <UserBriefCell user={row.user} /> },
    { title: 'Mã đã nhập', dataIndex: 'codeInput', render: (value: string) => <Typography.Text code>{value}</Typography.Text> },
    { title: 'Lý do', dataIndex: 'reason', width: 180, render: (value: GiftCodeAttemptReason) => <ReasonTag reason={value} /> },
    { title: 'Thiết bị', key: 'device', width: 190, render: (_, row) => attemptDeviceLabel(row.platform, row.deviceName) },
    {
      title: 'IP',
      dataIndex: 'ipAddress',
      width: 140,
      render: (value: string) => <span style={{ fontFamily: 'monospace', fontSize: 12 }}>{value || '—'}</span>,
    },
  ]

  const s = summary.data

  return (
    <Card title={<ShopSectionNav links={GIFT_CODE_SECTION_LINKS} />}>
      <Row gutter={[16, 16]} style={{ marginBottom: 16 }}>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic title="Lượt nhập lỗi" value={s?.failures ?? 0} groupSeparator="." />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic title="Trong đó sai mã" value={s?.wrongCodes ?? 0} groupSeparator="." />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic
              title="Đang bị chặn tạm"
              value={s?.blockedUsers ?? 0}
              suffix="người"
              styles={{ content: { color: (s?.blockedUsers ?? 0) > 0 ? DANGER : undefined } }}
            />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic
              title={`Thiết bị có từ ${GIFT_CODE_MULTI_ACCOUNT} nick`}
              value={s?.multiAccountDevices ?? 0}
              styles={{ content: { color: (s?.multiAccountDevices ?? 0) > 0 ? DANGER : undefined } }}
            />
          </Card>
        </Col>
      </Row>
      <Alert
        type="info"
        showIcon
        style={{ marginBottom: 16 }}
        title="Nhập sai mã 5 lần trong 1 phút thì bị chặn nhập mã 15 phút. Nhật ký giữ 30 ngày, gồm cả sai mã lẫn nhập đúng mã nhưng không đủ điều kiện."
      />
      <Space style={{ marginBottom: 16 }} wrap>
        <Segmented<AttemptView>
          value={view}
          onChange={resetPage(setView)}
          options={[
            { value: 'users', label: 'Theo người dùng' },
            { value: 'devices', label: 'Theo thiết bị' },
            { value: 'log', label: 'Từng lượt' },
          ]}
        />
        <Input.Search
          allowClear
          placeholder={view === 'devices' ? 'Tìm thiết bị hoặc nickname' : 'Tìm nickname, mã hoặc IP'}
          style={{ width: 240 }}
          value={search}
          onChange={(e) => resetPage(setSearch)(e.target.value)}
        />
        <Select<GiftCodeAttemptRange> style={{ width: 140 }} value={range} options={GIFT_CODE_ATTEMPT_RANGE_OPTIONS} onChange={resetPage(setRange)} />
        {view !== 'devices' && (
          <Select<GiftCodeAttemptReason>
            allowClear
            placeholder="Mọi lý do"
            style={{ width: 200 }}
            value={reason}
            options={GIFT_CODE_REASON_OPTIONS}
            onChange={resetPage(setReason)}
          />
        )}
      </Space>
      {view === 'users' && (
        <Table<GiftCodeAttemptUser>
          rowKey={(row) => row.user.id}
          columns={userColumns}
          dataSource={users.data?.items ?? []}
          loading={users.isFetching && users.data == null}
          scroll={{ x: 1250 }}
          pagination={pagination(users.data?.total, 'người')}
          locale={{ emptyText: 'Không có lượt nhập lỗi nào' }}
        />
      )}
      {view === 'devices' && (
        <Table<GiftCodeAttemptDevice>
          rowKey="deviceId"
          columns={deviceColumns}
          dataSource={devices.data?.items ?? []}
          loading={devices.isFetching && devices.data == null}
          scroll={{ x: 1000 }}
          pagination={pagination(devices.data?.total, 'thiết bị')}
          locale={{ emptyText: 'Không có thiết bị đáng ngờ' }}
        />
      )}
      {view === 'log' && (
        <Table<GiftCodeAttempt>
          rowKey="id"
          columns={logColumns}
          dataSource={log.data?.items ?? []}
          loading={log.isFetching && log.data == null}
          scroll={{ x: 1000 }}
          pagination={pagination(log.data?.total, 'lượt')}
          locale={{ emptyText: 'Không có lượt nhập lỗi nào' }}
        />
      )}
    </Card>
  )
}
