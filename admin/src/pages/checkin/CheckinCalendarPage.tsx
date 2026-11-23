import { useState } from 'react'
import { Alert, App, Button, Card, Empty, InputNumber, Popconfirm, Segmented, Space, Spin, Tag, Typography } from 'antd'
import { DeleteOutlined, PlusOutlined, SaveOutlined, SendOutlined } from '@ant-design/icons'
import { DndContext, DragOverlay, PointerSensor, useSensor, useSensors } from '@dnd-kit/core'
import type { DragEndEvent, DragStartEvent } from '@dnd-kit/core'
import { errorMessage } from '@/lib/apiError'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { CHECKIN_SECTION_LINKS } from '@/pages/shop/sections'
import type { CheckinMonthDetail } from '@/types'
import { CheckinCreateMonthModal } from './CheckinCreateMonthModal'
import { CheckinLoadError } from './CheckinLoadError'
import { CheckinSlotCard, CheckinSlotCardView } from './CheckinSlotCard'
import { CheckinSlotModal } from './CheckinSlotModal'
import { CHECKIN_DRAG_ACTIVATION_DISTANCE, CHECKIN_GRID_COLUMNS, CHECKIN_MONTH_STATUS_META, CHECKIN_NEXT_MONTH_WARN_DAY } from './constants'
import type { CheckinMonthOption } from './types'
import {
  useCheckinMonth,
  useCheckinMonths,
  useDeleteCheckinMonth,
  usePublishCheckinMonth,
  useSwapCheckinSlots,
  useUpdateCheckinSlotCount,
} from './useCheckinQueries'
import {
  buildMonthOptions,
  daysInMonth,
  lockedThroughSlot,
  monthKey,
  monthLabel,
  monthShortLabel,
  monthStart,
  vnNow,
} from './utils'

function SlotCountEditor({ detail, status }: { detail: CheckinMonthDetail; status: CheckinMonthOption['status'] }) {
  const { message } = App.useApp()
  const updateSlotCount = useUpdateCheckinSlotCount()
  const [draft, setDraft] = useState<number | null>(detail.slotCount)
  const days = daysInMonth(detail.month)
  const readOnly = status === 'past'
  const min = status === 'running' ? detail.slotCount : 1
  const changed = draft != null && draft !== detail.slotCount

  async function save() {
    if (draft == null) return
    try {
      await updateSlotCount.mutateAsync({ month: detail.month, slotCount: draft })
      message.success(`Đã đổi số ô thành ${draft}`)
    } catch (err) {
      message.error(errorMessage(err, 'Đổi số ô thất bại'))
    }
  }

  return (
    <Space size={8} wrap>
      <Typography.Text>Số ô</Typography.Text>
      <InputNumber value={draft} onChange={setDraft} min={min} max={days} precision={0} disabled={readOnly} style={{ width: 80 }} />
      <Typography.Text type="secondary">
        / {days} ngày{status === 'running' ? ' · tháng đang chạy chỉ được tăng' : ''}
      </Typography.Text>
      {changed ? (
        <Button type="primary" size="small" icon={<SaveOutlined />} loading={updateSlotCount.isPending} onClick={save}>
          Lưu số ô
        </Button>
      ) : null}
    </Space>
  )
}

