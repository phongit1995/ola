import { Button, Tooltip } from 'antd'
import { OrderedListOutlined, VerticalAlignTopOutlined } from '@ant-design/icons'

interface RenumberButtonProps {
  disabled: boolean
  onClick: () => void
}

export function RenumberButton({ disabled, onClick }: RenumberButtonProps) {
  return (
    <Button icon={<OrderedListOutlined />} disabled={disabled} onClick={onClick}>
      Đánh số lại
    </Button>
  )
}

interface MoveToTopButtonProps {
  name: string
  disabled: boolean
  onClick: () => void
}

export function MoveToTopButton({ name, disabled, onClick }: MoveToTopButtonProps) {
  return (
    <Tooltip title="Đưa lên đầu">
      <Button
        size="small"
        aria-label={`Đưa ${name} lên đầu`}
        icon={<VerticalAlignTopOutlined />}
        disabled={disabled}
        onClick={onClick}
      />
    </Tooltip>
  )
}
