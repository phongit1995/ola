import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import type { ChatBotErrorCode } from '@ola/shared/types';
import { ERROR_KEYS } from '../constants';

interface ChatBotErrorNoticeProps {
  code: ChatBotErrorCode;
  onRetry: () => void;
}

export function ChatBotErrorNotice({ code, onRetry }: ChatBotErrorNoticeProps) {
  const { t } = useTranslation();

  return (
    <View className="mt-2 items-center gap-2">
      <View
        className="rounded-full px-3 py-1"
        style={{ backgroundColor: 'rgba(0,0,0,0.45)' }}
      >
        <Text className="text-[11px] text-white">{t(ERROR_KEYS[code])}</Text>
      </View>
      <Pressable
        onPress={onRetry}
        className="rounded-full bg-white px-4 py-1.5 active:opacity-80"
        style={{
          shadowColor: '#000',
          shadowOpacity: 0.08,
          shadowRadius: 2,
          shadowOffset: { width: 0, height: 1 },
          elevation: 1,
        }}
      >
        <Text className="text-xs font-bold text-ola-primary">
          {t('chat.chatBotRetry')}
        </Text>
      </Pressable>
    </View>
  );
}
