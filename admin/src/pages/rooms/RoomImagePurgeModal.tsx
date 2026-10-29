import { useRef, useState } from 'react'
import { Alert, App, Button, InputNumber, Modal, Space, Typography } from 'antd'
import { CalculatorOutlined, DeleteOutlined } from '@ant-design/icons'
import { formatBytes, formatCount, formatDateTime } from '@/lib/format'
import { errorMessage } from '@/lib/apiError'
import type { RoomImagePurgePreview, RoomImagePurgeResult } from '@/types'
import { ROOM_IMAGE_PURGE_MAX_DAYS, ROOM_IMAGE_PURGE_MIN_DAYS } from './constants'
import { usePreviewRoomImagePurge, usePurgeRoomImages } from './useRoomQueries'

interface RoomImagePurgeModalProps {
  open: boolean
  onClose: () => void
}

function purgeResultText(result: RoomImagePurgeResult): string {
  const done = `Đã xoá ${formatCount(result.files)} ảnh, giải phóng ${formatBytes(result.bytes)}`
  if (result.failed === 0) return done
  return `${done}. Còn ${formatCount(result.failed)} ảnh chưa xoá được, bấm tính lại rồi xoá tiếp`
}

export function RoomImagePurgeModal({ open, onClose }: RoomImagePurgeModalProps) {
  const { message, modal } = App.useApp()
  const [days, setDays] = useState(ROOM_IMAGE_PURGE_MIN_DAYS)
  const [preview, setPreview] = useState<RoomImagePurgePreview | null>(null)
  const latestRequest = useRef(0)
  const previewPurge = usePreviewRoomImagePurge()
  const purge = usePurgeRoomImages()
  const activePreview = preview != null && preview.olderThanDays === days ? preview : null

  function discardPreview() {
    latestRequest.current += 1
    setPreview(null)
  }

  function changeDays(value: number | null) {
    setDays(value ?? ROOM_IMAGE_PURGE_MIN_DAYS)
    discardPreview()
  }

  function close() {
    setDays(ROOM_IMAGE_PURGE_MIN_DAYS)
    discardPreview()
    onClose()
  }

  async function calculate() {
    latestRequest.current += 1
    const request = latestRequest.current
    try {
      const result = await previewPurge.mutateAsync(days)
      if (request === latestRequest.current) setPreview(result)
    } catch (err) {
      if (request === latestRequest.current) {
        message.error(errorMessage(err, 'Không tính được dung lượng'))
      }
    }
  }

  function confirmPurge(target: RoomImagePurgePreview) {
    modal.confirm({
      title: `Xoá ${formatCount(target.files)} ảnh (${formatBytes(target.bytes)})?`,
      content: `File ảnh trong phòng chat gửi trước ${formatDateTime(target.before)} sẽ bị xoá vĩnh viễn, không khôi phục được. Tin nhắn vẫn giữ nguyên trong lịch sử phòng nhưng không xem được ảnh nữa.`,
      okText: 'Xoá vĩnh viễn',
      okButtonProps: { danger: true },
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          const result = await purge.mutateAsync(target.before)
          if (result.failed > 0) {
            message.warning(purgeResultText(result))
          } else {
            message.success(purgeResultText(result))
          }
          close()
        } catch (err) {
          message.error(errorMessage(err, 'Xoá ảnh thất bại'))
        }
      },
    })
  }

  return (
    <Modal
      open={open}
      title="Xoá ảnh cũ trong phòng chat"
      onCancel={close}
      destroyOnHidden
      footer={[
        <Button key="close" onClick={close}>
          Đóng
        </Button>,
        <Button
          key="purge"
          danger
          type="primary"
          icon={<DeleteOutlined />}
          disabled={activePreview == null || activePreview.files === 0}
          loading={purge.isPending}
          onClick={() => activePreview && confirmPurge(activePreview)}
        >
          {activePreview != null && activePreview.files > 0
            ? `Xoá ${formatCount(activePreview.files)} ảnh`
            : 'Xoá ảnh'}
        </Button>,
      ]}
    >
      <Typography.Paragraph type="secondary">
        Chỉ xoá file ảnh mọi người gửi trong tất cả phòng chat, cũ hơn số ngày bên dưới. Tin nhắn vẫn
        giữ nguyên trong lịch sử phòng. Ảnh của tin nhắn đang bị báo cáo chờ xử lý được giữ lại. Tối
        thiểu {ROOM_IMAGE_PURGE_MIN_DAYS} ngày.
      </Typography.Paragraph>
      <Space wrap>
        <InputNumber<number>
          min={ROOM_IMAGE_PURGE_MIN_DAYS}
          max={ROOM_IMAGE_PURGE_MAX_DAYS}
          precision={0}
          value={days}
          onChange={changeDays}
          suffix="ngày"
          style={{ width: 160 }}
        />
        <Button
          icon={<CalculatorOutlined />}
          loading={previewPurge.isPending}
          onClick={() => void calculate()}
        >
          Tính dung lượng
        </Button>
      </Space>
      {activePreview != null && (
        <Alert
          style={{ marginTop: 16 }}
          type={activePreview.files > 0 ? 'warning' : 'info'}
          showIcon
          title={
            activePreview.files > 0
              ? `Sẽ xoá ${formatCount(activePreview.files)} ảnh, giải phóng ${formatBytes(activePreview.bytes)}`
              : `Không có ảnh nào cũ hơn ${activePreview.olderThanDays} ngày`
          }
          description={
            <>
              <div>Ảnh gửi trước {formatDateTime(activePreview.before)}.</div>
              {activePreview.kept > 0 && (
                <div>
                  Giữ lại {formatCount(activePreview.kept)} ảnh của tin nhắn đang bị báo cáo chờ xử lý.
                </div>
              )}
            </>
          }
        />
      )}
    </Modal>
  )
}
