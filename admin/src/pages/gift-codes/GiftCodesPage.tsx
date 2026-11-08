import { useState } from 'react'
import { Link, useNavigate } from 'react-router-dom'
import {
  App,
  Button,
  Card,
  Col,
  Input,
  Progress,
  Row,
  Select,
  Space,
  Statistic,
  Switch,
  Table,
  Tooltip,
  Typography,
  type TableColumnsType,
} from 'antd'
import { CopyOutlined, PlusOutlined, ReloadOutlined } from '@ant-design/icons'
import { useDebounce } from '@/hooks/useDebounce'
import { errorMessage } from '@/lib/apiError'
import { PAGE_SIZE } from '@/lib/constants'
import { formatCount, formatDateTime } from '@/lib/format'
import type { GiftCodeCampaign, GiftCodeKind, GiftCodeStatus } from '@/types'
import { ShopSectionNav } from '@/pages/shop/ShopSectionNav'
import { GIFT_CODE_SECTION_LINKS } from '@/pages/shop/sections'
import { GIFT_CODE_KIND_OPTIONS, GIFT_CODE_STATUS_OPTIONS } from './constants'
import { GiftCodeKindTag, GiftCodeRewardTags, GiftCodeStatusBadge } from './GiftCodeBadges'
import { useGiftCodeCampaigns, useSetGiftCodeEnabled } from './useGiftCodeQueries'

