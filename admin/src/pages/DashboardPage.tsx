import { useMemo, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import {
  Button,
  Card,
  Col,
  Empty,
  Row,
  Space,
  Spin,
  Statistic,
  Table,
  Typography,
} from 'antd'
import type { ColumnsType } from 'antd/es/table'
import { ArrowRightOutlined } from '@ant-design/icons'
import {
  Bar,
  CartesianGrid,
  Cell,
  ComposedChart,
  Legend,
  Line,
  Pie,
  PieChart,
  ResponsiveContainer,
  Tooltip as RTooltip,
  XAxis,
  YAxis,
} from 'recharts'
import { useDashboardOverview } from '@/hooks/useDashboard'
import type { DashboardSpendByType } from '@/types'

const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

const KEN_TYPE_LABEL: Record<string, string> = {
  VIP_PACKAGE: 'Mua gói VIP',
  VIP_ICON: 'Mua VIP icon',
  ADMIN_DEDUCT: 'Admin trừ',
  ADMIN_GRANT: 'Admin cộng',
  REWARD: 'Thưởng',
  EGG_OPEN: 'Đập trứng',
  TOPUP: 'Nạp KEN',
  REFUND: 'Hoàn tiền',
  GIFT_SENT: 'Tặng quà',
  GIFT_RECEIVED: 'Nhận quà',
  TRANSFER_IN: 'Chuyển đến',
  TRANSFER_OUT: 'Chuyển đi',
  PEN_SHOOT: 'Sút penalty',
  PEN_CATCH: 'Bắt penalty',
  PEN_WIN: 'Thắng penalty',
  PEN_REFUND: 'Hoàn penalty',
  KEN_CHEST: 'Rương KEN',
}

function isoDate(d: Date) {
  return d.toISOString().slice(0, 10)
}

function vn(n: number) {
  return n.toLocaleString('vi-VN')
}

function kenTypeLabel(type: string) {
  return KEN_TYPE_LABEL[type] ?? type
}

const spendColumns: ColumnsType<DashboardSpendByType> = [
  {
    title: 'Loại chi tiêu',
    dataIndex: 'type',
    render: (type: string) => kenTypeLabel(type),
  },
  {
    title: 'KEN',
    dataIndex: 'amount',
    width: 130,
    align: 'right',
    render: (v: number) => vn(v),
  },
  {
    title: 'Lượt',
    dataIndex: 'count',
    width: 100,
    align: 'right',
    render: (v: number) => vn(v),
  },
]

export function DashboardPage() {
  const navigate = useNavigate()
  const [from, setFrom] = useState(() => isoDate(new Date(Date.now() - 29 * 24 * 60 * 60 * 1000)))
  const [to, setTo] = useState(() => isoDate(new Date()))

  const params = useMemo(
    () => ({
      from: from ? new Date(`${from}T00:00:00`).toISOString() : undefined,
      to: to ? new Date(`${to}T23:59:59.999`).toISOString() : undefined,
    }),
    [from, to],
  )
  const { data, isFetching } = useDashboardOverview(params)

  const genderPie = useMemo(
    () =>
      data
        ? [
            { name: 'Nam', value: data.users.male, color: '#2563eb' },
            { name: 'Nữ', value: data.users.female, color: '#eb2f96' },
          ].filter((row) => row.value > 0)
        : [],
    [data],
  )

  const bucketLabel = data?.bucket === 'month' ? 'tháng' : 'ngày'

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card>
        <Space wrap>
          <input
            type="date"
            aria-label="Từ ngày"
            value={from}
            max={to || undefined}
            onChange={(e) => setFrom(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          <span style={{ color: '#8c8c8c' }}>→</span>
          <input
            type="date"
            aria-label="Đến ngày"
            value={to}
            min={from || undefined}
            onChange={(e) => setTo(e.target.value)}
            style={DATE_INPUT_STYLE}
          />
          {isFetching && <Spin size="small" />}
        </Space>
      </Card>

      <Row gutter={[16, 16]}>
        <Col xs={12} lg={6}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Đăng ký hôm nay"
              value={data?.registrations.today ?? 0}
              valueStyle={{ color: '#3f8600' }}
            />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card>
            <Statistic
              groupSeparator="."
              title="Đăng ký trong tuần"
              value={data?.registrations.week ?? 0}
              valueStyle={{ color: '#3f8600' }}
            />
          </Card>
        </Col>
      </Row>

      <Row gutter={[16, 16]}>
        <Col xs={12} sm={8} lg={4}>
          <Card>
            <Statistic groupSeparator="." title="Tổng người dùng" value={data?.totals.users ?? 0} />
            <Button type="link" style={{ paddingLeft: 0 }} onClick={() => navigate('/users')}>
              Quản lý <ArrowRightOutlined />
            </Button>
          </Card>
        </Col>
        <Col xs={12} sm={8} lg={4}>
          <Card>
            <Statistic groupSeparator="." title="Tổng bài đăng" value={data?.totals.posts ?? 0} />
            <Button type="link" style={{ paddingLeft: 0 }} onClick={() => navigate('/me')}>
              Quản lý <ArrowRightOutlined />
            </Button>
          </Card>
        </Col>
        <Col xs={12} sm={8} lg={4}>
          <Card>
            <Statistic groupSeparator="." title="Tổng phòng chat" value={data?.totals.rooms ?? 0} />
            <Button type="link" style={{ paddingLeft: 0 }} onClick={() => navigate('/rooms')}>
              Quản lý <ArrowRightOutlined />
            </Button>
          </Card>
        </Col>
        <Col xs={12} sm={8} lg={4}>
          <Card>
            <Statistic groupSeparator="." title="KEN đang lưu hành" value={data?.totals.kenInCirculation ?? 0} />
          </Card>
        </Col>
        <Col xs={12} sm={8} lg={4}>
          <Card>
            <Statistic groupSeparator="." title="Tổng nụ hôn" value={data?.totals.kisses ?? 0} />
          </Card>
        </Col>
        <Col xs={12} sm={8} lg={4}>
          <Card>
            <Statistic groupSeparator="." title="Cặp đang kết hôn" value={data?.totals.activeMarriages ?? 0} />
          </Card>
        </Col>
      </Row>

      {isFetching && !data ? (
        <Card>
          <div style={{ textAlign: 'center', padding: 60 }}>
            <Spin />
          </div>
        </Card>
      ) : !data ? (
        <Card>
          <Empty description="Chưa có dữ liệu" />
        </Card>
      ) : (
        <>
          <Typography.Title level={5} style={{ margin: '4px 0' }}>
            Trong khoảng đã chọn
          </Typography.Title>

          <Row gutter={[16, 16]}>
            <Col xs={12} sm={8} lg={4}>
              <Card>
                <Statistic groupSeparator="." title="Người dùng mới" value={data.users.new} valueStyle={{ color: '#3f8600' }} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={4}>
              <Card>
                <Statistic groupSeparator="." title="Đang hoạt động" value={data.users.active} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={4}>
              <Card>
                <Statistic groupSeparator="." title="Nạp KEN" value={data.revenue.topupKen} suffix="KEN" />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={4}>
              <Card>
                <Statistic groupSeparator="." title="Lượt nạp" value={data.revenue.topupCount} />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={4}>
              <Card>
                <Statistic groupSeparator="." title="Doanh thu VIP" value={data.revenue.vipRevenueKen} suffix="KEN" />
              </Card>
            </Col>
            <Col xs={12} sm={8} lg={4}>
              <Card>
                <Statistic groupSeparator="." title="Lượt mua VIP" value={data.revenue.vipPurchases} />
              </Card>
            </Col>
          </Row>

          <Card title={`Tăng trưởng & doanh thu theo ${bucketLabel}`}>
            <ResponsiveContainer width="100%" height={320}>
              <ComposedChart data={data.timeseries} margin={{ top: 8, right: 8, bottom: 8, left: 8 }}>
                <CartesianGrid strokeDasharray="3 3" stroke="#eee" />
                <XAxis dataKey="date" fontSize={12} />
                <YAxis yAxisId="left" fontSize={12} />
                <YAxis yAxisId="right" orientation="right" fontSize={12} />
                <RTooltip formatter={(value) => vn(Number(value))} />
                <Legend />
                <Bar yAxisId="left" dataKey="topupKen" name="Nạp KEN" fill="#2563eb" radius={[4, 4, 0, 0]} />
                <Bar yAxisId="left" dataKey="revenueKen" name="Doanh thu VIP" fill="#faad14" radius={[4, 4, 0, 0]} />
                <Line yAxisId="right" type="monotone" dataKey="newUsers" name="User mới" stroke="#5b8c2a" strokeWidth={2} />
                <Line yAxisId="right" type="monotone" dataKey="posts" name="Bài đăng" stroke="#eb2f96" strokeWidth={2} />
              </ComposedChart>
            </ResponsiveContainer>
          </Card>

          <Row gutter={[16, 16]}>
            <Col xs={24} lg={10}>
              <Card title="Phân bố giới tính">
                {genderPie.length === 0 ? (
                  <Empty description="Chưa có dữ liệu" />
                ) : (
                  <ResponsiveContainer width="100%" height={280}>
                    <PieChart>
                      <Pie data={genderPie} dataKey="value" nameKey="name" innerRadius={55} outerRadius={100} paddingAngle={2}>
                        {genderPie.map((entry) => (
                          <Cell key={entry.name} fill={entry.color} />
                        ))}
                      </Pie>
                      <RTooltip formatter={(value, name) => [`${vn(Number(value))} người`, name]} />
                      <Legend />
                    </PieChart>
                  </ResponsiveContainer>
                )}
                <Typography.Paragraph type="secondary" style={{ marginTop: 8, marginBottom: 0 }}>
                  Đã xác thực: {vn(data.users.verified)} người
                </Typography.Paragraph>
              </Card>
            </Col>
            <Col xs={24} lg={14}>
              <Card title="Chi tiêu KEN theo loại">
                <Table<DashboardSpendByType>
                  rowKey="type"
                  size="small"
                  columns={spendColumns}
                  dataSource={data.revenue.spendByType}
                  pagination={false}
                  locale={{ emptyText: 'Chưa có chi tiêu nào trong khoảng đã chọn' }}
                />
              </Card>
            </Col>
          </Row>

          <Row gutter={[16, 16]}>
            <Col xs={24} lg={12}>
              <Card title="Tương tác nội dung">
                <Row gutter={[16, 16]}>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Bài mới" value={data.engagement.newPosts} />
                  </Col>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Thích" value={data.engagement.likes} />
                  </Col>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Không thích" value={data.engagement.dislikes} />
                  </Col>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Bình luận" value={data.engagement.comments} />
                  </Col>
                </Row>
              </Card>
            </Col>
            <Col xs={24} lg={12}>
              <Card title="Xã hội">
                <Row gutter={[16, 16]}>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Theo dõi mới" value={data.social.newFollows} />
                  </Col>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Lời mời KB" value={data.social.friendRequests} />
                  </Col>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Kết bạn" value={data.social.newFriendships} />
                  </Col>
                  <Col xs={12} lg={6}>
                    <Statistic groupSeparator="." title="Kết hôn mới" value={data.social.newMarriages} />
                  </Col>
                </Row>
              </Card>
            </Col>
          </Row>

          <Card title="Lượt chơi game">
            <Row gutter={[16, 16]}>
              <Col xs={8}>
                <Statistic groupSeparator="." title="Đập trứng" value={data.games.eggDraws} />
              </Col>
              <Col xs={8}>
                <Statistic groupSeparator="." title="Vòng quay" value={data.games.wheelSpins} />
              </Col>
              <Col xs={8}>
                <Statistic groupSeparator="." title="Penalty" value={data.games.penShots} />
              </Col>
            </Row>
          </Card>
        </>
      )}
    </Space>
  )
}
