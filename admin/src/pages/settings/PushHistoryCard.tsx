import { useState } from 'react'
import { Card, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { formatCount, formatDateTime } from '@/lib/format'
import { PAGE_SIZE } from '@/lib/constants'
import type { PushCampaign } from '@/types'
import { usePushCampaigns } from './usePushCampaignQueries'
import { PUSH_AUDIENCE_LABEL, PUSH_CAMPAIGN_STATUS_TAG } from './constants'

export function PushHistoryCard() {
  const [page, setPage] = useState(1)
  const { data, isFetching } = usePushCampaigns({
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

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
  )
}
