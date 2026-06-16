import { useNavigate } from 'react-router-dom'
import { Button, Card, Col, Row, Statistic, Typography } from 'antd'
import {
  ArrowRightOutlined,
  CommentOutlined,
  PictureOutlined,
  TeamOutlined,
} from '@ant-design/icons'
import { useUsers } from '@/hooks/useUsers'
import { useRooms } from '@/hooks/useRooms'
import { useMeList } from '@/hooks/useMe'

export function DashboardPage() {
  const navigate = useNavigate()
  const usersQuery = useUsers({ limit: 1, offset: 0 })
  const roomsQuery = useRooms({ limit: 1, offset: 0 })
  const meQuery = useMeList({ limit: 1, offset: 0 })

  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: 24 }}>
      <Row gutter={[16, 16]}>
        <Col xs={24} sm={12} lg={8}>
          <Card>
            <Statistic
              title="Tổng người dùng"
              value={usersQuery.data?.total ?? 0}
              loading={usersQuery.isLoading}
              prefix={<TeamOutlined style={{ color: '#5b8c2a' }} />}
            />
            <Button
              type="link"
              style={{ paddingLeft: 0 }}
              onClick={() => navigate('/users')}
            >
              Quản lý <ArrowRightOutlined />
            </Button>
          </Card>
        </Col>
        <Col xs={24} sm={12} lg={8}>
          <Card>
            <Statistic
              title="Tổng phòng chat"
              value={roomsQuery.data?.total ?? 0}
              loading={roomsQuery.isLoading}
              prefix={<CommentOutlined style={{ color: '#2563eb' }} />}
            />
            <Button
              type="link"
              style={{ paddingLeft: 0 }}
              onClick={() => navigate('/rooms')}
            >
              Quản lý <ArrowRightOutlined />
            </Button>
          </Card>
        </Col>
        <Col xs={24} sm={12} lg={8}>
          <Card>
            <Statistic
              title="Tổng bài đăng"
              value={meQuery.data?.total ?? 0}
              loading={meQuery.isLoading}
              prefix={<PictureOutlined style={{ color: '#d4380d' }} />}
            />
            <Button
              type="link"
              style={{ paddingLeft: 0 }}
              onClick={() => navigate('/me')}
            >
              Quản lý <ArrowRightOutlined />
            </Button>
          </Card>
        </Col>
      </Row>

      <Card>
        <Typography.Title level={5}>Chào mừng tới Ola Admin</Typography.Title>
        <Typography.Paragraph type="secondary" style={{ marginBottom: 0 }}>
          Dùng menu bên trái để quản lý người dùng và phòng chat. Số liệu thống kê chi
          tiết sẽ được bổ sung khi backend cung cấp API tương ứng.
        </Typography.Paragraph>
      </Card>
    </div>
  )
}
