import {
  SettingOutlined,
  StopOutlined,
  TransactionOutlined,
  UnorderedListOutlined,
} from '@ant-design/icons'
import type { ShopSectionLink } from './ShopSectionNav'

export const GIFT_SECTION_LINKS: ShopSectionLink[] = [
  { path: '/gifts', label: 'Danh sách quà', icon: <UnorderedListOutlined /> },
  { path: '/gifts/transactions', label: 'Sổ quà', icon: <TransactionOutlined /> },
  { path: '/gifts/settings', label: 'Cài đặt', icon: <SettingOutlined /> },
]

export const MEGAPHONE_SECTION_LINKS: ShopSectionLink[] = [
  { path: '/megaphones', label: 'Danh sách loa', icon: <UnorderedListOutlined /> },
  { path: '/megaphones/banned-words', label: 'Từ cấm', icon: <StopOutlined /> },
  { path: '/megaphones/settings', label: 'Cài đặt', icon: <SettingOutlined /> },
]
