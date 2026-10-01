import { Button, Card, Descriptions, Skeleton, Space, Tag, Typography } from 'antd'
import { ReloadOutlined, RobotOutlined } from '@ant-design/icons'
import { UserCell } from '@/components/UserCell'
import { useAppSettings } from '@/hooks/useAppSettings'
import { useWordChainOverview } from '@/hooks/useWordChain'
import { formatDateTime, formatKen } from '@/lib/format'
import { wordChainSetting } from './wordChainMeta'

export function WordChainOverviewCard() {
  const { data, isLoading, isFetching, refetch } = useWordChainOverview()
  const { data: settings, isLoading: settingsLoading, isError: settingsError } = useAppSettings()
  const setting = settings ? wordChainSetting(settings) : null
  const state = data?.state ?? null
  const settingFallback = settingsLoading ? '…' : settingsError ? 'Không tải được' : '—'

  return (
    <Card
      title="Tổng quan"
      extra={
        <Button icon={<ReloadOutlined />} loading={isFetching} onClick={() => void refetch()}>
          Làm mới
        </Button>
      }
    >
      {isLoading ? (
        <Skeleton active paragraph={{ rows: 4 }} />
      ) : (
        <>
          <Descriptions bordered size="small" column={{ xs: 1, md: 2, xl: 3 }}>
            <Descriptions.Item label="Hiển thị cho người dùng">
              {setting == null ? (
                settingFallback
              ) : setting.enabled ? (
                <Tag color="green">Đang hiển thị</Tag>
              ) : (
                <Tag color="red">Đang ẩn</Tag>
              )}
            </Descriptions.Item>
            <Descriptions.Item label="Giá gợi ý">
              {setting == null ? settingFallback : formatKen(setting.hintPrice)}
            </Descriptions.Item>
            <Descriptions.Item label="Từ hiện tại">
              {state?.word ? (
                <Space size={6}>
                  <Typography.Text strong>{state.word}</Typography.Text>
                  <Typography.Text type="secondary">
                    nối tiếp bằng “{state.requiredSyllable}”
                  </Typography.Text>
                </Space>
              ) : (
                <Typography.Text type="secondary">Chưa có phiên nào</Typography.Text>
              )}
            </Descriptions.Item>
            <Descriptions.Item label="Người đưa ra từ">
              {data?.wordOwner ? (
                <UserCell user={data.wordOwner} />
              ) : state?.wordOwnerId ? (
                <Typography.Text type="secondary">{state.wordOwnerId}</Typography.Text>
              ) : (
                <Space size={6}>
                  <RobotOutlined />
                  <span>Trọng tài</span>
                </Space>
              )}
            </Descriptions.Item>
            <Descriptions.Item label="Ván hiện tại">
              {state ? `${state.historyCount} từ` : '—'}
            </Descriptions.Item>
            <Descriptions.Item label="Từ của trọng tài hết hạn">
              {state?.wordExpiresAt ? formatDateTime(state.wordExpiresAt) : 'Không hết hạn'}
            </Descriptions.Item>
            <Descriptions.Item label="Phiên bắt đầu">
              {formatDateTime(state?.sessionStartedAt)}
            </Descriptions.Item>
            <Descriptions.Item label="Người đã ghi điểm">
              {(data?.players ?? 0).toLocaleString('vi-VN')}
            </Descriptions.Item>
            <Descriptions.Item label="Người đã thắng">
              {(data?.winners ?? 0).toLocaleString('vi-VN')}
            </Descriptions.Item>
          </Descriptions>
          {data && data.history.length > 0 && (
            <div style={{ marginTop: 16 }}>
              <Typography.Text type="secondary">Các từ trong ván hiện tại</Typography.Text>
              <div style={{ display: 'flex', flexWrap: 'wrap', gap: 6, marginTop: 8 }}>
                {data.history.map((word, index) => (
                  <Tag key={word} color={index === data.history.length - 1 ? 'blue' : undefined}>
                    {word}
                  </Tag>
                ))}
              </div>
            </div>
          )}
        </>
      )}
    </Card>
  )
}
