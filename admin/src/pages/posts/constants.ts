export const POST_TAB_KEYS = ['me', 'moment'] as const

export type PostTabKey = (typeof POST_TAB_KEYS)[number]

export const DEFAULT_POST_TAB: PostTabKey = 'me'

export const POST_TAB_SETTINGS_LABEL: Record<PostTabKey, string> = {
  me: 'Cài đặt Me',
  moment: 'Cài đặt khoảnh khắc',
}
