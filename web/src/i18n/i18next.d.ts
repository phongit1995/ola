import 'i18next';
import type vi from '@ola/shared/i18n/locales/vi.json';

declare module 'i18next' {
  interface CustomTypeOptions {
    defaultNS: 'translation';
    resources: {
      translation: typeof vi;
    };
  }
}
