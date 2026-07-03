import type { InitOptions } from 'i18next';
import vi from './locales/vi.json';
import en from './locales/en.json';

export const SUPPORTED_LANGUAGES = ['vi', 'en'] as const;
export type Language = (typeof SUPPORTED_LANGUAGES)[number];

export const i18nResources = {
  vi: { translation: vi },
  en: { translation: en },
} as const;

export function createI18nOptions(overrides?: Partial<InitOptions>): InitOptions {
  return {
    resources: i18nResources,
    fallbackLng: 'vi',
    supportedLngs: SUPPORTED_LANGUAGES,
    interpolation: { escapeValue: false },
    ...overrides,
  };
}
