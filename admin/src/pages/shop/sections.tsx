import {
  CrownOutlined,
  SettingOutlined,
  ShoppingCartOutlined,
  SmileOutlined,
  StopOutlined,
  SwapOutlined,
  TransactionOutlined,
  UnorderedListOutlined,
  WarningOutlined,
} from '@ant-design/icons'
import type { ShopSectionLink } from './ShopSectionNav'

export const VIP_SECTION_LINKS: ShopSectionLink[] = [
  { path: '/vip-packages', label: 'Gói ngày VIP', icon: <CrownOutlined /> },
  { path: '/vip-shop', label: 'Icon VIP', icon: <SmileOutlined /> },
  { path: '/vip-purchases', label: 'Lịch sử mua', icon: <ShoppingCartOutlined /> },
  { path: '/vip-transfers', label: 'Lịch sử chuyển', icon: <SwapOutlined /> },
]

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

export const GIFT_CODE_SECTION_LINKS: ShopSectionLink[] = [
  { path: '/gift-codes', label: 'Đợt mã', icon: <UnorderedListOutlined /> },
  { path: '/gift-codes/attempts', label: 'Nhập lỗi', icon: <WarningOutlined /> },
  { path: '/gift-codes/settings', label: 'Cài đặt', icon: <SettingOutlined /> },
]
