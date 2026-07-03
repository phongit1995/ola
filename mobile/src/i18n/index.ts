import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import { findBestLanguageTag } from 'react-native-localize';
import { createI18nOptions, SUPPORTED_LANGUAGES, type Language } from '@ola/shared/i18n';
import { getKeyValueStorage } from '@ola/shared/platform';

const LANGUAGE_KEY = 'ola.language';

function initialLanguage(): Language {
  const saved = getKeyValueStorage().getItem(LANGUAGE_KEY);
  if (saved != null && (SUPPORTED_LANGUAGES as readonly string[]).includes(saved)) {
    return saved as Language;
  }
  const best = findBestLanguageTag([...SUPPORTED_LANGUAGES]);
  return (best?.languageTag as Language | undefined) ?? 'vi';
}

void i18n.use(initReactI18next).init(createI18nOptions({ lng: initialLanguage() }));

export function setLanguage(language: Language): void {
  getKeyValueStorage().setItem(LANGUAGE_KEY, language);
  void i18n.changeLanguage(language);
}

export { SUPPORTED_LANGUAGES, type Language };

export default i18n;
