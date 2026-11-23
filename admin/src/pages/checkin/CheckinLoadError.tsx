import { Alert, Button } from 'antd'
import { ReloadOutlined } from '@ant-design/icons'

export function CheckinLoadError({ onRetry }: { onRetry: () => void }) {
  return (
    <Alert
      type="error"
      showIcon
      style={{ marginBottom: 12 }}
      title="Không tải được dữ liệu điểm danh"
      description="Kiểm tra kết nối rồi bấm Thử lại. Chưa tải được thì đừng tạo lịch mới, vì tháng này có thể đã có lịch."
      action={
        <Button size="small" icon={<ReloadOutlined />} onClick={onRetry}>
          Thử lại
        </Button>
      }
    />
  )
}
