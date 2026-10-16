import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { App, Button, Form, Grid, Input, Typography } from 'antd'
import { LockOutlined, SafetyCertificateOutlined, UserOutlined } from '@ant-design/icons'
import { AdminAuthService } from '@/services/adminAuth.service'
import { useAuthStore } from '@/store/authStore'
import { ApiError } from '@/lib/apiError'
import { BRAND } from '@/theme'
import type { AdminLoginRequest } from '@/types'

export function LoginPage() {
  const navigate = useNavigate()
  const screens = Grid.useBreakpoint()
  const { message } = App.useApp()
  const setAdmin = useAuthStore((s) => s.setAdmin)
  const [loading, setLoading] = useState(false)

  async function onFinish(values: AdminLoginRequest) {
    setLoading(true)
    try {
      const result = await AdminAuthService.login(values)
      setAdmin(result.admin)
      navigate('/', { replace: true })
    } catch (err) {
      const text =
        err instanceof ApiError ? err.message : 'Đăng nhập thất bại, vui lòng thử lại.'
      message.error(text)
    } finally {
      setLoading(false)
    }
  }

  const showBrandPanel = screens.lg

  return (
    <div style={{ display: 'flex', minHeight: '100vh', background: '#fff' }}>
      {showBrandPanel && (
        <div
          style={{
            flex: '0 0 46%',
            position: 'relative',
            overflow: 'hidden',
            background: `linear-gradient(150deg, ${BRAND.primaryDark} 0%, ${BRAND.primary} 60%, ${BRAND.primaryHover} 100%)`,
            color: '#fff',
            padding: 56,
            display: 'flex',
            flexDirection: 'column',
            justifyContent: 'space-between',
          }}
        >
          <Decoration />
          <div style={{ position: 'relative', zIndex: 1 }}>
            <div
              style={{
                display: 'inline-flex',
                alignItems: 'center',
                justifyContent: 'center',
                width: 48,
                height: 48,
                borderRadius: 14,
                background: 'rgba(255,255,255,0.16)',
                fontSize: 22,
                fontWeight: 700,
                letterSpacing: 0.5,
              }}
            >
              Ola
            </div>
          </div>
          <div style={{ position: 'relative', zIndex: 1 }}>
            <Typography.Title
              level={2}
              style={{ color: '#fff', marginBottom: 12, fontWeight: 700 }}
            >
              Trang quản trị Ola
            </Typography.Title>
            <Typography.Paragraph
              style={{ color: 'rgba(255,255,255,0.85)', fontSize: 16, maxWidth: 380 }}
            >
              Quản lý người dùng, phòng chat và vận hành hệ thống trong một bảng điều
              khiển duy nhất.
            </Typography.Paragraph>
          </div>
          <div
            style={{
              position: 'relative',
              zIndex: 1,
              display: 'flex',
              alignItems: 'center',
              gap: 8,
              color: 'rgba(255,255,255,0.8)',
              fontSize: 13,
            }}
          >
            <SafetyCertificateOutlined />
            Kết nối được mã hoá &middot; Chỉ dành cho quản trị viên
          </div>
        </div>
      )}

      <div
        style={{
          flex: 1,
          display: 'flex',
          alignItems: 'center',
          justifyContent: 'center',
          padding: 24,
        }}
      >
        <div style={{ width: '100%', maxWidth: 380 }}>
          <div style={{ marginBottom: 32 }}>
            <Typography.Title level={3} style={{ marginBottom: 6 }}>
              Đăng nhập
            </Typography.Title>
            <Typography.Text type="secondary">
              Nhập thông tin quản trị viên để tiếp tục.
            </Typography.Text>
          </div>

          <Form
            layout="vertical"
            requiredMark={false}
            onFinish={onFinish}
            disabled={loading}
            size="large"
          >
            <Form.Item
              name="username"
              label="Tên đăng nhập"
              rules={[{ required: true, message: 'Vui lòng nhập tên đăng nhập' }]}
            >
              <Input
                prefix={<UserOutlined style={{ color: BRAND.textMuted }} />}
                placeholder="admin"
                autoComplete="username"
              />
            </Form.Item>
            <Form.Item
              name="password"
              label="Mật khẩu"
              rules={[{ required: true, message: 'Vui lòng nhập mật khẩu' }]}
            >
              <Input.Password
                prefix={<LockOutlined style={{ color: BRAND.textMuted }} />}
                placeholder="••••••••"
                autoComplete="current-password"
              />
            </Form.Item>
            <Form.Item style={{ marginTop: 8, marginBottom: 0 }}>
              <Button type="primary" htmlType="submit" block loading={loading}>
                Đăng nhập
              </Button>
            </Form.Item>
          </Form>
        </div>
      </div>
    </div>
  )
}

function Decoration() {
  return (
    <>
      <span
        style={{
          position: 'absolute',
          top: -80,
          right: -60,
          width: 260,
          height: 260,
          borderRadius: '50%',
          background: 'rgba(255,255,255,0.10)',
        }}
      />
      <span
        style={{
          position: 'absolute',
          bottom: -100,
          left: -70,
          width: 320,
          height: 320,
          borderRadius: '50%',
          background: 'rgba(255,255,255,0.06)',
        }}
      />
    </>
  )
}
