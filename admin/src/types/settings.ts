import type { ChatBotType } from '@ola/shared/types'
import type { PlatformRules } from './common'

export interface AppSetting {
  key: string
  value: Record<string, unknown>
  updatedAt: string
}

export interface PushFirebaseSettingStatus {
  configured?: boolean
  projectId?: string
  clientEmail?: string
}

export interface PushNotificationSetting {
  enabled?: boolean
}

export interface MailResendSettingStatus {
  configured?: boolean
  keyHint?: string
  from?: string
}

export interface UsernameChangeTierSetting {
  minLength: number
  cost: number
}

export interface UsernameChangeSetting {
  enabled: boolean
  enabledMobile?: boolean
  platforms?: PlatformRules
  tiers: UsernameChangeTierSetting[]
}

export interface ChatBotPrompt {
  systemPrompt: string
  identityReminder: string
}

export interface ChatBotBotSetting extends ChatBotPrompt {
  enabled: boolean
  platforms?: PlatformRules
}

export interface ChatBotSetting {
  dailyLimit: number
  bots: Record<ChatBotType, ChatBotBotSetting>
}

export interface ContentFilterSetting {
  bannedWords: string[]
}
