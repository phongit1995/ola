import { useSearchParams } from 'react-router-dom'
import { Card, Tabs } from 'antd'
import { MePostsTab } from '../me/MePostsTab'
import { MomentsTab } from '../moments/MomentsTab'
import { DEFAULT_POST_TAB, POST_TAB_KEYS, type PostTabKey } from './constants'

export function PostsPage() {
  const [searchParams, setSearchParams] = useSearchParams()
  const tabParam = searchParams.get('tab')
  const activeKey: PostTabKey = POST_TAB_KEYS.includes(tabParam as PostTabKey)
    ? (tabParam as PostTabKey)
    : DEFAULT_POST_TAB

  function changeTab(key: string) {
    setSearchParams(key === DEFAULT_POST_TAB ? {} : { tab: key }, { replace: true })
  }

  return (
    <Card>
      <Tabs
        activeKey={activeKey}
        onChange={changeTab}
        items={[
          { key: 'me', label: 'Me', children: <MePostsTab /> },
          { key: 'moment', label: 'Khoảnh khắc', children: <MomentsTab /> },
        ]}
      />
    </Card>
  )
}
