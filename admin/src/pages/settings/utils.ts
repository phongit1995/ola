import { APP_PLATFORMS, cleanPlatformRules, normalizePlatformRules } from '@/lib/platformRules'
import type { AppSetting, ChatBotBotSetting, ChatBotPrompt, ChatBotSetting, ChatBotType } from '@/types'
import { CHAT_BOT_SETTING_KEY, CHAT_BOT_TYPES } from './constants'

export function parseServiceAccount(text: string): Record<string, unknown> {
  let parsed: unknown
  try {
    parsed = JSON.parse(text)
  } catch {
    throw new Error('Nội dung không phải JSON hợp lệ')
  }
  if (parsed == null || typeof parsed !== 'object' || Array.isArray(parsed)) {
    throw new Error('Nội dung không phải JSON hợp lệ')
  }
  const value = parsed as Record<string, unknown>
  if (value.type !== 'service_account') {
    throw new Error('File phải là service account JSON (type = service_account)')
  }
  if (!value.project_id || !value.private_key || !value.client_email) {
    throw new Error('Service account JSON thiếu project_id, private_key hoặc client_email')
  }
  return value
}

function storedChatBot(settings: AppSetting[] | undefined): Partial<ChatBotSetting> {
  const found = settings?.find((item) => item.key === CHAT_BOT_SETTING_KEY)
  return (found?.value ?? {}) as Partial<ChatBotSetting>
}

export function chatBotFormValues(
  settings: AppSetting[] | undefined,
  defaults: Record<ChatBotType, ChatBotPrompt>,
): ChatBotSetting {
  const stored = storedChatBot(settings)
  const bots = {} as Record<ChatBotType, ChatBotBotSetting>
  for (const type of CHAT_BOT_TYPES) {
    const bot = stored.bots?.[type]
    bots[type] = {
      enabled: bot?.enabled ?? true,
      platforms: normalizePlatformRules(bot?.platforms),
      systemPrompt: bot?.systemPrompt?.trim() ? bot.systemPrompt : defaults[type].systemPrompt,
      identityReminder: bot?.identityReminder?.trim()
        ? bot.identityReminder
        : defaults[type].identityReminder,
    }
  }
  return { dailyLimit: stored.dailyLimit ?? 0, bots }
}

function overrideOrBlank(value: string, fallback: string): string {
  return value.trim() === fallback.trim() ? '' : value
}

export function chatBotSettingValue(
  values: ChatBotSetting,
  defaults: Record<ChatBotType, ChatBotPrompt>,
): Record<string, unknown> {
  const bots: Record<string, ChatBotBotSetting> = {}
  for (const type of CHAT_BOT_TYPES) {
    const bot = values.bots[type]
    bots[type] = {
      enabled: bot.enabled,
      platforms: cleanPlatformRules(bot.platforms),
      systemPrompt: overrideOrBlank(bot.systemPrompt, defaults[type].systemPrompt),
      identityReminder: overrideOrBlank(bot.identityReminder, defaults[type].identityReminder),
    }
  }
  return { dailyLimit: values.dailyLimit ?? 0, bots }
}

export function disabledChatBots(before: ChatBotSetting, after: ChatBotSetting): ChatBotType[] {
  return CHAT_BOT_TYPES.filter((type) => {
    const was = before.bots[type]
    const now = after.bots[type]
    if (!was.enabled) return false
    if (!now.enabled) return true
    return APP_PLATFORMS.some(({ key }) => was.platforms?.[key]?.enabled !== false && now.platforms?.[key]?.enabled === false)
  })
}
