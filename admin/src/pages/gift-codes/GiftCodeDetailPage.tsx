import { Link, useNavigate, useParams, useSearchParams } from 'react-router-dom'
import { Alert, App, Button, Card, Descriptions, Result, Space, Spin, Switch, Tabs, Tag, Typography } from 'antd'
import { ArrowLeftOutlined, CopyOutlined, EditOutlined } from '@ant-design/icons'
import { errorMessage } from '@/lib/apiError'
import { formatCount, formatDateTime } from '@/lib/format'
import type { GiftCodeAdminBrief } from '@/types'
import { GIFT_CODE_PLATFORM_LABEL } from './constants'
import { GiftCodeCodesTab } from './GiftCodeCodesTab'
import { GiftCodeKindTag, GiftCodeRewardTags, GiftCodeStatusBadge } from './GiftCodeBadges'
import { GiftCodeRedemptionsTab } from './GiftCodeRedemptionsTab'
import { useGiftCodeCampaign, useSetGiftCodeEnabled } from './useGiftCodeQueries'

const DETAIL_TABS = ['redemptions', 'codes'] as const
type DetailTab = (typeof DETAIL_TABS)[number]

function AdminStamp({ admin, at }: { admin?: GiftCodeAdminBrief; at: string }) {
  return (
    <span>
      <b>{admin?.username ?? '—'}</b> <Typography.Text type="secondary">· {formatDateTime(at)}</Typography.Text>
    </span>
  )
}

