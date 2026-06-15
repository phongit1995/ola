import type { ThemeConfig } from 'antd'

export const BRAND = {
  primary: '#5b8c2a',
  primaryDark: '#446b1f',
  primaryHover: '#6fa838',
  accent: '#2563eb',
  surface: '#ffffff',
  bg: '#f4f6f8',
  text: '#1f2733',
  textMuted: '#6b7785',
  border: '#e6e9ef',
} as const

export const FONT_STACK =
  "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif"

export const theme: ThemeConfig = {
  token: {
    colorPrimary: BRAND.primary,
    colorInfo: BRAND.accent,
    colorTextBase: BRAND.text,
    colorBgLayout: BRAND.bg,
    colorBorder: BRAND.border,
    colorBorderSecondary: BRAND.border,
    fontFamily: FONT_STACK,
    fontSize: 14,
    borderRadius: 8,
    controlHeight: 38,
    wireframe: false,
  },
  components: {
    Layout: {
      headerBg: BRAND.surface,
      headerHeight: 60,
      headerPadding: '0 24px',
      siderBg: '#11231a',
      bodyBg: BRAND.bg,
    },
    Menu: {
      darkItemBg: '#11231a',
      darkSubMenuItemBg: '#0d1b14',
      darkItemSelectedBg: BRAND.primary,
      darkItemHoverBg: 'rgba(255,255,255,0.08)',
      itemBorderRadius: 8,
      itemMarginInline: 8,
    },
    Button: {
      controlHeight: 38,
      fontWeight: 500,
      primaryShadow: 'none',
    },
    Card: {
      borderRadiusLG: 14,
      boxShadowTertiary: '0 1px 3px rgba(16,24,40,0.06), 0 1px 2px rgba(16,24,40,0.04)',
    },
    Table: {
      headerBg: '#fafbfc',
      headerColor: BRAND.textMuted,
      rowHoverBg: '#f5f8f2',
      cellPaddingBlock: 14,
    },
    Input: {
      controlHeight: 40,
    },
    Statistic: {
      titleFontSize: 13,
    },
  },
}
