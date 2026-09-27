import { currentLocale } from './i18n/I18n';

/** Whole numbers grouped the local way: 7.800 in Vietnamese, 7,800 in English. */
export const format = (n: number): string => Math.floor(n).toLocaleString(currentLocale() === 'en' ? 'en-US' : 'vi-VN');
/** Unity's DString.ConvertToMoneyString groups both wallet balances with commas. */
export const formatWallet = (n: number): string => Math.floor(n).toLocaleString('en-US');
