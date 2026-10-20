import { create } from 'zustand';
import { CHAT_BOT_TYPE } from '../../constants/chatBot';
import { SettingsService } from '../../services/settings.service';
import type { ChatBotConfigState } from '../../types/client/chatBot.type';

export const useChatBotConfigStore = create<ChatBotConfigState>((set) => ({
  enabledBots: Object.values(CHAT_BOT_TYPE),
  dailyLimit: 0,

  load: async () => {
    const config = await SettingsService.chatBotConfig().catch(() => null);
    if (config == null) return;
    set({
      enabledBots: config.bots.filter((bot) => bot.enabled).map((bot) => bot.type),
      dailyLimit: config.dailyLimit,
    });
  },
}));
