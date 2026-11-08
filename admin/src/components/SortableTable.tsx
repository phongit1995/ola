import { createContext, useContext, useMemo, type CSSProperties, type HTMLAttributes } from 'react'
import { Button, Table, type TableColumnsType, type TableProps } from 'antd'
import { HolderOutlined } from '@ant-design/icons'
import {
  DndContext,
  PointerSensor,
  closestCenter,
  useSensor,
  useSensors,
  type DragEndEvent,
  type Modifier,
} from '@dnd-kit/core'
import {
  SortableContext,
  arrayMove,
  useSortable,
  verticalListSortingStrategy,
} from '@dnd-kit/sortable'
import { CSS } from '@dnd-kit/utilities'

const DRAG_ACTIVATION_DISTANCE = 5
const DRAG_COLUMN_WIDTH = 48

type SortableBindings = Pick<ReturnType<typeof useSortable>, 'listeners' | 'setActivatorNodeRef'>

const RowDragContext = createContext<SortableBindings | null>(null)

const lockToVerticalAxis: Modifier = ({ transform }) => ({ ...transform, x: 0 })

function RowDragHandle({ disabled }: { disabled: boolean }) {
  const bindings = useContext(RowDragContext)
  return (
    <Button
      ref={bindings?.setActivatorNodeRef}
      type="text"
      size="small"
      disabled={disabled}
      aria-label="Kéo để đổi thứ tự"
      icon={<HolderOutlined />}
      style={{ cursor: disabled ? 'not-allowed' : 'grab', touchAction: 'none' }}
      {...bindings?.listeners}
    />
  )
}

type RowProps = HTMLAttributes<HTMLTableRowElement> & { 'data-row-key': string }

function DraggableRow(props: RowProps) {
  const { attributes, listeners, setNodeRef, setActivatorNodeRef, transform, transition, isDragging } =
    useSortable({ id: props['data-row-key'] })
  const bindings = useMemo(
    () => ({ listeners, setActivatorNodeRef }),
    [listeners, setActivatorNodeRef],
  )
  const style: CSSProperties = {
    ...props.style,
    transform: CSS.Translate.toString(transform),
    transition,
    ...(isDragging ? { position: 'relative', zIndex: 2, background: '#f6ffed' } : {}),
  }
  return (
    <RowDragContext.Provider value={bindings}>
      <tr {...props} {...attributes} ref={setNodeRef} style={style} />
    </RowDragContext.Provider>
  )
}

function SortableRow(props: RowProps) {
  if (props['data-row-key'] == null) return <tr {...props} />
  return <DraggableRow {...props} />
}

const TABLE_COMPONENTS = { body: { row: SortableRow } }

interface SortableTableProps<T extends { id: string }>
  extends Omit<TableProps<T>, 'rowKey' | 'components' | 'dataSource' | 'columns'> {
  items: T[]
  columns: TableColumnsType<T>
  reorderDisabled?: boolean
  onReorder: (ids: string[]) => void
}

export function SortableTable<T extends { id: string }>({
  items,
  columns,
  reorderDisabled = false,
  onReorder,
  ...tableProps
}: SortableTableProps<T>) {
  const sensors = useSensors(
    useSensor(PointerSensor, { activationConstraint: { distance: DRAG_ACTIVATION_DISTANCE } }),
  )
  const ids = useMemo(() => items.map((item) => item.id), [items])

  function handleDragEnd({ active, over }: DragEndEvent) {
    if (over == null || active.id === over.id) return
    const from = ids.indexOf(String(active.id))
    const to = ids.indexOf(String(over.id))
    if (from < 0 || to < 0) return
    onReorder(arrayMove(ids, from, to))
  }

  const allColumns: TableColumnsType<T> = [
    {
      key: 'drag-handle',
      width: DRAG_COLUMN_WIDTH,
      align: 'center',
      render: () => <RowDragHandle disabled={reorderDisabled} />,
    },
    ...columns,
  ]

  return (
    <DndContext
      sensors={sensors}
      collisionDetection={closestCenter}
      modifiers={[lockToVerticalAxis]}
      onDragEnd={handleDragEnd}
    >
      <SortableContext items={ids} strategy={verticalListSortingStrategy}>
        <Table<T>
          {...tableProps}
          rowKey="id"
          columns={allColumns}
          dataSource={items}
          components={TABLE_COMPONENTS as TableProps<T>['components']}
        />
      </SortableContext>
    </DndContext>
  )
}
