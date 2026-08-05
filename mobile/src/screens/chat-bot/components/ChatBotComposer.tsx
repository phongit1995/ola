import { useTranslation } from 'react-i18next';
import type { RefObject } from 'react';
import { Image, Pressable, View } from 'react-native';
import { ChatComposer, type ChatComposerHandle } from '@components/ChatComposer';
import { CHAT_MAX_FONT_SIZE_MULTIPLIER, DIVIDER } from '@constants';

const sendIcon = require('@assets/icons/chat/ic_action_send_white.png');

interface ChatBotComposerProps {
  inputRef: RefObject<ChatComposerHandle | null>;
  value: string;
  onChange: (value: string) => void;
  streaming: boolean;
  onSend: () => void;
  onStop: () => void;
}

export function ChatBotComposer({
  inputRef,
  value,
  onChange,
  streaming,
  onSend,
  onStop,
}: ChatBotComposerProps) {
  const { t } = useTranslation();
  const disabled = !streaming && value.trim() === '';

  return (
    <View
      className="flex-row items-end gap-1 bg-white px-2 py-1.5"
      style={{ borderTopWidth: 1, borderTopColor: DIVIDER }}
    >
      <View className="flex-1">
        <ChatComposer
          ref={inputRef}
          value={value}
          onChange={onChange}
          placeholder={t('chat.chatBotPlaceholder')}
          maxFontSizeMultiplier={CHAT_MAX_FONT_SIZE_MULTIPLIER}
          minHeight={36}
          maxHeight={128}
          paddingH={8}
          paddingV={6}
        />
      </View>
      <Pressable
        onPress={streaming ? onStop : onSend}
        disabled={disabled}
        accessibilityLabel={streaming ? t('chat.chatBotStop') : t('chat.send')}
        className="h-9 w-9 items-center justify-center rounded-full bg-ola-primary"
        style={{ opacity: disabled ? 0.4 : 1 }}
      >
        {streaming ? (
          <View style={{ width: 14, height: 14, borderRadius: 2, backgroundColor: '#fff' }} />
        ) : (
          <Image
            source={sendIcon}
            style={{ width: 20, height: 20, tintColor: '#fff' }}
            resizeMode="contain"
          />
        )}
      </Pressable>
    </View>
  );
}
