import { DollarOutlined, HeartOutlined, TransactionOutlined, UsergroupAddOutlined } from '@ant-design/icons'
import type { ShopSectionLink } from '@/pages/shop/types'

export const USER_RELATION_LINKS: ShopSectionLink[] = [
  { path: '/users/relationships', label: 'Bạn bè & theo dõi', icon: <UsergroupAddOutlined /> },
  { path: '/users/marriages', label: 'Kết hôn', icon: <HeartOutlined /> },
]

export const USER_KEN_LINKS: ShopSectionLink[] = [
  { path: '/users/topups', label: 'Nạp KEN', icon: <DollarOutlined /> },
  { path: '/users/ken-transfers', label: 'Chuyển Ken', icon: <TransactionOutlined /> },
]
