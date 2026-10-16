const DATE_INPUT_STYLE = {
  height: 32,
  border: '1px solid #d9d9d9',
  borderRadius: 6,
  padding: '0 8px',
}

interface DateRangeFilterProps {
  from: string
  to: string
  onFromChange: (value: string) => void
  onToChange: (value: string) => void
}

export function DateRangeFilter({ from, to, onFromChange, onToChange }: DateRangeFilterProps) {
  return (
    <>
      <input
        type="date"
        aria-label="Từ ngày"
        value={from}
        max={to || undefined}
        onChange={(e) => onFromChange(e.target.value)}
        style={DATE_INPUT_STYLE}
      />
      <span style={{ color: '#8c8c8c' }}>→</span>
      <input
        type="date"
        aria-label="Đến ngày"
        value={to}
        min={from || undefined}
        onChange={(e) => onToChange(e.target.value)}
        style={DATE_INPUT_STYLE}
      />
    </>
  )
}
