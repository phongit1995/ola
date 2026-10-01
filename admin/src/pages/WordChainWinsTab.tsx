import { useState } from 'react'
import { Button, Table, Tag, Typography, type TableColumnsType } from 'antd'
import { ReloadOutlined } from '@ant-design/icons'
import { UserCell } from '@/components/UserCell'
import { useWordChainWins } from '@/hooks/useWordChain'
import { formatDateTime } from '@/lib/format'
import type { WordChainWin } from '@/types'

interface WinnerFilter {
  id: string
  username: string
}

export function WordChainWinsTab() {
  const [winner, setWinner] = useState<WinnerFilter | null>(null)
  const { data, isLoading, isFetching, isFetchingNextPage, hasNextPage, fetchNextPage, refetch } =
    useWordChainWins({ userId: winner?.id })
  const items = data?.pages.flatMap((page) => page.items) ?? []

  const columns: TableColumnsType<WordChainWin> = [
    {
      title: 'Thời gian',
      dataIndex: 'createdAt',
      width: 160,
      render: (value: string) => formatDateTime(value),
    },
    {
      title: 'Người thắng',
      key: 'winner',
      render: (_, win) => (
        <Button
          type="text"
          size="small"
          style={{ height: 'auto', padding: 4 }}
          title="Chỉ xem các trận của người này"
          onClick={() => setWinner({ id: win.userId, username: win.username })}
        >
          <UserCell user={win} />
        </Button>
      ),
    },
    {
      title: 'Từ thắng',
      dataIndex: 'word',
      render: (word: string) => <Typography.Text strong>{word}</Typography.Text>,
    },
    {
      title: 'Nối vào từ',
      dataIndex: 'previousWord',
    },
  ]

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
        {winner ? (
          <Tag closable color="blue" onClose={() => setWinner(null)}>
            Chỉ trận thắng của @{winner.username}
          </Tag>
        ) : (
          <Typography.Text type="secondary">
            Bấm vào người thắng để chỉ xem các trận của người đó.
          </Typography.Text>
        )}
        <Button
          icon={<ReloadOutlined />}
          loading={isFetching && !isFetchingNextPage}
          onClick={() => void refetch()}
        >
          Làm mới
        </Button>
      </div>
      <Table<WordChainWin>
        rowKey="id"
        size="small"
        columns={columns}
        dataSource={items}
        loading={isLoading}
        pagination={false}
        scroll={{ x: 680 }}
        locale={{ emptyText: 'Chưa có trận thắng nào' }}
        footer={() => (
          <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
            <Typography.Text type="secondary">Đang hiển thị {items.length} trận</Typography.Text>
            {hasNextPage && (
              <Button loading={isFetchingNextPage} onClick={() => void fetchNextPage()}>
                Tải thêm
              </Button>
            )}
          </div>
        )}
      />
    </>
  )
}
