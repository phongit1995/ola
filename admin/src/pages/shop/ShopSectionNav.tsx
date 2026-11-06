import type { ReactNode } from 'react'
import { Segmented } from 'antd'
import { useLocation, useNavigate } from 'react-router-dom'

export interface ShopSectionLink {
  path: string
  label: string
  icon: ReactNode
}

export function ShopSectionNav({ links }: { links: ShopSectionLink[] }) {
  const navigate = useNavigate()
  const { pathname } = useLocation()

  return (
    <Segmented<string>
      value={pathname}
      options={links.map((link) => ({
        value: link.path,
        label: link.label,
        icon: link.icon,
      }))}
      onChange={(path) => navigate(path)}
    />
  )
}