export function CheckinCalendarPage() {
  const { message } = App.useApp()
  const today = vnNow()
  const currentMonth = monthKey(today)
  const nextMonth = monthKey(today.add(1, 'month'))
  const [selected, setSelected] = useState(currentMonth)
  const [editingSlot, setEditingSlot] = useState<number | null>(null)
  const [creatingMonth, setCreatingMonth] = useState<string | null>(null)
  const [draggingSlot, setDraggingSlot] = useState<number | null>(null)
  const months = useCheckinMonths()
  const deleteMonth = useDeleteCheckinMonth()
  const publishMonth = usePublishCheckinMonth()
  const swapSlots = useSwapCheckinSlots()
  const sensors = useSensors(useSensor(PointerSensor, { activationConstraint: { distance: CHECKIN_DRAG_ACTIVATION_DISTANCE } }))
  const options = buildMonthOptions(months.data ?? [], today)
  const selectedOption = options.find((option) => option.month === selected)
  const selectedExists = selectedOption != null && selectedOption.status !== 'missing'
  const detail = useCheckinMonth(selectedExists ? selected : undefined)
  const byMonth = new Map((months.data ?? []).map((item) => [item.month, item]))
  const currentItem = byMonth.get(currentMonth)
  const nextItem = byMonth.get(nextMonth)
  const title = <ShopSectionNav links={CHECKIN_SECTION_LINKS} />
  const isPast = selectedOption?.status === 'past'
  const lockedThrough = detail.data ? lockedThroughSlot(detail.data, today) : 0
  const lockHint = isPast
    ? 'Tháng đã qua chỉ xem'
    : `Tính tới hôm nay ${today.format('DD/MM')}, người điểm danh đủ ngày đã có thể nhận tới ô ${lockedThrough}. Ô đã khoá không sửa, không kéo thả được.`
  const draggingData = draggingSlot != null ? detail.data?.slots[draggingSlot - 1] : undefined

  function openCreate(month: string) {
    setSelected(month)
    setCreatingMonth(month)
  }

  function onDragStart(event: DragStartEvent) {
    setDraggingSlot(Number(event.active.id))
  }

  async function onDragEnd(event: DragEndEvent) {
    setDraggingSlot(null)
    if (!detail.data || event.over == null) return
    const from = Number(event.active.id)
    const to = Number(event.over.id)
    if (from === to) return
    try {
      await swapSlots.mutateAsync({ month: detail.data.month, from, to })
      message.success(`Đã đổi chỗ ô ${from} và ô ${to}`)
    } catch (err) {
      message.error(errorMessage(err, 'Đổi chỗ thất bại'))
    }
  }

  async function publish(month: string) {
    try {
      await publishMonth.mutateAsync(month)
      message.success(`Đã phát hành lịch ${monthShortLabel(month)}`)
    } catch (err) {
      message.error(errorMessage(err, 'Phát hành thất bại'))
    }
  }

  async function removeMonth(month: string) {
    try {
      await deleteMonth.mutateAsync(month)
      message.success(`Đã xoá lịch ${monthShortLabel(month)}`)
    } catch (err) {
      message.error(errorMessage(err, 'Xoá lịch thất bại'))
    }
  }

  return (
    <Card title={title}>
      {months.isSuccess && !currentItem ? (
        <Alert
          type="error"
          showIcon
          style={{ marginBottom: 12 }}
          title={`${monthLabel(currentMonth)} chưa có lịch nên điểm danh đang tắt với mọi người.`}
          action={
            <Button size="small" type="primary" onClick={() => openCreate(currentMonth)}>
              Tạo lịch {monthShortLabel(currentMonth)}
            </Button>
          }
        />
      ) : null}
      {months.isSuccess && currentItem && !currentItem.publishedAt ? (
        <Alert
          type="error"
          showIcon
          style={{ marginBottom: 12 }}
          title={`${monthLabel(currentMonth)} còn là nháp nên điểm danh đang tắt với mọi người. Nhập xong các ô rồi bấm Phát hành.`}
        />
      ) : null}
      {months.isSuccess && !nextItem?.publishedAt && today.date() >= CHECKIN_NEXT_MONTH_WARN_DAY ? (
        <Alert
          type="error"
          showIcon
          style={{ marginBottom: 12 }}
          title={`${monthLabel(nextMonth)} ${nextItem ? 'còn là nháp' : 'chưa có lịch'}, từ ${monthStart(nextMonth).format('DD/MM')} điểm danh sẽ tắt với mọi người.`}
          action={
            nextItem ? null : (
              <Button size="small" onClick={() => openCreate(nextMonth)}>
                Tạo lịch {monthShortLabel(nextMonth)}
              </Button>
            )
          }
        />
      ) : null}

      {months.isError ? null : (
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', gap: 12, flexWrap: 'wrap', marginBottom: 12 }}>
          <Segmented<string>
            value={selected}
            onChange={(value) => {
              setSelected(value)
              setEditingSlot(null)
            }}
            options={options.map((option) => ({
              value: option.month,
              label: (
                <Space size={6} style={{ padding: '2px 4px' }}>
                  <span>{monthLabel(option.month)}</span>
                  <Tag color={CHECKIN_MONTH_STATUS_META[option.status].color} style={{ marginInlineEnd: 0 }}>
                    {CHECKIN_MONTH_STATUS_META[option.status].label}
                  </Tag>
                </Space>
              ),
            }))}
          />
          {detail.data && selectedOption ? (
            <Space size={12} wrap>
              <SlotCountEditor key={`${detail.data.month}-${detail.data.slotCount}`} detail={detail.data} status={selectedOption.status} />
              {selectedOption.status === 'draft' ? (
                <Popconfirm
                  title={`Phát hành lịch ${monthShortLabel(detail.data.month)}?`}
                  description={
                    detail.data.month === currentMonth
                      ? 'Điểm danh chạy ngay nếu công tắc đang bật. Từ hôm nay các ô khoá dần theo ngày, không quay lại nháp được.'
                      : `Lịch tự chạy từ ${monthStart(detail.data.month).format('DD/MM')}, trước ngày đó vẫn sửa được mọi ô. Không quay lại nháp được.`
                  }
                  okText="Phát hành"
                  onConfirm={() => publish(detail.data.month)}
                >
                  <Button type="primary" icon={<SendOutlined />} loading={publishMonth.isPending}>
                    Phát hành
                  </Button>
                </Popconfirm>
              ) : null}
              {selectedOption.status === 'upcoming' || selectedOption.status === 'draft' ? (
                <Popconfirm
                  title={`Xoá lịch ${monthShortLabel(detail.data.month)}?`}
                  description={`${selectedOption.status === 'draft' ? 'Lịch nháp chưa chạy' : 'Tháng chưa bắt đầu'} nên chưa ai điểm danh. Xoá xong tháng này sẽ tắt điểm danh cho tới khi tạo lại.`}
                  okText="Xoá"
                  okButtonProps={{ danger: true }}
                  onConfirm={() => removeMonth(detail.data.month)}
                >
                  <Button danger icon={<DeleteOutlined />} loading={deleteMonth.isPending}>
                    Xoá lịch
                  </Button>
                </Popconfirm>
              ) : null}
            </Space>
          ) : null}
        </div>
      )}

      {isPast ? <Typography.Paragraph type="secondary">Tháng đã qua chỉ xem, không sửa được.</Typography.Paragraph> : null}
      {selectedOption?.status === 'draft' && detail.data ? (
        <Alert
          type="warning"
          showIcon
          style={{ marginBottom: 12 }}
          title="Lịch nháp, chưa chạy: sửa và kéo thả được mọi ô. Xong thì bấm Phát hành, các ô chỉ bắt đầu khoá từ ngày phát hành."
        />
      ) : null}
      {selectedOption?.status === 'running' && detail.data && lockedThrough > 0 ? (
        <Alert
          type="info"
          showIcon
          style={{ marginBottom: 12 }}
          title={
            lockedThrough >= detail.data.slotCount
              ? `Cả ${detail.data.slotCount} ô đã khoá: tính tới hôm nay ${today.format('DD/MM')}, người điểm danh đủ ngày đã có thể đi hết lịch. Muốn thêm ô thì tăng Số ô.`
              : `Ô 1–${lockedThrough} đã khoá: tính tới hôm nay ${today.format('DD/MM')}, người điểm danh đủ ngày đã có thể nhận tới ô ${lockedThrough}. Chỉ sửa và kéo thả được ô ${lockedThrough + 1}–${detail.data.slotCount}.`
          }
        />
      ) : null}

      {months.isError || detail.isError ? (
        <CheckinLoadError
          onRetry={() => {
            void months.refetch()
            if (selectedExists) void detail.refetch()
          }}
        />
      ) : months.isLoading || detail.isLoading ? (
        <div style={{ display: 'flex', justifyContent: 'center', padding: 48 }}>
          <Spin />
        </div>
      ) : !selectedExists ? (
        <Empty
          image={Empty.PRESENTED_IMAGE_SIMPLE}
          description={`${monthLabel(selected)} chưa có lịch. Tháng chưa có lịch thì điểm danh tắt trong cả tháng đó.`}
          style={{ padding: '32px 0' }}
        >
          <Button type="primary" icon={<PlusOutlined />} onClick={() => openCreate(selected)}>
            Tạo lịch {monthShortLabel(selected)}
          </Button>
        </Empty>
      ) : detail.data ? (
        <>
          <DndContext
            sensors={sensors}
            onDragStart={onDragStart}
            onDragEnd={onDragEnd}
            onDragCancel={() => setDraggingSlot(null)}
          >
            <div style={{ overflowX: 'auto', padding: 4 }}>
              <div
                style={{
                  display: 'grid',
                  gridTemplateColumns: `repeat(${CHECKIN_GRID_COLUMNS}, minmax(140px, 1fr))`,
                  gap: 8,
                  minWidth: CHECKIN_GRID_COLUMNS * 148,
                }}
              >
                {detail.data.slots.map((slot) => (
                  <CheckinSlotCard
                    key={slot.slot}
                    slot={slot}
                    locked={slot.slot <= lockedThrough}
                    lockHint={lockHint}
                    dragging={draggingSlot != null}
                    busy={swapSlots.isPending}
                    onOpen={setEditingSlot}
                  />
                ))}
              </div>
            </div>
            <DragOverlay>
              {draggingData ? <CheckinSlotCardView slot={draggingData} locked={false} overlay /> : null}
            </DragOverlay>
          </DndContext>
          <Typography.Paragraph type="secondary" style={{ fontSize: 13, marginTop: 12, marginBottom: 0 }}>
            Ô là lần điểm danh thứ mấy trong tháng, người dùng nhận lần lượt từ ô 1, nghỉ ngày nào không mất ô nào. Người dùng chỉ thấy hộp quà,
            mở rồi mới biết bên trong. Ô có quà luôn có nhiệm vụ, hiện sau khi điểm danh.{' '}
            {isPast ? 'Bấm vào ô để xem.' : 'Bấm vào ô để sửa, kéo một ô thả lên ô khác để đổi chỗ hai ô.'}
          </Typography.Paragraph>
        </>
      ) : null}

      {detail.data && editingSlot != null ? (
        <CheckinSlotModal
          detail={detail.data}
          slot={editingSlot}
          readOnly={isPast || editingSlot <= lockedThrough}
          lockHint={isPast ? undefined : lockHint}
          onClose={() => setEditingSlot(null)}
        />
      ) : null}
      {creatingMonth ? (
        <CheckinCreateMonthModal
          month={creatingMonth}
          months={months.data ?? []}
          onClose={() => setCreatingMonth(null)}
          onCreated={(month) => {
            setCreatingMonth(null)
            setSelected(month)
          }}
        />
      ) : null}
    </Card>
  )
}
