import { create } from 'zustand';
import { CHAT_BOT_TYPE } from '../../constants/chatBot';
import type { ChatBotConfigState } from '../../types/client/chatBot.type';
import { loadAppConfig } from '../appConfigStore';

export const useChatBotConfigStore = create<ChatBotConfigState>((set) => ({
  enabledBots: Object.values(CHAT_BOT_TYPE),
  dailyLimit: 0,

  load: async () => {
    const config = await loadAppConfig('chatBot');
    if (config == null) return;
    set({
      enabledBots: config.bots.filter((bot) => bot.enabled).map((bot) => bot.type),
      dailyLimit: config.dailyLimit,
    });
  },
}));