export function GiftCodesPage() {
  const { message } = App.useApp()
  const navigate = useNavigate()
  const [search, setSearch] = useState('')
  const [status, setStatus] = useState<GiftCodeStatus>()
  const [kind, setKind] = useState<GiftCodeKind>()
  const [page, setPage] = useState(1)
  const debouncedSearch = useDebounce(search.trim())

  const { data, isFetching, refetch } = useGiftCodeCampaigns({
    search: debouncedSearch || undefined,
    status,
    kind,
    limit: PAGE_SIZE,
    offset: (page - 1) * PAGE_SIZE,
  })
  const setEnabled = useSetGiftCodeEnabled()

  function toggle(campaign: GiftCodeCampaign, enabled: boolean) {
    setEnabled.mutate(
      { id: campaign.id, enabled },
      {
        onSuccess: () => message.success(enabled ? 'Đã bật đợt' : 'Đã tắt đợt'),
        onError: (err) => message.error(errorMessage(err, 'Thao tác thất bại')),
      },
    )
  }

  const columns: TableColumnsType<GiftCodeCampaign> = [
    {
      title: 'Tên đợt',
      dataIndex: 'name',
      width: 200,
      render: (name: string, campaign) => <Link to={`/gift-codes/${campaign.id}`}>{name}</Link>,
    },
    {
      title: 'Loại',
      dataIndex: 'kind',
      width: 100,
      render: (value: GiftCodeKind) => <GiftCodeKindTag kind={value} />,
    },
    {
      title: 'Mã',
      key: 'code',
      width: 170,
      render: (_, campaign) =>
        campaign.kind === 'shared' ? (
          <Typography.Text code copyable>
            {campaign.code}
          </Typography.Text>
        ) : (
          <Typography.Text type="secondary">
            {campaign.codePrefix ? `${campaign.codePrefix} · ` : ''}
            {formatCount(campaign.totalUses)} mã
          </Typography.Text>
        ),
    },
    {
      title: 'Quà',
      dataIndex: 'rewards',
      render: (_, campaign) => <GiftCodeRewardTags rewards={campaign.rewards} />,
    },
    {
      title: 'Đã dùng',
      key: 'used',
      width: 160,
      render: (_, campaign) => (
        <div>
          <Progress
            percent={Math.round((campaign.usedCount / Math.max(campaign.totalUses, 1)) * 100)}
            size="small"
            showInfo={false}
            strokeColor={campaign.usedCount >= campaign.totalUses ? '#faad14' : undefined}
          />
          <Typography.Text type="secondary" style={{ fontSize: 12 }}>
            {formatCount(campaign.usedCount)} / {formatCount(campaign.totalUses)} lượt
          </Typography.Text>
        </div>
      ),
    },
    {
      title: 'Thời gian',
      key: 'time',
      width: 190,
      render: (_, campaign) => (
        <div style={{ fontSize: 12, lineHeight: 1.6 }}>
          <div>Từ {campaign.startsAt ? formatDateTime(campaign.startsAt) : 'lúc tạo'}</div>
          <div>Đến {formatDateTime(campaign.endsAt)}</div>
        </div>
      ),
    },
    {
      title: 'Trạng thái',
      dataIndex: 'status',
      width: 130,
      render: (value: GiftCodeStatus) => <GiftCodeStatusBadge status={value} />,
    },
    {
      title: 'Bật',
      dataIndex: 'enabled',
      width: 70,
      render: (enabled: boolean, campaign) => (
        <Switch
          size="small"
          checked={enabled}
          loading={setEnabled.isPending && setEnabled.variables?.id === campaign.id}
          onChange={(next) => toggle(campaign, next)}
        />
      ),
    },
    {
      title: '',
      key: 'actions',
      width: 64,
      fixed: 'right',
      render: (_, campaign) => (
        <Tooltip title="Nhân bản">
          <Button size="small" icon={<CopyOutlined />} onClick={() => navigate(`/gift-codes/new?from=${campaign.id}`)} />
        </Tooltip>
      ),
    },
  ]

  const stats = data?.stats

  return (
    <Card
      title={<ShopSectionNav links={GIFT_CODE_SECTION_LINKS} />}
      extra={
        <Button type="primary" icon={<PlusOutlined />} onClick={() => navigate('/gift-codes/new')}>
          Tạo đợt mới
        </Button>
      }
    >
      <Row gutter={[16, 16]} style={{ marginBottom: 16 }}>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic title="Đợt đang chạy" value={stats?.running ?? 0} />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic title="Lượt nhận hôm nay" value={stats?.redeemedToday ?? 0} groupSeparator="." />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic title="Tổng lượt đã nhận" value={stats?.redeemedTotal ?? 0} groupSeparator="." />
          </Card>
        </Col>
        <Col xs={12} lg={6}>
          <Card size="small">
            <Statistic title="Ngày VIP đã tặng" value={stats?.vipDaysGiven ?? 0} groupSeparator="." suffix="ngày" />
          </Card>
        </Col>
      </Row>
      <Space style={{ marginBottom: 16 }} wrap>
        <Input.Search
          allowClear
          placeholder="Tìm tên đợt hoặc mã"
          style={{ width: 260 }}
          value={search}
          onChange={(e) => {
            setSearch(e.target.value)
            setPage(1)
          }}
        />
        <Select
          allowClear
          placeholder="Mọi trạng thái"
          style={{ width: 160 }}
          value={status}
          options={GIFT_CODE_STATUS_OPTIONS}
          onChange={(value) => {
            setStatus(value)
            setPage(1)
          }}
        />
        <Select
          allowClear
          placeholder="Mọi loại mã"
          style={{ width: 140 }}
          value={kind}
          options={GIFT_CODE_KIND_OPTIONS}
          onChange={(value) => {
            setKind(value)
            setPage(1)
          }}
        />
        <Button icon={<ReloadOutlined />} onClick={() => void refetch()}>
          Tải lại
        </Button>
      </Space>
      <Table<GiftCodeCampaign>
        rowKey="id"
        columns={columns}
        dataSource={data?.items ?? []}
        loading={isFetching && data == null}
        scroll={{ x: 1200 }}
        pagination={{
          current: page,
          pageSize: PAGE_SIZE,
          total: data?.total ?? 0,
          showTotal: (total) => `${total} đợt`,
          onChange: setPage,
        }}
        locale={{ emptyText: 'Chưa có đợt mã nào, bấm "Tạo đợt mới" để bắt đầu' }}
      />
    </Card>
  )
}
