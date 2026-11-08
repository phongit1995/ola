import { useMemo, useState } from 'react'
import {
  Alert,
  App,
  Button,
  Checkbox,
  Empty,
  Form,
  Input,
  InputNumber,
  Modal,
  Pagination,
  Space,
  Switch,
  Typography,
  theme,
} from 'antd'
import { CheckCircleFilled } from '@ant-design/icons'
import type { AvatarFrame } from '@ola/shared/lib/avatarFrame'
import { errorMessage } from '@/lib/apiError'
import { formatCount, kenNumberInputProps } from '@/lib/format'
import { useCreateAvatarFrameShopItems } from './useAvatarFrameQueries'
import {
  AVATAR_FRAME_DEFAULT_PRICE,
  AVATAR_FRAME_MAX_BATCH,
  AVATAR_FRAME_PICKER_PAGE_SIZE,
} from './constants'
import { filterAvatarFrames } from './utils'

const PICKER_IMAGE_SIZE = 80

interface AddFramesFormValues {
  kenPrice: number
  sortOrder: number
  isActive: boolean
}

interface AddAvatarFramesModalProps {
  open: boolean
  shopFrameIds: ReadonlySet<string>
  onClose: () => void
}

function FrameTile({
  frame,
  selected,
  inShop,
  onToggle,
}: {
  frame: AvatarFrame
  selected: boolean
  inShop: boolean
  onToggle: (id: string) => void
}) {
  const { token } = theme.useToken()
  const borderColor = selected ? token.colorPrimary : token.colorBorderSecondary
  return (
    <button
      type="button"
      disabled={inShop}
      onClick={() => onToggle(frame.id)}
      title={inShop ? 'Đã có trong cửa hàng' : frame.name || `#${frame.id}`}
      style={{
        position: 'relative',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
        gap: 2,
        padding: 6,
        border: `${selected ? 2 : 1}px solid ${borderColor}`,
        borderRadius: token.borderRadiusLG,
        background: selected ? `${token.colorPrimary}14` : token.colorBgContainer,
        cursor: inShop ? 'not-allowed' : 'pointer',
        opacity: inShop ? 0.45 : 1,
        minWidth: 0,
        font: 'inherit',
      }}
    >
      {selected && (
        <CheckCircleFilled
          style={{ position: 'absolute', top: 6, right: 6, color: token.colorPrimary, fontSize: 16 }}
        />
      )}
      <img
        src={frame.url}
        alt={frame.name}
        loading="lazy"
        width={PICKER_IMAGE_SIZE}
        height={PICKER_IMAGE_SIZE}
        style={{ objectFit: 'contain' }}
      />
      <Typography.Text
        ellipsis
        style={{ maxWidth: '100%', fontSize: 12 }}
        type={frame.name ? undefined : 'secondary'}
      >
        {frame.name || `#${frame.id}`}
      </Typography.Text>
      <Typography.Text type="secondary" style={{ fontSize: 11 }}>
        {inShop ? `#${frame.id} · đã bán` : `#${frame.id}`}
      </Typography.Text>
    </button>
  )
}

