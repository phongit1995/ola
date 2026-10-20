import { useQuery } from '@tanstack/react-query'
import { AdminSettingsService } from '@/services/adminSettings.service'

const CHAT_BOT_DEFAULTS_KEY = 'admin-chat-bot-defaults'

export function useChatBotDefaults() {
  return useQuery({
    queryKey: [CHAT_BOT_DEFAULTS_KEY],
    queryFn: () => AdminSettingsService.chatBotDefaults(),
    staleTime: Infinity,
  })
}
