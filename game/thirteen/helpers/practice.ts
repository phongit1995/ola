import type { BotLevel } from '../logic/bot';

export interface BotSetupItem {
  id: string;
  vipType: string;
  level: BotLevel;
}

export const MAX_BOTS = 3;
export const BOT_NAME_PREFIX = 'Máy ';
export const BOT_VIP_TYPES = ['12', '27', '5'] as const;
export const DEFAULT_BOT_LEVEL: BotLevel = 'normal';

export const BOT_LEVELS: readonly { value: BotLevel; label: string; hint: string }[] = [
  { value: 'easy', label: 'Dễ', hint: 'Đánh bừa' },
  { value: 'normal', label: 'Thường', hint: 'Giữ bài' },
  { value: 'hard', label: 'Khó', hint: 'Nhớ bài' },
];

export function botName(index: number): string {
  return `${BOT_NAME_PREFIX}${index + 1}`;
}

export function isBotName(name: string): boolean {
  return name.startsWith(BOT_NAME_PREFIX);
}

export function botLevelLabel(level: BotLevel): string {
  return BOT_LEVELS.find((item) => item.value === level)?.label ?? BOT_LEVELS[1].label;
}

export function botLevelHint(level: BotLevel): string {
  return BOT_LEVELS.find((item) => item.value === level)?.hint ?? BOT_LEVELS[1].hint;
}

export function createBot(bots: readonly BotSetupItem[], id: string): BotSetupItem {
  const vipType =
    BOT_VIP_TYPES.find((value) => bots.every((bot) => bot.vipType !== value)) ?? BOT_VIP_TYPES[bots.length % BOT_VIP_TYPES.length];
  return { id, vipType, level: DEFAULT_BOT_LEVEL };
}

export function addBot(bots: readonly BotSetupItem[], id: string): BotSetupItem[] {
  if (bots.length >= MAX_BOTS) return [...bots];
  return [...bots, createBot(bots, id)];
}

export function removeBot(bots: readonly BotSetupItem[], id: string): BotSetupItem[] {
  if (bots.length <= 1) return [...bots];
  return bots.filter((bot) => bot.id !== id);
}

export function setBotLevel(bots: readonly BotSetupItem[], id: string, level: BotLevel): BotSetupItem[] {
  return bots.map((bot) => (bot.id === id ? { ...bot, level } : bot));
}
