import { useState } from 'react'
import { Outlet, useLocation, useNavigate } from 'react-router-dom'
import { Avatar, Dropdown, Layout, Menu, Typography } from 'antd'
import {
  AppstoreOutlined,
  CommentOutlined,
  LogoutOutlined,
  PictureOutlined,
  TeamOutlined,
  UserOutlined,
} from '@ant-design/icons'
import { AdminAuthService } from '@/services/adminAuth.service'
import { useAuthStore } from '@/store/authStore'

const { Sider, Header, Content } = Layout

const MENU_ITEMS = [
  { key: '/', icon: <AppstoreOutlined />, label: 'Tổng quan' },
  { key: '/users', icon: <TeamOutlined />, label: 'Người dùng' },
  { key: '/rooms', icon: <CommentOutlined />, label: 'Phòng chat' },
  { key: '/me', icon: <PictureOutlined />, label: 'Me' },
]

const PAGE_TITLES: Record<string, string> = {
  '/': 'Tổng quan',
  '/users': 'Quản lý người dùng',
  '/rooms': 'Quản lý phòng chat',
  '/me': 'Quản lý Me',
}

export function AdminLayout() {
  const navigate = useNavigate()
  const location = useLocation()
  const [collapsed, setCollapsed] = useState(false)
  const admin = useAuthStore((s) => s.admin)
  const clear = useAuthStore((s) => s.clear)

  const selectedKey =
    MENU_ITEMS.map((item) => item.key)
      .filter((key) => key !== '/' && location.pathname.startsWith(key))
      .sort((a, b) => b.length - a.length)[0] ?? '/'

  function logout() {
    AdminAuthService.logout()
    clear()
    navigate('/login', { replace: true })
  }

  return (
    <Layout style={{ minHeight: '100dvh' }}>
      <Sider
        collapsible
        collapsed={collapsed}
        onCollapse={setCollapsed}
        breakpoint="lg"
        width={232}
      >
        <div
          style={{
            height: 60,
            display: 'flex',
            alignItems: 'center',
            gap: 10,
            padding: '0 20px',
            color: '#fff',
          }}
        >
          <Avatar src="/favicon.png" size={32} shape="square" />
          {!collapsed && (
            <Typography.Text strong style={{ color: '#fff', fontSize: 16 }}>
              Ola Admin
            </Typography.Text>
          )}
        </div>
        <Menu
          theme="dark"
          mode="inline"
          selectedKeys={[selectedKey]}
          items={MENU_ITEMS}
          onClick={({ key }) => navigate(key)}
        />
      </Sider>

      <Layout>
        <Header
          style={{
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'space-between',
            borderBottom: '1px solid #e6e9ef',
          }}
        >
          <Typography.Title level={4} style={{ margin: 0 }}>
            {PAGE_TITLES[selectedKey] ?? 'Tổng quan'}
          </Typography.Title>
          <Dropdown
            menu={{
              items: [
                {
                  key: 'logout',
                  icon: <LogoutOutlined />,
                  label: 'Đăng xuất',
                  danger: true,
                  onClick: logout,
                },
              ],
            }}
          >
            <div
              style={{ display: 'flex', alignItems: 'center', gap: 10, cursor: 'pointer' }}
            >
              <Avatar src={admin?.avatar} icon={<UserOutlined />} />
              <div style={{ lineHeight: 1.2 }}>
                <div style={{ fontWeight: 600 }}>{admin?.fullName || admin?.username}</div>
                <div style={{ fontSize: 12, color: '#6b7785' }}>{admin?.role}</div>
              </div>
            </div>
          </Dropdown>
        </Header>

        <Content style={{ margin: 24 }}>
          <Outlet />
        </Content>
      </Layout>
    </Layout>
  )
}
