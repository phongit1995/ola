import { useSearchParams } from 'react-router-dom'
import { Card, Space, Tabs } from 'antd'
import { WordChainMessagesTab } from './WordChainMessagesTab'
import { WordChainOverviewCard } from './WordChainOverviewCard'
import { WordChainSettingsTab } from './WordChainSettingsTab'
import { WordChainWinsTab } from './WordChainWinsTab'

const TAB_KEYS = ['history', 'wins', 'settings'] as const
type TabKey = (typeof TAB_KEYS)[number]

export function WordChainPage() {
  const [searchParams, setSearchParams] = useSearchParams()
  const tabParam = searchParams.get('tab')
  const activeKey: TabKey = TAB_KEYS.includes(tabParam as TabKey) ? (tabParam as TabKey) : 'history'

  function changeTab(key: string) {
    setSearchParams(key === 'history' ? {} : { tab: key }, { replace: true })
  }

  return (
    <Space vertical size={16} style={{ width: '100%' }}>
      <WordChainOverviewCard />
      <Card>
        <Tabs
          activeKey={activeKey}
          onChange={changeTab}
          destroyOnHidden
          items={[
            { key: 'history', label: 'Lịch sử nối từ', children: <WordChainMessagesTab /> },
            { key: 'wins', label: 'Trận thắng', children: <WordChainWinsTab /> },
            { key: 'settings', label: 'Cấu hình', children: <WordChainSettingsTab /> },
          ]}
        />
      </Card>
    </Space>
  )
}
