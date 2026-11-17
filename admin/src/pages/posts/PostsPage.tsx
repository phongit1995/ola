import { useState } from 'react'
import { useSearchParams } from 'react-router-dom'
import { Button, Card, Tabs } from 'antd'
import { SettingOutlined } from '@ant-design/icons'
import { MePostsTab } from '../me/MePostsTab'
import { MeSettingsDrawer } from '../me/MeSettingsDrawer'
import { MomentsTab } from '../moments/MomentsTab'
import { MomentSettingsDrawer } from '../moments/MomentSettingsDrawer'
import { DEFAULT_POST_TAB, POST_TAB_KEYS, POST_TAB_SETTINGS_LABEL, type PostTabKey } from './constants'

export function PostsPage() {
  const [searchParams, setSearchParams] = useSearchParams()
  const [settingsTab, setSettingsTab] = useState<PostTabKey | null>(null)
  const tabParam = searchParams.get('tab')
  const activeKey: PostTabKey = POST_TAB_KEYS.includes(tabParam as PostTabKey)
    ? (tabParam as PostTabKey)
    : DEFAULT_POST_TAB

  function changeTab(key: string) {
    setSearchParams(key === DEFAULT_POST_TAB ? {} : { tab: key }, { replace: true })
  }

  function closeSettings() {
    setSettingsTab(null)
  }

  return (
    <Card>
      <Tabs
        activeKey={activeKey}
        onChange={changeTab}
        tabBarExtraContent={
          <Button icon={<SettingOutlined />} onClick={() => setSettingsTab(activeKey)}>
            {POST_TAB_SETTINGS_LABEL[activeKey]}
          </Button>
        }
        items={[
          { key: 'me', label: 'Me', children: <MePostsTab /> },
          { key: 'moment', label: 'Khoảnh khắc', children: <MomentsTab /> },
        ]}
      />
      <MeSettingsDrawer open={settingsTab === 'me'} onClose={closeSettings} />
      <MomentSettingsDrawer open={settingsTab === 'moment'} onClose={closeSettings} />
    </Card>
  )
}
