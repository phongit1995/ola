import { useSearchParams } from 'react-router-dom'
import { Tabs } from 'antd'
import { USER_SETTINGS_TAB_KEYS } from './constants'
import { UsernameChangesPage } from '@/pages/username-change/UsernameChangesPage'
import { SocialLimitSettingsTab } from './SocialLimitSettingsTab'

type TabKey = (typeof USER_SETTINGS_TAB_KEYS)[number]

export function UserSettingsPage() {
  const [searchParams, setSearchParams] = useSearchParams()
  const tabParam = searchParams.get('tab')
  const activeKey: TabKey = USER_SETTINGS_TAB_KEYS.includes(tabParam as TabKey)
    ? (tabParam as TabKey)
    : 'social-limit'

  function changeTab(key: string) {
    setSearchParams(key === 'social-limit' ? {} : { tab: key }, { replace: true })
  }

  return (
    <Tabs
      activeKey={activeKey}
      onChange={changeTab}
      destroyOnHidden
      items={[
        { key: 'social-limit', label: 'Giới hạn kết bạn & nhắn tin', children: <SocialLimitSettingsTab /> },
        { key: 'username-changes', label: 'Lịch sử đổi nickname', children: <UsernameChangesPage /> },
      ]}
    />
  )
}
