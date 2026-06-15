import { useNavigate } from 'react-router-dom'
import { Button, Card, Result, Space } from 'antd'
import { AdminAuthService } from '@/services/adminAuth.service'
import { useAuthStore } from '@/store/authStore'

export function HomePlaceholder() {
  const navigate = useNavigate()
  const admin = useAuthStore((s) => s.admin)
  const clear = useAuthStore((s) => s.clear)

  function logout() {
    AdminAuthService.logout()
    clear()
    navigate('/login', { replace: true })
  }

  return (
    <div style={{ minHeight: '100vh', display: 'grid', placeItems: 'center', padding: 16 }}>
      <Card style={{ width: 480 }}>
        <Result
          status="success"
          title={`Xin chào, ${admin?.fullName || admin?.username}`}
          subTitle={`Vai trò: ${admin?.role}. Các màn quản trị sẽ được bổ sung tiếp.`}
          extra={
            <Space>
              <Button onClick={logout}>Đăng xuất</Button>
            </Space>
          }
        />
      </Card>
    </div>
  )
}
