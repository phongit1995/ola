import type { InitOptions } from 'i18next';
import {
  i18nResources,
  SUPPORTED_LANGUAGES,
} from './i18n.constants';

export type { Language } from '../types/i18n.type';
export { i18nResources, SUPPORTED_LANGUAGES } from './i18n.constants';

export function createI18nOptions(overrides?: Partial<InitOptions>): InitOptions {
  return {
    resources: i18nResources,
    fallbackLng: 'vi',
    supportedLngs: SUPPORTED_LANGUAGES,
    interpolation: { escapeValue: false },
    ...overrides,
  };
}
