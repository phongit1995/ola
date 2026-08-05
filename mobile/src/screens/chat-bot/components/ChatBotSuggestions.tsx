import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, Text } from 'react-native';
import { DIVIDER } from '@constants';
import type { SuggestionKey } from '../types';

interface ChatBotSuggestionsProps {
  keys: SuggestionKey[];
  onPick: (prompt: string) => void;
}

export function ChatBotSuggestions({ keys, onPick }: ChatBotSuggestionsProps) {
  const { t } = useTranslation();

  return (
    <ScrollView
      horizontal
      showsHorizontalScrollIndicator={false}
      className="shrink-0 grow-0 bg-white"
      style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
      contentContainerStyle={{ gap: 8, paddingHorizontal: 8, paddingVertical: 8 }}
    >
      {keys.map((key) => (
        <Pressable
          key={key}
          onPress={() => onPick(t(key))}
          className="rounded-full px-3 py-1.5 active:opacity-70"
          style={{
            backgroundColor: '#f3f3f3',
            borderWidth: 1,
            borderColor: DIVIDER,
          }}
        >
          <Text className="text-xs text-ola-ink-soft">{t(key)}</Text>
        </Pressable>
      ))}
    </ScrollView>
  );
}