export function AddAvatarFramesModal({ open, shopFrameIds, onClose }: AddAvatarFramesModalProps) {
  const { message, modal } = App.useApp()
  const [form] = Form.useForm<AddFramesFormValues>()
  const [search, setSearch] = useState('')
  const [hideInShop, setHideInShop] = useState(true)
  const [page, setPage] = useState(1)
  const [selected, setSelected] = useState<string[]>([])
  const createItems = useCreateAvatarFrameShopItems()

  const selectedSet = useMemo(() => new Set(selected), [selected])

  const frames = useMemo(() => {
    const matched = filterAvatarFrames(search)
    return hideInShop ? matched.filter((frame) => !shopFrameIds.has(frame.id)) : matched
  }, [search, hideInShop, shopFrameIds])

  const pageFrames = frames.slice(
    (page - 1) * AVATAR_FRAME_PICKER_PAGE_SIZE,
    page * AVATAR_FRAME_PICKER_PAGE_SIZE,
  )
  const selectablePageIds = pageFrames
    .filter((frame) => !shopFrameIds.has(frame.id))
    .map((frame) => frame.id)
  const pageAllSelected =
    selectablePageIds.length > 0 && selectablePageIds.every((id) => selectedSet.has(id))
  const overLimit = selected.length > AVATAR_FRAME_MAX_BATCH

  function reset() {
    setSearch('')
    setHideInShop(true)
    setPage(1)
    setSelected([])
  }

  function close() {
    reset()
    onClose()
  }

  function toggle(id: string) {
    setSelected((prev) => (prev.includes(id) ? prev.filter((x) => x !== id) : [...prev, id]))
  }

  function togglePage() {
    setSelected((prev) => {
      if (pageAllSelected) {
        const drop = new Set(selectablePageIds)
        return prev.filter((id) => !drop.has(id))
      }
      const next = new Set(prev)
      selectablePageIds.forEach((id) => next.add(id))
      return [...next]
    })
  }

  async function onOk() {
    if (selected.length === 0) {
      message.warning('Chọn ít nhất một khung')
      return
    }
    if (overLimit) return
    const values = await form.validateFields()
    try {
      const result = await createItems.mutateAsync({
        frameIds: [...selected].sort(),
        kenPrice: values.kenPrice,
        sortOrder: values.sortOrder ?? 0,
        isActive: values.isActive,
      })
      if (result.skipped.length > 0) {
        modal.info({
          title: `Đã thêm ${formatCount(result.created.length)} khung`,
          content: `Bỏ qua ${formatCount(result.skipped.length)} khung đã có trong cửa hàng: ${result.skipped
            .map((id) => `#${id}`)
            .join(', ')}`,
          okText: 'Đóng',
        })
      } else {
        message.success(`Đã thêm ${formatCount(result.created.length)} khung vào cửa hàng`)
      }
      close()
    } catch (err) {
      message.error(errorMessage(err, 'Thêm khung thất bại'))
    }
  }

  return (
    <Modal
      title="Thêm khung vào cửa hàng"
      open={open}
      width={980}
      onOk={onOk}
      onCancel={close}
      okText={selected.length > 0 ? `Thêm ${formatCount(selected.length)} khung` : 'Thêm'}
      cancelText="Huỷ"
      okButtonProps={{ disabled: selected.length === 0 || overLimit }}
      confirmLoading={createItems.isPending}
      destroyOnHidden
    >
      <Space orientation="vertical" size={12} style={{ width: '100%' }}>
        <Space wrap style={{ width: '100%', justifyContent: 'space-between' }}>
          <Space wrap>
            <Input.Search
              allowClear
              placeholder="Tìm theo mã hoặc tên khung"
              value={search}
              onChange={(e) => {
                setSearch(e.target.value)
                setPage(1)
              }}
              style={{ width: 300 }}
            />
            <Checkbox
              checked={hideInShop}
              onChange={(e) => {
                setHideInShop(e.target.checked)
                setPage(1)
              }}
            >
              Ẩn khung đã có trong cửa hàng
            </Checkbox>
          </Space>
          <Space wrap>
            <Typography.Text type="secondary">
              {formatCount(frames.length)} khung · đã chọn{' '}
              <Typography.Text strong type={overLimit ? 'danger' : undefined}>
                {formatCount(selected.length)}
              </Typography.Text>
            </Typography.Text>
            <Button size="small" disabled={selectablePageIds.length === 0} onClick={togglePage}>
              {pageAllSelected ? 'Bỏ chọn trang này' : 'Chọn cả trang'}
            </Button>
            <Button size="small" disabled={selected.length === 0} onClick={() => setSelected([])}>
              Bỏ chọn hết
            </Button>
          </Space>
        </Space>

        {overLimit && (
          <Alert
            type="error"
            showIcon
            title={`Mỗi lần thêm tối đa ${AVATAR_FRAME_MAX_BATCH} khung. Bỏ bớt ${formatCount(
              selected.length - AVATAR_FRAME_MAX_BATCH,
            )} khung.`}
          />
        )}

        <div style={{ height: 440, overflowY: 'auto', paddingRight: 4 }}>
          {pageFrames.length === 0 ? (
            <Empty description="Không có khung phù hợp" style={{ marginTop: 80 }} />
          ) : (
            <div
              style={{
                display: 'grid',
                gridTemplateColumns: 'repeat(auto-fill, minmax(108px, 1fr))',
                gap: 8,
              }}
            >
              {pageFrames.map((frame) => (
                <FrameTile
                  key={frame.id}
                  frame={frame}
                  selected={selectedSet.has(frame.id)}
                  inShop={shopFrameIds.has(frame.id)}
                  onToggle={toggle}
                />
              ))}
            </div>
          )}
        </div>

        <div style={{ display: 'flex', justifyContent: 'flex-end' }}>
          <Pagination
            size="small"
            current={page}
            pageSize={AVATAR_FRAME_PICKER_PAGE_SIZE}
            total={frames.length}
            showSizeChanger={false}
            onChange={setPage}
          />
        </div>

        <Form
          form={form}
          layout="inline"
          requiredMark={false}
          initialValues={{ kenPrice: AVATAR_FRAME_DEFAULT_PRICE, sortOrder: 0, isActive: true }}
          style={{ rowGap: 8 }}
        >
          <Form.Item
            name="kenPrice"
            label="Giá (KEN)"
            rules={[{ required: true, message: 'Vui lòng nhập giá' }]}
          >
            <InputNumber min={0} style={{ width: 160 }} {...kenNumberInputProps} />
          </Form.Item>
          <Form.Item name="sortOrder" label="Thứ tự" tooltip="Nhỏ hơn hiển thị trước">
            <InputNumber min={0} style={{ width: 100 }} />
          </Form.Item>
          <Form.Item name="isActive" label="Bán ngay" valuePropName="checked">
            <Switch />
          </Form.Item>
        </Form>
        <Typography.Text type="secondary" style={{ fontSize: 12 }}>
          Các khung đã chọn dùng chung một giá, thứ tự và trạng thái. Sửa từng khung sau ở danh sách.
        </Typography.Text>
      </Space>
    </Modal>
  )
}
