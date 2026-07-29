import type { Language } from '../types/i18n.type';
import vi from './locales/vi.json';
import en from './locales/en.json';

export const SUPPORTED_LANGUAGES = ['vi', 'en'] as const satisfies readonly Language[];

export const i18nResources = {
  vi: { translation: vi },
  en: { translation: en },
} as const;
