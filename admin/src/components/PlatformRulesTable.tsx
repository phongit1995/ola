import { Form, Select, Switch, Table, Typography } from 'antd'
import { APP_PLATFORMS, validateDisableVersions } from '@/lib/platformRules'

type PlatformRow = (typeof APP_PLATFORMS)[number]

export function PlatformRulesTable({ name = [] }: { name?: string[] }) {
  const columns = [
    { title: 'Nền tảng', dataIndex: 'label', width: 110 },
    {
      title: 'Hiện',
      key: 'enabled',
      width: 80,
      render: (_: unknown, row: PlatformRow) => (
        <Form.Item name={[...name, row.key, 'enabled']} valuePropName="checked" noStyle>
          <Switch />
        </Form.Item>
      ),
    },
    {
      title: 'Tắt riêng các bản',
      key: 'disableVersions',
      render: (_: unknown, row: PlatformRow) =>
        row.versioned ? (
          <Form.Item
            name={[...name, row.key, 'disableVersions']}
            rules={[{ validator: validateDisableVersions }]}
            style={{ marginBottom: 0 }}
          >
            <Select
              mode="tags"
              tokenSeparators={[',', ' ']}
              open={false}
              suffixIcon={null}
              placeholder="Nhập bản rồi Enter, VD 1.0.1"
            />
          </Form.Item>
        ) : (
          <Typography.Text type="secondary">Không áp dụng</Typography.Text>
        ),
    },
  ]

  return (
    <Table<PlatformRow>
      rowKey="key"
      size="small"
      pagination={false}
      columns={columns}
      dataSource={APP_PLATFORMS}
    />
  )
}
