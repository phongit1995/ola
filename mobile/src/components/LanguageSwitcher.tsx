import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { SUPPORTED_LANGUAGES, setLanguage, type Language } from '../i18n';

const LABELS: Record<Language, string> = { vi: 'VI', en: 'EN' };

interface LanguageSwitcherProps {
  className?: string;
}

export function LanguageSwitcher({ className = '' }: LanguageSwitcherProps) {
  const { i18n } = useTranslation();
  const current = i18n.resolvedLanguage;

  return (
    <View className={`flex-row items-center gap-1 ${className}`}>
      {SUPPORTED_LANGUAGES.map((lng) => {
        const isActive = current === lng;
        return (
          <Pressable
            key={lng}
            onPress={() => setLanguage(lng)}
            className={`rounded px-2 py-0.5 ${isActive ? 'bg-white/30' : ''}`}
          >
            <Text
              className={`text-xs ${isActive ? 'font-semibold text-white' : 'text-white/70'}`}
            >
              {LABELS[lng]}
            </Text>
          </Pressable>
        );
      })}
    </View>
  );
}
