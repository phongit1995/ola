import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { CHAT_BOT_I18N } from '@ola/shared/constants';
import type { ChatBotType } from '@ola/shared/types';
import { BotAvatar } from './BotAvatar';

export function ChatBotEmptyState({ bot }: { bot: ChatBotType }) {
  const { t } = useTranslation();
  const texts = CHAT_BOT_I18N[bot];

  return (
    <View className="flex-1 items-center justify-center px-8 py-16">
      <BotAvatar bot={bot} size={64} />
      <Text className="mt-3 text-center text-sm text-ola-ink-soft">
        {t(texts.emptyTitle)}
      </Text>
      {texts.emptyHint != null && (
        <Text className="mt-1 text-center text-xs text-ola-ink-faint">
          {t(texts.emptyHint)}
        </Text>
      )}
    </View>
  );
}
