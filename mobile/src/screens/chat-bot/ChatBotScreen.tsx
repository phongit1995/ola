import { useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, View } from 'react-native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { CHAT_BOT_DEFAULT_TYPE, CHAT_BOT_I18N } from '@ola/shared/constants';
import { colorForName } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { ChatKeyboardArea } from '@components/ChatKeyboardArea';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import type { ChatStackParamList } from '@navigation/types';
import { CHAT_ROUTES } from '@navigation/routes';
import { CHAT_BG } from '@screens/chat/constants';
import { useChatBotConversation } from './useChatBotConversation';
import { BotAvatar } from './components/BotAvatar';
import { ChatBotComposer } from './components/ChatBotComposer';
import { ChatBotMessageList } from './components/ChatBotMessageList';
import { ChatBotSuggestions } from './components/ChatBotSuggestions';

const deleteIcon = require('@assets/icons/chat/ic_menu_delete.png');

type Props = NativeStackScreenProps<ChatStackParamList, typeof CHAT_ROUTES.ChatBot>;

export function ChatBotScreen({ navigation, route }: Props) {
  const { t } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const [clearOpen, setClearOpen] = useState(false);
  const bot = route.params?.bot ?? CHAT_BOT_DEFAULT_TYPE;
  const conversation = useChatBotConversation(bot);

  const texts = CHAT_BOT_I18N[bot];
  const botName = t(texts.title);
  const meName = me?.username ?? '';
  const meAvatar = me?.avatar;
  const showSuggestions =
    conversation.visible.length === 0 && !conversation.waiting;

  const viewer = useMemo(
    () => ({ name: meName, color: colorForName(meName), avatar: meAvatar }),
    [meName, meAvatar]
  );

  return (
    <View className="flex-1" style={{ backgroundColor: CHAT_BG }}>
      <ScreenHeader
        title={botName}
        subtitle={
          conversation.streaming ? t(texts.thinking) : undefined
        }
        onBack={() => navigation.goBack()}
        left={
          <View className="pr-1">
            <BotAvatar bot={bot} />
          </View>
        }
        right={
          <Pressable
            accessibilityLabel={t('chat.chatBotClear')}
            onPress={() => setClearOpen(true)}
            disabled={conversation.messages.length === 0}
            className="h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            style={{ opacity: conversation.messages.length === 0 ? 0.4 : 1 }}
          >
            <Image
              source={deleteIcon}
              style={{ width: 20, height: 20, tintColor: '#fff' }}
              resizeMode="contain"
            />
          </Pressable>
        }
      />

      <ChatKeyboardArea>
        <ChatBotMessageList
          list={conversation.list}
          messages={conversation.visible}
          bot={bot}
          viewer={viewer}
          waiting={conversation.waiting}
          error={conversation.error}
          onRetry={conversation.retry}
        />

        {showSuggestions && (
          <ChatBotSuggestions
            keys={conversation.suggestions}
            onPick={conversation.ask}
          />
        )}

        <ChatBotComposer
          inputRef={conversation.composerRef}
          value={conversation.draft}
          onChange={conversation.setDraft}
          placeholder={t(texts.placeholder)}
          streaming={conversation.streaming}
          onSend={conversation.send}
          onStop={conversation.stop}
        />
      </ChatKeyboardArea>

      <ConfirmDialog
        visible={clearOpen}
        danger
        title={t('chat.chatBotClear')}
        message={t(texts.clearConfirm)}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          setClearOpen(false);
          conversation.clearHistory();
        }}
        onCancel={() => setClearOpen(false)}
      />
    </View>
  );
}
