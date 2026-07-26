import { useMemo, useState } from 'react'
import {
  Avatar,
  Button,
  Card,
  Col,
  Input,
  Row,
  Select,
  Space,
  Statistic,
  Table,
  Tabs,
  Tag,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { HeartFilled, ReloadOutlined } from '@ant-design/icons'
import { useMarriageProposals, useMarriages, useMarriageStats } from '@/hooks/useMarriage'
import type {
  MarriageItem,
  MarriageProposalItem,
  MarriageProposalStatus,
  MarriageStatus,
  MarriageUser,
} from '@/types'

const PAGE_SIZE = 20

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

const MARRIAGE_STATUS_META: Record<MarriageStatus, { label: string; color: string }> = {
  active: { label: 'Đang bên nhau', color: 'green' },
  divorced: { label: 'Đã ly hôn', color: 'red' },
}

const PROPOSAL_STATUS_META: Record<MarriageProposalStatus, { label: string; color: string }> = {
  pending: { label: 'Đang chờ', color: 'gold' },
  accepted: { label: 'Được nhận', color: 'green' },
  rejected: { label: 'Từ chối', color: 'red' },
  cancelled: { label: 'Đã hủy', color: 'default' },
}

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function formatTime(iso: string) {
  return new Date(iso).toLocaleString('vi-VN')
}

function daysBetween(fromIso: string, toIso?: string) {
  const from = new Date(fromIso).getTime()
  const to = toIso ? new Date(toIso).getTime() : Date.now()
  return Math.max(0, Math.floor((to - from) / 86_400_000))
}

function UserCell({ user }: { user?: MarriageUser }) {
  if (!user) return <Typography.Text type="secondary">—</Typography.Text>
  return (
    <Space>
      <Avatar size="small" src={user.avatar || undefined}>
        {user.fullName?.[0] ?? user.username?.[0] ?? '?'}
      </Avatar>
      <div>
        <Typography.Text strong>{user.fullName || user.username}</Typography.Text>
        <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
          @{user.username}
        </Typography.Text>
      </div>
    </Space>
  )
}

function divorcedByName(row: MarriageItem) {
  if (!row.divorcedBy) return null
  if (row.divorcedBy === row.userA.id) return row.userA.fullName || row.userA.username
  if (row.divorcedBy === row.userB.id) return row.userB.fullName || row.userB.username
  return row.divorcedBy.slice(0, 8)
}

const marriageColumns: ColumnsType<MarriageItem> = [
  {
    title: 'Cặp đôi',
    key: 'couple',
    render: (_, row) => (
      <Space size={16}>
        <UserCell user={row.userA} />
        <HeartFilled style={{ color: row.status === 'active' ? '#eb2f96' : '#bfbfbf' }} />
        <UserCell user={row.userB} />
      </Space>
    ),
  },
  {
    title: 'Trạng thái',
    dataIndex: 'status',
    width: 140,
    render: (value: MarriageStatus, row) => {
      const meta = MARRIAGE_STATUS_META[value] ?? { label: value, color: 'default' }
      const by = divorcedByName(row)
      return (
        <>
          <Tag color={meta.color}>{meta.label}</Tag>
          {by && (
            <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
              bởi {by}
            </Typography.Text>
          )}
        </>
      )
    },
  },
  {
    title: 'Ngày cưới',
    dataIndex: 'marriedAt',
    width: 160,
    render: (value: string) => formatTime(value),
  },
  {
    title: 'Ngày ly hôn',
    dataIndex: 'divorcedAt',
    width: 160,
    render: (value?: string) =>
      value ? formatTime(value) : <Typography.Text type="secondary">—</Typography.Text>,
  },
  {
    title: 'Bên nhau',
    key: 'duration',
    width: 110,
    align: 'right',
    render: (_, row) => `${vn(daysBetween(row.marriedAt, row.divorcedAt))} ngày`,
  },
]

const proposalColumns: ColumnsType<MarriageProposalItem> = [
  {
    title: 'Người cầu hôn',
    key: 'proposer',
    render: (_, row) => <UserCell user={row.proposer} />,
  },
  {
    title: 'Người được cầu hôn',
    key: 'addressee',
    render: (_, row) => <UserCell user={row.addressee} />,
  },
  {
    title: 'Lời nhắn',
    dataIndex: 'message',
    ellipsis: true,
    render: (value?: string) =>
      value ? value : <Typography.Text type="secondary">—</Typography.Text>,
  },
  {
    title: 'Trạng thái',
    dataIndex: 'status',
    width: 120,
    render: (value: MarriageProposalStatus) => {
      const meta = PROPOSAL_STATUS_META[value] ?? { label: value, color: 'default' }
      return <Tag color={meta.color}>{meta.label}</Tag>
    },
  },
  {
    title: 'Cầu hôn lúc',
    dataIndex: 'createdAt',
    width: 160,
    render: (value: string) => formatTime(value),
  },
  {
    title: 'Trả lời lúc',
    dataIndex: 'respondedAt',
    width: 160,
    render: (value?: string) =>
      value ? formatTime(value) : <Typography.Text type="secondary">—</Typography.Text>,
  },
]

export function MarriagesPage() {
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')

  const [marriageStatus, setMarriageStatus] = useState<MarriageStatus | undefined>()
  const [marriageUser, setMarriageUser] = useState('')
  const [marriagePage, setMarriagePage] = useState(1)

  const [proposalStatus, setProposalStatus] = useState<MarriageProposalStatus | undefined>()
  const [proposalUser, setProposalUser] = useState('')
  const [proposalPage, setProposalPage] = useState(1)

  const range = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )

  const { data: stats, isFetching: statsFetching, refetch } = useMarriageStats(range)

  const marriageParams = useMemo(
    () => ({
      status: marriageStatus,
      userId: marriageUser || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (marriagePage - 1) * PAGE_SIZE,
    }),
    [marriageStatus, marriageUser, range, marriagePage],
  )
  const { data: marriages, isFetching: marriagesFetching } = useMarriages(marriageParams)

  const proposalParams = useMemo(
    () => ({
      status: proposalStatus,
      userId: proposalUser || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (proposalPage - 1) * PAGE_SIZE,
    }),
    [proposalStatus, proposalUser, range, proposalPage],
  )
  const { data: proposals, isFetching: proposalsFetching } = useMarriageProposals(proposalParams)

  const answered = (stats?.proposals.accepted ?? 0) + (stats?.proposals.rejected ?? 0)
  const acceptRate = answered > 0 ? ((stats?.proposals.accepted ?? 0) / answered) * 100 : 0

  function changeRange(setter: (value: string) => void) {
    return (value: string) => {
      setter(value)
      setMarriagePage(1)
      setProposalPage(1)
    }
  }

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => changeRange(setFrom)(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => changeRange(setTo)(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Row gutter={[16, 16]}>
        <Col xs={24} md={12}>
          <Card title="Cặp đôi" loading={statsFetching}>
            <Row gutter={16}>
              <Col span={8}>
                <Statistic
                  title="Đang bên nhau"
                  value={stats?.marriages.active ?? 0}
                  valueStyle={{ color: '#eb2f96' }}
                  prefix={<HeartFilled />}
                />
              </Col>
              <Col span={8}>
                <Statistic
                  title="Đã ly hôn"
                  value={stats?.marriages.divorced ?? 0}
                  valueStyle={{ color: '#cf1322' }}
                />
              </Col>
              <Col span={8}>
                <Statistic title="Tổng" value={stats?.marriages.total ?? 0} />
              </Col>
            </Row>
          </Card>
        </Col>
        <Col xs={24} md={12}>
          <Card title="Cầu hôn" loading={statsFetching}>
            <Row gutter={16}>
              <Col span={4}>
                <Statistic title="Tổng" value={stats?.proposals.total ?? 0} />
              </Col>
              <Col span={5}>
                <Statistic
                  title="Được nhận"
                  value={stats?.proposals.accepted ?? 0}
                  valueStyle={{ color: '#3f8600' }}
                />
              </Col>
              <Col span={5}>
                <Statistic
                  title="Từ chối"
                  value={stats?.proposals.rejected ?? 0}
                  valueStyle={{ color: '#cf1322' }}
                />
              </Col>
              <Col span={5}>
                <Statistic title="Chờ / hủy" value={`${vn(stats?.proposals.pending ?? 0)} / ${vn(stats?.proposals.cancelled ?? 0)}`} />
              </Col>
              <Col span={5}>
                <Statistic title="Tỉ lệ đồng ý" value={acceptRate} precision={1} suffix="%" />
              </Col>
            </Row>
          </Card>
        </Col>
      </Row>

      <Card>
        <Tabs
          items={[
            {
              key: 'marriages',
              label: 'Cặp đôi',
              children: (
                <Space direction="vertical" size={12} style={{ width: '100%' }}>
                  <Space wrap>
                    <Select
                      allowClear
                      placeholder="Trạng thái"
                      value={marriageStatus}
                      onChange={(value) => {
                        setMarriageStatus(value)
                        setMarriagePage(1)
                      }}
                      options={(
                        Object.keys(MARRIAGE_STATUS_META) as MarriageStatus[]
                      ).map((key) => ({ value: key, label: MARRIAGE_STATUS_META[key].label }))}
                      style={{ width: 170 }}
                    />
                    <Input.Search
                      allowClear
                      placeholder="Lọc theo User ID"
                      onSearch={(value) => {
                        setMarriageUser(value.trim())
                        setMarriagePage(1)
                      }}
                      style={{ width: 260 }}
                    />
                  </Space>
                  <Table<MarriageItem>
                    rowKey="id"
                    size="small"
                    loading={marriagesFetching}
                    columns={marriageColumns}
                    dataSource={marriages?.items ?? []}
                    pagination={{
                      current: marriagePage,
                      pageSize: PAGE_SIZE,
                      total: marriages?.total ?? 0,
                      showSizeChanger: false,
                      showTotal: (total) => `${vn(total)} cặp đôi`,
                      onChange: setMarriagePage,
                    }}
                    locale={{ emptyText: 'Chưa có cặp đôi nào' }}
                  />
                </Space>
              ),
            },
            {
              key: 'proposals',
              label: 'Lời cầu hôn',
              children: (
                <Space direction="vertical" size={12} style={{ width: '100%' }}>
                  <Space wrap>
                    <Select
                      allowClear
                      placeholder="Trạng thái"
                      value={proposalStatus}
                      onChange={(value) => {
                        setProposalStatus(value)
                        setProposalPage(1)
                      }}
                      options={(
                        Object.keys(PROPOSAL_STATUS_META) as MarriageProposalStatus[]
                      ).map((key) => ({ value: key, label: PROPOSAL_STATUS_META[key].label }))}
                      style={{ width: 170 }}
                    />
                    <Input.Search
                      allowClear
                      placeholder="Lọc theo User ID"
                      onSearch={(value) => {
                        setProposalUser(value.trim())
                        setProposalPage(1)
                      }}
                      style={{ width: 260 }}
                    />
                  </Space>
                  <Table<MarriageProposalItem>
                    rowKey="id"
                    size="small"
                    loading={proposalsFetching}
                    columns={proposalColumns}
                    dataSource={proposals?.items ?? []}
                    pagination={{
                      current: proposalPage,
                      pageSize: PAGE_SIZE,
                      total: proposals?.total ?? 0,
                      showSizeChanger: false,
                      showTotal: (total) => `${vn(total)} lời cầu hôn`,
                      onChange: setProposalPage,
                    }}
                    locale={{ emptyText: 'Chưa có lời cầu hôn nào' }}
                  />
                </Space>
              ),
            },
          ]}
        />
      </Card>
    </Space>
  )
}
