import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import { BotAvatar } from './BotAvatar';

export function ChatBotEmptyState() {
  const { t } = useTranslation();

  return (
    <View className="flex-1 items-center justify-center px-8 py-16">
      <BotAvatar size={64} />
      <Text className="mt-3 text-center text-sm text-ola-ink-soft">
        {t('chat.chatBotEmptyTitle')}
      </Text>
    </View>
  );
}
