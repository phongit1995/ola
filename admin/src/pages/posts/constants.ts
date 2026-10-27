export const POST_TAB_KEYS = ['me', 'moment'] as const

export type PostTabKey = (typeof POST_TAB_KEYS)[number]

export const DEFAULT_POST_TAB: PostTabKey = 'me'
