import type { BotLevel } from '../logic/types';

export interface BotSetupItem {
  id: string;
  vip: number;
  level: BotLevel;
}

export const MAX_BOTS = 3;
export const BOT_VIPS = [1, 2, 3] as const;
export const DEFAULT_BOT_LEVEL: BotLevel = 'normal';

export const BOT_LEVELS: readonly { value: BotLevel; label: string }[] = [
  { value: 'easy', label: 'Dễ' },
  { value: 'normal', label: 'Thường' },
  { value: 'hard', label: 'Khó' },
];

export function botName(index: number): string {
  return `Bot ${index + 1}`;
}

export function botLevelLabel(level: BotLevel): string {
  return BOT_LEVELS.find((item) => item.value === level)?.label ?? BOT_LEVELS[1].label;
}

export function createBot(bots: readonly BotSetupItem[], id: string): BotSetupItem {
  const vip = BOT_VIPS.find((value) => bots.every((bot) => bot.vip !== value)) ?? BOT_VIPS[bots.length % BOT_VIPS.length];
  return { id, vip, level: DEFAULT_BOT_LEVEL };
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