export function GiftCodeDetailPage() {
  const { message } = App.useApp()
  const navigate = useNavigate()
  const { id = '' } = useParams<{ id: string }>()
  const [searchParams, setSearchParams] = useSearchParams()
  const tabParam = searchParams.get('tab')
  const activeTab: DetailTab = DETAIL_TABS.includes(tabParam as DetailTab) ? (tabParam as DetailTab) : 'redemptions'
  const { data: campaign, isLoading, isError } = useGiftCodeCampaign(id)
  const setEnabled = useSetGiftCodeEnabled()

  if (isLoading) {
    return (
      <div style={{ display: 'flex', justifyContent: 'center', padding: 64 }}>
        <Spin />
      </div>
    )
  }
  if (isError || !campaign) {
    return (
      <Result
        status="404"
        title="Không tìm thấy đợt mã"
        extra={<Button onClick={() => navigate('/gift-codes')}>Về danh sách</Button>}
      />
    )
  }

  function toggle(enabled: boolean) {
    setEnabled.mutate(
      { id, enabled },
      {
        onSuccess: () => message.success(enabled ? 'Đã bật đợt' : 'Đã tắt đợt'),
        onError: (err) => message.error(errorMessage(err, 'Thao tác thất bại')),
      },
    )
  }

  const platforms = [
    campaign.allowWeb && 'web',
    campaign.allowAndroid && 'android',
    campaign.allowIos && 'ios',
  ].filter(Boolean) as (keyof typeof GIFT_CODE_PLATFORM_LABEL)[]
  const edited = campaign.updatedAt !== campaign.createdAt

  return (
    <Space orientation="vertical" size={16} style={{ width: '100%' }}>
      <Card
        title={
          <Space wrap>
            <Link to="/gift-codes">
              <ArrowLeftOutlined />
            </Link>
            {campaign.name}
            <GiftCodeKindTag kind={campaign.kind} />
            <GiftCodeStatusBadge status={campaign.status} />
          </Space>
        }
        extra={
          <Space wrap>
            <Button icon={<EditOutlined />} onClick={() => navigate(`/gift-codes/${id}/edit`)}>
              Sửa
            </Button>
            <Button icon={<CopyOutlined />} onClick={() => navigate(`/gift-codes/new?from=${id}`)}>
              Nhân bản
            </Button>
            <Switch
              checkedChildren="Bật"
              unCheckedChildren="Tắt"
              checked={campaign.enabled}
              loading={setEnabled.isPending}
              onChange={toggle}
            />
          </Space>
        }
      >
        <Descriptions column={{ xs: 1, md: 2, xl: 3 }} size="small">
          <Descriptions.Item label="Quà">
            <GiftCodeRewardTags rewards={campaign.rewards} />
          </Descriptions.Item>
          <Descriptions.Item label="Thời gian">
            {campaign.startsAt ? formatDateTime(campaign.startsAt) : 'Từ lúc tạo'} → {formatDateTime(campaign.endsAt)}
          </Descriptions.Item>
          <Descriptions.Item label="Đã dùng">
            <b>{formatCount(campaign.usedCount)}</b>&nbsp;/ {formatCount(campaign.totalUses)}{' '}
            {campaign.kind === 'unique' ? 'mã' : 'lượt'}
            {campaign.lockedCodes > 0 && ` · ${formatCount(campaign.lockedCodes)} mã đã khoá`}
          </Descriptions.Item>
          <Descriptions.Item label={campaign.kind === 'shared' ? 'Mã' : 'Dạng mã'}>
            {campaign.kind === 'shared' ? (
              <Typography.Text code copyable>
                {campaign.code}
              </Typography.Text>
            ) : (
              <span>
                {campaign.codePrefix && <Typography.Text code>{campaign.codePrefix}</Typography.Text>} + {campaign.codeLength} ký tự
              </span>
            )}
          </Descriptions.Item>
          <Descriptions.Item label="Tuổi tài khoản">
            {campaign.minAccountAgeDays > 0 ? `Từ ${campaign.minAccountAgeDays} ngày` : 'Không giới hạn'}
          </Descriptions.Item>
          <Descriptions.Item label="Nền tảng">
            <Space size={4}>
              {platforms.map((p) => (
                <Tag key={p} style={{ marginInlineEnd: 0 }}>
                  {GIFT_CODE_PLATFORM_LABEL[p]}
                </Tag>
              ))}
            </Space>
          </Descriptions.Item>
          <Descriptions.Item label="Mỗi thiết bị 1 lần">
            {campaign.onePerDevice ? <Tag color="green">Bật</Tag> : <Tag>Tắt</Tag>}
          </Descriptions.Item>
          <Descriptions.Item label="Thông báo hệ thống">
            {campaign.sendNotification ? <Tag color="green">Có gửi</Tag> : <Tag>Không gửi</Tag>}
          </Descriptions.Item>
          <Descriptions.Item label="Lời nhắn">{campaign.successMessage || 'Câu mặc định'}</Descriptions.Item>
          <Descriptions.Item label="Người tạo">
            <AdminStamp admin={campaign.createdBy} at={campaign.createdAt} />
          </Descriptions.Item>
          {edited && (
            <Descriptions.Item label="Sửa lần cuối">
              <AdminStamp admin={campaign.updatedBy} at={campaign.updatedAt} />{' '}
              <Link to="/audit-logs" style={{ marginLeft: 6 }}>
                Xem nhật ký admin
              </Link>
            </Descriptions.Item>
          )}
        </Descriptions>
        {campaign.usedCount > 0 && (
          <Alert
            type="warning"
            showIcon
            style={{ marginTop: 12 }}
            title="Đã có người nhận nên không sửa được loại mã, dạng mã và quà. Vẫn sửa được tên, lời nhắn, thời gian, điều kiện, sinh thêm mã, khoá từng mã hoặc tắt đợt."
          />
        )}
      </Card>
      <Card>
        <Tabs
          activeKey={activeTab}
          onChange={(key) => setSearchParams(key === 'redemptions' ? {} : { tab: key }, { replace: true })}
          destroyOnHidden
          items={[
            {
              key: 'redemptions',
              label: `Người đã nhận (${formatCount(campaign.usedCount)})`,
              children: <GiftCodeRedemptionsTab campaign={campaign} />,
            },
            {
              key: 'codes',
              label: campaign.kind === 'unique' ? `Danh sách mã (${formatCount(campaign.totalUses)})` : 'Mã',
              children: <GiftCodeCodesTab campaign={campaign} />,
            },
          ]}
        />
      </Card>
    </Space>
  )
}
