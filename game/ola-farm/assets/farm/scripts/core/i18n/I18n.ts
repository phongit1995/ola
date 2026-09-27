import { STRINGS_VI } from './Strings.vi.constants';
import { STRINGS_EN } from './Strings.en.constants';
import type { Locale, StringKey, StringParams } from './I18n.types';

const TABLES: Readonly<Record<Locale, Readonly<Record<StringKey, string>>>> = { vi: STRINGS_VI, en: STRINGS_EN };
let current: Locale = 'vi';

/** `vi` or `en` from a language tag such as `en-US`; null for anything else. */
export function parseLocale(value: unknown): Locale | null {
  const tag = typeof value === 'string' ? value.trim().toLowerCase().slice(0, 2) : '';
  return tag === 'vi' || tag === 'en' ? tag : null;
}

/** Chosen once at start-up, before the loading screen draws, from `?lang=` on the game URL. */
export function setLocale(locale: Locale): void {
  current = locale;
}

export function currentLocale(): Locale {
  return current;
}

/** The sentence for `key` in the current language, with `{name}` placeholders filled from `params`. */
export function t(key: StringKey, params?: StringParams): string {
  const template = TABLES[current][key] ?? STRINGS_VI[key];
  return params
    ? template.replace(/\{(\w+)\}/g, (match, name: string) => (name in params ? String(params[name]) : match))
    : template;
}
