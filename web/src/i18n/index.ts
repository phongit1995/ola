import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';
import { createI18nOptions } from '@ola/shared/i18n';

export { SUPPORTED_LANGUAGES, type Language } from '@ola/shared/i18n';

void i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init(
    createI18nOptions({
      detection: {
        order: ['querystring', 'localStorage'],
        caches: ['localStorage'],
      },
    })
  );

export default i18n;
