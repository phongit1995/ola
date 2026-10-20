import { useState } from 'react'
import {
  Alert,
  App,
  Button,
  Card,
  Form,
  Input,
  Radio,
  Space,
  Table,
  Tag,
  Typography,
  type TableColumnsType,
} from 'antd'
import { SendOutlined } from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { errorMessage, toApiError } from '@/lib/apiError'
import { formatCount, formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { CreatePushCampaignRequest, PushAudience, PushCampaign } from '@/types'
import {
  useCreatePushCampaign,
  usePushAudience,
  usePushCampaigns,
} from './usePushCampaignQueries'
import {
  PUSH_AUDIENCE_LABEL,
  PUSH_BODY_MAX,
  PUSH_CAMPAIGN_STATUS_TAG,
  PUSH_TITLE_MAX,
} from './constants'

const HTTP_NOT_FOUND = 404

const AUDIENCE_OPTIONS = (Object.keys(PUSH_AUDIENCE_LABEL) as PushAudience[]).map((value) => ({
  value,
  label: PUSH_AUDIENCE_LABEL[value],
}))

export function PushCampaignPage() {
  const { message, modal } = App.useApp()
  const [form] = Form.useForm<CreatePushCampaignRequest>()
  const [page, setPage] = useState(1)
  const audience = Form.useWatch('audience', form) ?? 'all'
  const rawUsername = Form.useWatch('username', form) ?? ''
  const username = useDebounce(rawUsername.trim())

  const reach = usePushAudience(audience, username)
  const createCampaign = useCreatePushCampaign()
  const { data, isFetching } = usePushCampaigns({
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  function reachText(): string {
    if (audience === 'user' && username === '') return 'Nhập username để xem số thiết bị'
    if (reach.isError) {
      return toApiError(reach.error).status === HTTP_NOT_FOUND
        ? 'Không tìm thấy người dùng này'
        : errorMessage(reach.error, 'Không đếm được người nhận')
    }
    if (reach.data == null) return 'Đang đếm người nhận...'
    return `Sẽ gửi tới ${formatCount(reach.data.users)} người dùng · ${formatCount(reach.data.devices)} thiết bị`
  }

  async function submit() {
    let values: CreatePushCampaignRequest
    try {
      values = await form.validateFields()
    } catch {
      return
    }
    const payload: CreatePushCampaignRequest = {
      audience: values.audience,
      title: values.title.trim(),
      body: values.body.trim(),
      username: values.audience === 'user' ? values.username?.trim() : undefined,
    }
    const target =
      payload.audience === 'user' ? `@${payload.username}` : PUSH_AUDIENCE_LABEL[payload.audience].toLowerCase()
    modal.confirm({
      title: 'Gửi push ngay?',
      content: `Gửi "${payload.title}" tới ${target}. ${reachText()}. Push đã gửi không thu hồi được.`,
      okText: 'Gửi',
      cancelText: 'Huỷ',
      onOk: async () => {
        try {
          await createCampaign.mutateAsync(payload)
          message.success('Đã xếp lịch gửi push, theo dõi tiến độ ở bảng bên dưới')
          form.resetFields(['title', 'body'])
        } catch (err) {
          message.error(errorMessage(err, 'Gửi push thất bại'))
        }
      },
    })
  }

  const columns: TableColumnsType<PushCampaign> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 150,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Nội dung',
      key: 'content',
      render: (_, campaign) => (
        <div style={{ maxWidth: 360 }}>
          <Typography.Text strong>{campaign.title}</Typography.Text>
          <Typography.Paragraph type="secondary" ellipsis={{ rows: 2 }} style={{ marginBottom: 0 }}>
            {campaign.body}
          </Typography.Paragraph>
        </div>
      ),
    },
    {
      title: 'Người nhận',
      key: 'audience',
      width: 180,
      render: (_, campaign) =>
        campaign.audience === 'user' && campaign.targetUser
          ? `@${campaign.targetUser.username}`
          : PUSH_AUDIENCE_LABEL[campaign.audience],
    },
    {
      title: 'Trạng thái',
      dataIndex: 'status',
      width: 120,
      render: (_, campaign) => {
        const meta = PUSH_CAMPAIGN_STATUS_TAG[campaign.status]
        return (
          <Tag color={meta.color} title={campaign.error || undefined}>
            {meta.label}
          </Tag>
        )
      },
    },
    {
      title: 'Thiết bị',
      key: 'devices',
      width: 190,
      render: (_, campaign) => (
        <span>
          {formatCount(campaign.successCount)} thành công
          {campaign.failureCount > 0 && (
            <Typography.Text type="danger"> · {formatCount(campaign.failureCount)} lỗi</Typography.Text>
          )}
          <Typography.Text type="secondary" style={{ display: 'block', fontSize: 12 }}>
            / {formatCount(campaign.totalDevices)} thiết bị
          </Typography.Text>
        </span>
      ),
    },
    {
      title: 'Người gửi',
      key: 'createdBy',
      width: 140,
      render: (_, campaign) => campaign.createdBy?.fullName || campaign.createdBy?.username || '—',
    },
  ]

  return (
    <Space direction="vertical" size={16} style={{ width: '100%' }}>
      <Card title="Soạn push">
        <Alert
          type="info"
          showIcon
          style={{ marginBottom: 16 }}
          message="Push gửi tới điện thoại Android và iOS đã đăng nhập. Cần bật thông báo đẩy ở mục Cài đặt thông báo đẩy."
        />
        <Form
          form={form}
          layout="vertical"
          requiredMark={false}
          initialValues={{ audience: 'all' }}
          style={{ maxWidth: 640 }}
        >
          <Form.Item name="audience" label="Gửi tới">
            <Radio.Group options={AUDIENCE_OPTIONS} optionType="button" />
          </Form.Item>
          {audience === 'user' && (
            <Form.Item
              name="username"
              label="Username"
              rules={[{ required: true, whitespace: true, message: 'Nhập username người nhận' }]}
            >
              <Input placeholder="vd: okela" />
            </Form.Item>
          )}
          <Form.Item
            name="title"
            label="Tiêu đề"
            rules={[{ required: true, whitespace: true, message: 'Nhập tiêu đề' }]}
          >
            <Input maxLength={PUSH_TITLE_MAX} showCount placeholder="vd: Sự kiện cuối tuần" />
          </Form.Item>
          <Form.Item
            name="body"
            label="Nội dung"
            rules={[{ required: true, whitespace: true, message: 'Nhập nội dung' }]}
          >
            <Input.TextArea
              rows={3}
              maxLength={PUSH_BODY_MAX}
              showCount
              placeholder="vd: Nhân đôi KEN khi nạp từ tối nay đến hết Chủ nhật!"
            />
          </Form.Item>
          <Space align="center" wrap>
            <Button
              type="primary"
              icon={<SendOutlined />}
              loading={createCampaign.isPending}
              onClick={() => void submit()}
            >
              Gửi push
            </Button>
            <Typography.Text type={reach.isError ? 'danger' : 'secondary'}>{reachText()}</Typography.Text>
          </Space>
        </Form>
      </Card>
      <Card title="Lịch sử gửi">
        <Table<PushCampaign>
          rowKey="id"
          columns={columns}
          dataSource={data?.items ?? []}
          loading={isFetching && data == null}
          scroll={{ x: 1000 }}
          pagination={{
            current: page,
            pageSize: PAGE_SIZE,
            total: data?.total ?? 0,
            showTotal: (total) => `${total} lần gửi`,
            onChange: setPage,
          }}
        />
      </Card>
    </Space>
  )
}
