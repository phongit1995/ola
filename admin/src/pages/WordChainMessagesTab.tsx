import { Avatar, Button, Space, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { ReloadOutlined, RobotOutlined } from '@ant-design/icons'
import { UserCell } from '@/components/UserCell'
import { useWordChainMessages } from '@/hooks/useWordChain'
import { formatDateTime } from '@/lib/format'
import type { WordChainMessage } from '@/types'
import { BOT_TYPE_LABEL, CODE_META } from './word-chain/wordChainMeta'

function BotContent({ text }: { text: string }) {
  return (
    <span style={{ whiteSpace: 'pre-line' }}>
      {text.split('**').map((part, index) =>
        index % 2 === 1 ? <strong key={index}>{part}</strong> : part,
      )}
    </span>
  )
}

function Sender({ message }: { message: WordChainMessage }) {
  if (message.senderType === 'bot') {
    return (
      <Space>
        <Avatar size="small" icon={<RobotOutlined />} style={{ background: '#1677ff' }} />
        <span>Trọng tài</span>
      </Space>
    )
  }
  return (
    <UserCell
      user={{
        username: message.senderName || message.senderId || '—',
        avatar: message.senderAvatar,
      }}
    />
  )
}

function Result({ message }: { message: WordChainMessage }) {
  if (message.senderType === 'user' && message.code) {
    const meta = CODE_META[message.code]
    return <Tag color={meta.color}>{meta.label}</Tag>
  }
  return <Tag>{BOT_TYPE_LABEL[message.type]}</Tag>
}

const columns: TableColumnsType<WordChainMessage> = [
  {
    title: 'Thời gian',
    dataIndex: 'createdAt',
    width: 160,
    render: (value: string) => formatDateTime(value),
  },
  {
    title: 'Người gửi',
    key: 'sender',
    width: 200,
    render: (_, message) => <Sender message={message} />,
  },
  {
    title: 'Nội dung',
    key: 'content',
    render: (_, message) =>
      message.senderType === 'bot' ? (
        <Typography.Text type="secondary">
          <BotContent text={message.content} />
        </Typography.Text>
      ) : (
        <Typography.Text strong>{message.content}</Typography.Text>
      ),
  },
  {
    title: 'Kết quả',
    key: 'result',
    width: 190,
    render: (_, message) => <Result message={message} />,
  },
]

export function WordChainMessagesTab() {
  const { data, isLoading, isFetching, isFetchingNextPage, hasNextPage, fetchNextPage, refetch } =
    useWordChainMessages()
  const items = data?.pages.flatMap((page) => page.items) ?? []

  return (
    <>
      <div
        style={{
          marginBottom: 12,
          display: 'flex',
          justifyContent: 'space-between',
          alignItems: 'center',
          gap: 12,
          flexWrap: 'wrap',
        }}
      >
        <Typography.Text type="secondary">
          Tin mới nhất ở trên. Hệ thống giữ 5.000 tin gần nhất của phòng.
        </Typography.Text>
        <Button
          icon={<ReloadOutlined />}
          loading={isFetching && !isFetchingNextPage}
          onClick={() => void refetch()}
        >
          Làm mới
        </Button>
      </div>
      <Table<WordChainMessage>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={items}
        loading={isLoading}
        pagination={false}
        scroll={{ x: 820 }}
        footer={() => (
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <Typography.Text type="secondary">Đang hiển thị {items.length} tin</Typography.Text>
            {hasNextPage && (
              <Button loading={isFetchingNextPage} onClick={() => void fetchNextPage()}>
                Tải thêm tin cũ hơn
              </Button>
            )}
          </div>
        )}
      />
    </>
  )
}
