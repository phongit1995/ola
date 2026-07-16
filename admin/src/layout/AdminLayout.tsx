import { useState } from 'react'
import { Outlet, useLocation, useNavigate } from 'react-router-dom'
import { Avatar, Dropdown, Layout, Menu, Typography } from 'antd'
import {
  AimOutlined,
  AppstoreOutlined,
  CommentOutlined,
  FlagOutlined,
  CrownOutlined,
  DollarOutlined,
  FileSearchOutlined,
  GiftOutlined,
  LockOutlined,
  LogoutOutlined,
  PlayCircleOutlined,
  RocketOutlined,
  SettingOutlined,
  SmileOutlined,
  SwapOutlined,
  PictureOutlined,
  TeamOutlined,
  UserOutlined,
} from '@ant-design/icons'
import { AdminAuthService } from '@/services/adminAuth.service'
import { ChangePasswordModal } from '@/pages/ChangePasswordModal'
import { useAuthStore } from '@/store/authStore'

const { Sider, Header, Content } = Layout

const MENU_ITEMS = [
  { key: '/', icon: <AppstoreOutlined />, label: 'Tổng quan' },
  { key: '/users', icon: <TeamOutlined />, label: 'Người dùng' },
  { key: '/rooms', icon: <CommentOutlined />, label: 'Phòng chat' },
  { key: '/clans', icon: <FlagOutlined />, label: 'Clan' },
  {
    key: 'vip',
    icon: <CrownOutlined />,
    label: 'VIP',
    children: [
      { key: '/vip-packages', icon: <CrownOutlined />, label: 'Gói ngày VIP' },
      { key: '/vip-shop', icon: <SmileOutlined />, label: 'Shop VIP' },
      { key: '/vip-transfers', icon: <SwapOutlined />, label: 'Lịch sử chuyển VIP' },
    ],
  },
  {
    key: 'games',
    icon: <RocketOutlined />,
    label: 'Trò chơi',
    children: [
      { key: '/games/egg', icon: <GiftOutlined />, label: 'Đập trứng' },
      { key: '/games/wheel', icon: <AppstoreOutlined />, label: 'Vòng quay' },
      { key: '/games/pen', icon: <AimOutlined />, label: 'Sút Pen' },
      { key: '/games/ken-treasure', icon: <GiftOutlined />, label: 'Rương Ken' },
      { key: '/games/mini-game', icon: <PlayCircleOutlined />, label: 'Mini game' },
    ],
  },
  { key: '/me', icon: <PictureOutlined />, label: 'Me' },
  { key: '/audit-logs', icon: <FileSearchOutlined />, label: 'Nhật ký admin' },
  {
    key: 'settings',
    icon: <SettingOutlined />,
    label: 'Cài đặt hệ thống',
    children: [{ key: '/settings/topup', icon: <DollarOutlined />, label: 'Nạp KEN' }],
  },
]

const LEAF_KEYS = MENU_ITEMS.flatMap((item) => {
  const children = (item as { children?: { key: string }[] }).children
  return children ? children.map((child) => child.key) : [item.key]
})

const VIP_KEYS = ['/vip-packages', '/vip-shop', '/vip-transfers']

const PAGE_TITLES: Record<string, string> = {
  '/': 'Tổng quan',
  '/users': 'Quản lý người dùng',
  '/rooms': 'Quản lý phòng chat',
  '/clans': 'Quản lý clan',
  '/vip-packages': 'Quản lý gói VIP',
  '/vip-shop': 'Shop VIP',
  '/vip-transfers': 'Lịch sử chuyển VIP',
  '/games/egg': 'Đập trứng',
  '/games/egg/stats': 'Thống kê trứng',
  '/games/wheel': 'Vòng quay may mắn',
  '/games/wheel/stats': 'Thống kê vòng quay',
  '/games/pen': 'Sút Pen',
  '/games/pen/stats': 'Thống kê Pen',
  '/games/ken-treasure': 'Rương Ken',
  '/games/mini-game': 'Mini game',
  '/me': 'Quản lý Me',
  '/audit-logs': 'Nhật ký admin',
  '/settings/topup': 'Cài đặt nạp KEN',
}

export function AdminLayout() {
  const navigate = useNavigate()
  const location = useLocation()
  const [collapsed, setCollapsed] = useState(false)
  const [passwordOpen, setPasswordOpen] = useState(false)
  const admin = useAuthStore((s) => s.admin)
  const clear = useAuthStore((s) => s.clear)

  const selectedKey =
    LEAF_KEYS.filter((key) => key !== '/' && location.pathname.startsWith(key)).sort(
      (a, b) => b.length - a.length,
    )[0] ?? '/'

  const openKeys = [
    ...(VIP_KEYS.includes(selectedKey) ? ['vip'] : []),
    ...(selectedKey.startsWith('/games') ? ['games'] : []),
    ...(selectedKey.startsWith('/settings') ? ['settings'] : []),
  ]

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
          defaultOpenKeys={openKeys}
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
            {PAGE_TITLES[location.pathname] ?? PAGE_TITLES[selectedKey] ?? 'Tổng quan'}
          </Typography.Title>
          <Dropdown
            menu={{
              items: [
                {
                  key: 'change-password',
                  icon: <LockOutlined />,
                  label: 'Đổi mật khẩu',
                  onClick: () => setPasswordOpen(true),
                },
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

      <ChangePasswordModal
        open={passwordOpen}
        onClose={() => setPasswordOpen(false)}
        onChanged={logout}
      />
    </Layout>
  )
}
