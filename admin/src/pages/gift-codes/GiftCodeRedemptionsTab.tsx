import { useState } from 'react'
import { App, Button, Input, Select, Space, Table, Typography, type TableColumnsType } from 'antd'
import { DownloadOutlined } from '@ant-design/icons'
import { UserBriefCell } from '@/components/UserBriefCell'
import { useDebounce } from '@/hooks/useDebounce'
import { errorMessage } from '@/lib/apiError'
import { PAGE_SIZE } from '@/lib/constants'
import { formatDateTime } from '@/lib/format'
import type { GiftCodeCampaign, GiftCodePlatform, GiftCodeRedemption } from '@/types'
import { GIFT_CODE_PLATFORM_LABEL, GIFT_CODE_PLATFORM_OPTIONS } from './constants'
import { GiftCodeRewardTags } from './GiftCodeBadges'
import { useExportGiftCodeRedemptions, useGiftCodeRedemptions } from './useGiftCodeQueries'
import { csvFileName, downloadCsv, rewardsText } from './utils'

export function GiftCodeRedemptionsTab({ campaign }: { campaign: GiftCodeCampaign }) {
  const { message } = App.useApp()
  const [search, setSearch] = useState('')
  const [platform, setPlatform] = useState<GiftCodePlatform>()
  const [page, setPage] = useState(1)
  const exportRedemptions = useExportGiftCodeRedemptions()
  const debouncedSearch = useDebounce(search.trim())
  const params = { search: debouncedSearch || undefined, platform }
  const { data, isFetching } = useGiftCodeRedemptions(campaign.id, {
    ...params,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })

  async function exportCsv() {
    try {
      const all = await exportRedemptions.mutateAsync({ id: campaign.id, params })
      downloadCsv(
        csvFileName(campaign.name, 'nguoi-nhan'),
        ['Thời gian', 'Nickname', 'Tên', 'Mã', 'Nền tảng', 'Thiết bị', 'IP', 'Quà'],
        all.items.map((r) => [
          formatDateTime(r.createdAt),
          r.user.username,
          r.user.fullName,
          r.code,
          GIFT_CODE_PLATFORM_LABEL[r.platform] ?? r.platform,
          r.deviceName,
          r.ipAddress,
          rewardsText(r.rewards, true),
        ]),
      )
    } catch (err) {
      message.error(errorMessage(err, 'Xuất CSV thất bại'))
    }
  }

  const columns: TableColumnsType<GiftCodeRedemption> = [
    { title: 'Thời gian', dataIndex: 'createdAt', width: 160, render: (value: string) => formatDateTime(value) },
    { title: 'Người dùng', dataIndex: 'user', render: (_, r) => <UserBriefCell user={r.user} /> },
    { title: 'Mã', dataIndex: 'code', render: (value: string) => <Typography.Text code>{value}</Typography.Text> },
    {
      title: 'Nền tảng',
      dataIndex: 'platform',
      width: 100,
      render: (value: GiftCodePlatform) => GIFT_CODE_PLATFORM_LABEL[value] ?? value,
    },
    { title: 'Thiết bị', dataIndex: 'deviceName', width: 160, render: (value: string) => value || '—' },
    { title: 'Quà đã nhận', dataIndex: 'rewards', render: (_, r) => <GiftCodeRewardTags rewards={r.rewards} /> },
  ]

  return (
    <>
      <Space style={{ marginBottom: 16 }} wrap>
        <Input.Search
          allowClear
          placeholder="Tìm nickname, tên hoặc mã"
          style={{ width: 260 }}
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
        <Select
          allowClear
          placeholder="Mọi nền tảng"
          style={{ width: 150 }}
          value={platform}
          options={GIFT_CODE_PLATFORM_OPTIONS}
          onChange={(value) => {
            setPlatform(value)
            setPage(1)
          }}
        />
        <Button icon={<DownloadOutlined />} loading={exportRedemptions.isPending} disabled={(data?.total ?? 0) === 0} onClick={() => void exportCsv()}>
          Xuất CSV
        </Button>
      </Space>
      <Table<GiftCodeRedemption>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching && data == null}
        scroll={{ x: 1000 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} người đã nhận`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có ai nhận' }}
      />
    </>
  )
}
