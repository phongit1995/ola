import { useMemo, useState } from 'react'
import {
  App,
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
import type { ColumnsType, TablePaginationConfig } from 'antd/es/table'
import type { SorterResult } from 'antd/es/table/interface'
import { ArrowRightOutlined, ReloadOutlined, UsergroupAddOutlined } from '@ant-design/icons'
import {
  useFollows,
  useRelationships,
  useRelationshipStats,
  useRelationshipUserStats,
} from './useRelationshipQueries'
import type {
  FollowItem,
  RelationshipItem,
  RelationshipStatus,
  RelationshipUserStatsItem,
  RelationshipUserStatsSortBy,
} from '@/types'
import { formatCount, formatDateTime } from '@/lib/format'
import { DateRangeFilter } from '@/components/DateRangeFilter'
import { toIsoRange } from '@/lib/dateRange'
import { UserBriefCell } from '@/components/UserBriefCell'

const PAGE_SIZE = 20
const USER_STATS_SORTS: RelationshipUserStatsSortBy[] = [
  'friends',
  'blocked',
  'followers',
  'following',
]

const UUID_RE = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/i

const STATUS_META: Record<RelationshipStatus, { label: string; color: string }> = {
  pending: { label: 'Đang chờ', color: 'gold' },
  accepted: { label: 'Bạn bè', color: 'green' },
  rejected: { label: 'Từ chối', color: 'default' },
  blocked: { label: 'Chặn', color: 'red' },
}

const relationshipColumns: ColumnsType<RelationshipItem> = [
  {
    title: 'Người gửi',
    key: 'requester',
    render: (_, row) => <UserBriefCell user={row.requester} />,
  },
  {
    title: '',
    key: 'arrow',
    width: 40,
    align: 'center',
    render: () => <ArrowRightOutlined style={{ color: '#8c8c8c' }} />,
  },
  {
    title: 'Người nhận',
    key: 'addressee',
    render: (_, row) => <UserBriefCell user={row.addressee} />,
  },
  {
    title: 'Trạng thái',
    dataIndex: 'status',
    width: 120,
    render: (value: RelationshipStatus) => {
      const meta = STATUS_META[value] ?? { label: value, color: 'default' }
      return <Tag color={meta.color}>{meta.label}</Tag>
    },
  },
  {
    title: 'Gửi lúc',
    dataIndex: 'createdAt',
    width: 160,
    render: (value: string) => formatDateTime(value),
  },
  {
    title: 'Phản hồi lúc',
    dataIndex: 'actionedAt',
    width: 160,
    render: (value?: string) =>
      value ? formatDateTime(value) : <Typography.Text type="secondary">—</Typography.Text>,
  },
]

const followColumns: ColumnsType<FollowItem> = [
  {
    title: 'Người theo dõi',
    key: 'follower',
    render: (_, row) => <UserBriefCell user={row.follower} />,
  },
  {
    title: '',
    key: 'arrow',
    width: 40,
    align: 'center',
    render: () => <ArrowRightOutlined style={{ color: '#8c8c8c' }} />,
  },
  {
    title: 'Được theo dõi',
    key: 'followee',
    render: (_, row) => <UserBriefCell user={row.followee} />,
  },
  {
    title: 'Theo dõi lúc',
    dataIndex: 'createdAt',
    width: 170,
    render: (value: string) => formatDateTime(value),
  },
]

export function RelationshipsPage() {
  const { message } = App.useApp()
  const [from, setFrom] = useState('')
  const [to, setTo] = useState('')

  const [relStatus, setRelStatus] = useState<RelationshipStatus | undefined>()
  const [relUser, setRelUser] = useState('')
  const [relPage, setRelPage] = useState(1)

  const [followUser, setFollowUser] = useState('')
  const [followPage, setFollowPage] = useState(1)

  const [userSort, setUserSort] = useState<RelationshipUserStatsSortBy>('friends')
  const [userSearch, setUserSearch] = useState('')
  const [userPage, setUserPage] = useState(1)

  const range = useMemo(() => toIsoRange(from, to), [from, to])

  const { data: stats, isFetching: statsFetching, refetch } = useRelationshipStats(range)

  const relParams = useMemo(
    () => ({
      status: relStatus,
      userId: relUser || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (relPage - 1) * PAGE_SIZE,
    }),
    [relStatus, relUser, range, relPage],
  )
  const { data: relationships, isFetching: relFetching } = useRelationships(relParams)

  const followParams = useMemo(
    () => ({
      userId: followUser || undefined,
      ...range,
      limit: PAGE_SIZE,
      offset: (followPage - 1) * PAGE_SIZE,
    }),
    [followUser, range, followPage],
  )
  const { data: follows, isFetching: followsFetching } = useFollows(followParams)

  const userStatsParams = useMemo(
    () => ({
      userId: userSearch || undefined,
      ...range,
      sortBy: userSort,
      limit: PAGE_SIZE,
      offset: (userPage - 1) * PAGE_SIZE,
    }),
    [userSearch, range, userSort, userPage],
  )
  const { data: userStats, isFetching: userStatsFetching } =
    useRelationshipUserStats(userStatsParams)

  function changeRange(setter: (value: string) => void) {
    return (value: string) => {
      setter(value)
      setRelPage(1)
      setFollowPage(1)
      setUserPage(1)
    }
  }

  function searchUser(setter: (value: string) => void, resetPage: (page: number) => void) {
    return (value: string) => {
      const trimmed = value.trim()
      if (trimmed && !UUID_RE.test(trimmed)) {
        void message.warning('User ID phải là UUID')
        return
      }
      setter(trimmed)
      resetPage(1)
    }
  }

  function onUserTableChange(
    _pagination: TablePaginationConfig,
    _filters: unknown,
    sorter:
      | SorterResult<RelationshipUserStatsItem>
      | SorterResult<RelationshipUserStatsItem>[],
  ) {
    const single = Array.isArray(sorter) ? sorter[0] : sorter
    const field = single?.order ? String(single.field) : 'friends'
    const next = USER_STATS_SORTS.find((key) => key === field) ?? 'friends'
    if (next !== userSort) {
      setUserSort(next)
      setUserPage(1)
    }
  }

  const userColumns: ColumnsType<RelationshipUserStatsItem> = [
    {
      title: 'Người chơi',
      key: 'user',
      render: (_, row) => <UserBriefCell user={row.user} />,
    },
    {
      title: 'Bạn bè',
      dataIndex: 'friends',
      width: 110,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'friends' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Đã chặn',
      dataIndex: 'blocked',
      width: 110,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'blocked' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Được theo dõi',
      dataIndex: 'followers',
      width: 130,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'followers' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
    {
      title: 'Đang theo dõi',
      dataIndex: 'following',
      width: 130,
      align: 'right',
      sorter: true,
      sortOrder: userSort === 'following' ? 'descend' : null,
      sortDirections: ['descend'],
      render: (v: number) => formatCount(v),
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <DateRangeFilter
            from={from}
            to={to}
            onFromChange={changeRange(setFrom)}
            onToChange={changeRange(setTo)}
          />
          <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
            Tải lại
          </Button>
        </Space>
      </Card>

      <Card loading={statsFetching}>
        <Row gutter={[16, 16]}>
          <Col xs={12} md={4}>
            <Statistic
              title="Bạn bè"
              value={stats?.relationships.accepted ?? 0}
              valueStyle={{ color: '#3f8600' }}
              prefix={<UsergroupAddOutlined />}
            />
          </Col>
          <Col xs={12} md={4}>
            <Statistic title="Đang chờ" value={stats?.relationships.pending ?? 0} />
          </Col>
          <Col xs={12} md={4}>
            <Statistic title="Từ chối" value={stats?.relationships.rejected ?? 0} />
          </Col>
          <Col xs={12} md={4}>
            <Statistic
              title="Chặn"
              value={stats?.relationships.blocked ?? 0}
              valueStyle={{ color: '#cf1322' }}
            />
          </Col>
          <Col xs={12} md={4}>
            <Statistic title="Tổng lời mời" value={stats?.relationships.total ?? 0} />
          </Col>
          <Col xs={12} md={4}>
            <Statistic
              title="Lượt theo dõi"
              value={stats?.follows.total ?? 0}
              valueStyle={{ color: '#1677ff' }}
            />
          </Col>
        </Row>
      </Card>

      <Card>
        <Tabs
          items={[
            {
              key: 'relationships',
              label: 'Kết bạn / Chặn',
              children: (
                <Space direction="vertical" size={12} style={{ width: '100%' }}>
                  <Space wrap>
                    <Select
                      allowClear
                      placeholder="Trạng thái"
                      value={relStatus}
                      onChange={(value) => {
                        setRelStatus(value)
                        setRelPage(1)
                      }}
                      options={(Object.keys(STATUS_META) as RelationshipStatus[]).map(
                        (key) => ({ value: key, label: STATUS_META[key].label }),
                      )}
                      style={{ width: 160 }}
                    />
                    <Input.Search
                      allowClear
                      placeholder="Lọc theo User ID"
                      onSearch={searchUser(setRelUser, setRelPage)}
                      style={{ width: 260 }}
                    />
                  </Space>
                  <Table<RelationshipItem>
                    rowKey="id"
                    size="small"
                    loading={relFetching}
                    columns={relationshipColumns}
                    dataSource={relationships?.items ?? []}
                    pagination={{
                      current: relPage,
                      pageSize: PAGE_SIZE,
                      total: relationships?.total ?? 0,
                      showSizeChanger: false,
                      showTotal: (total) => `${formatCount(total)} lời mời`,
                      onChange: setRelPage,
                    }}
                    locale={{ emptyText: 'Chưa có quan hệ nào' }}
                  />
                </Space>
              ),
            },
            {
              key: 'follows',
              label: 'Theo dõi',
              children: (
                <Space direction="vertical" size={12} style={{ width: '100%' }}>
                  <Input.Search
                    allowClear
                    placeholder="Lọc theo User ID"
                    onSearch={searchUser(setFollowUser, setFollowPage)}
                    style={{ width: 260 }}
                  />
                  <Table<FollowItem>
                    rowKey="id"
                    size="small"
                    loading={followsFetching}
                    columns={followColumns}
                    dataSource={follows?.items ?? []}
                    pagination={{
                      current: followPage,
                      pageSize: PAGE_SIZE,
                      total: follows?.total ?? 0,
                      showSizeChanger: false,
                      showTotal: (total) => `${formatCount(total)} lượt theo dõi`,
                      onChange: setFollowPage,
                    }}
                    locale={{ emptyText: 'Chưa có lượt theo dõi nào' }}
                  />
                </Space>
              ),
            },
            {
              key: 'users',
              label: 'Theo user',
              children: (
                <Space direction="vertical" size={12} style={{ width: '100%' }}>
                  <Input.Search
                    allowClear
                    placeholder="Lọc theo User ID"
                    onSearch={searchUser(setUserSearch, setUserPage)}
                    style={{ width: 260 }}
                  />
                  <Table<RelationshipUserStatsItem>
                    rowKey={(row) => row.user.id}
                    size="small"
                    loading={userStatsFetching}
                    columns={userColumns}
                    dataSource={userStats?.items ?? []}
                    onChange={onUserTableChange}
                    pagination={{
                      current: userPage,
                      pageSize: PAGE_SIZE,
                      total: userStats?.total ?? 0,
                      showSizeChanger: false,
                      showTotal: (total) => `${formatCount(total)} user`,
                      onChange: setUserPage,
                    }}
                    locale={{ emptyText: 'Chưa có dữ liệu' }}
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
