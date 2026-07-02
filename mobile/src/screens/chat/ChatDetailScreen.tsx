import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Alert,
  KeyboardAvoidingView,
  Modal,
  Platform,
  Pressable,
  Text,
  TextInput,
  View,
} from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { currentUserId } from '@ola/shared/stores/chat/chatHelpers';
import type { Message, ReactionType } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { Avatar } from '../../components/Avatar';
import { MessageBubble } from './MessageBubble';

const REACTIONS: Array<{ type: ReactionType; emoji: string }> = [
  { type: 'LIKE', emoji: '👍' },
  { type: 'LOVE', emoji: '❤️' },
  { type: 'HAHA', emoji: '😆' },
  { type: 'WOW', emoji: '😮' },
  { type: 'SAD', emoji: '😢' },
  { type: 'ANGRY', emoji: '😡' },
];

type Props = NativeStackScreenProps<RootStackParamList, 'ChatDetail'>;

export function ChatDetailScreen({ navigation, route }: Props) {
  const { conversationId } = route.params;
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();

  const conversations = useChatStore((s) => s.conversations);
  const messages = useChatStore((s) => s.messages);
  const loadingMessages = useChatStore((s) => s.loadingMessages);
  const typingUsers = useChatStore((s) => s.typingUsers);
  const openConversation = useChatStore((s) => s.openConversation);
  const closeConversation = useChatStore((s) => s.closeConversation);
  const loadMoreMessages = useChatStore((s) => s.loadMoreMessages);
  const sendText = useChatStore((s) => s.sendText);
  const resendMessage = useChatStore((s) => s.resendMessage);
  const reactToMessage = useChatStore((s) => s.reactToMessage);
  const deleteMessage = useChatStore((s) => s.deleteMessage);
  const notifyTyping = useChatStore((s) => s.notifyTyping);

  const [draft, setDraft] = useState('');
  const [actionTarget, setActionTarget] = useState<Message | null>(null);

  useEffect(() => {
    void openConversation(conversationId);
    return () => closeConversation();
  }, [conversationId, openConversation, closeConversation]);

  const conversation = conversations.find((item) => item.id === conversationId);
  const title =
    conversation?.otherUser?.fullName ??
    conversation?.otherUser?.username ??
    conversation?.name ??
    '';
  const myId = currentUserId();

  const inverted = useMemo(() => [...messages].reverse(), [messages]);

  function handleSend() {
    const content = draft.trim();
    if (content === '') return;
    setDraft('');
    void sendText(content);
  }

  function handleBubblePress(message: Message) {
    if (message.status === 'failed') {
      void resendMessage(message.id);
    }
  }

  function handleDelete(message: Message) {
    setActionTarget(null);
    Alert.alert(t('chat.deleteTitle'), '', [
      { text: t('common.cancel'), style: 'cancel' },
      {
        text: t('common.delete'),
        style: 'destructive',
        onPress: () => void deleteMessage(message.id),
      },
    ]);
  }

  return (
    <KeyboardAvoidingView
      className="flex-1 bg-white"
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
      keyboardVerticalOffset={0}
    >
      <View
        className="flex-row items-center gap-3 border-b border-neutral-200 bg-ola-primary px-2 pb-2"
        style={{ paddingTop: insets.top + 8 }}
      >
        <Pressable className="px-2 py-1" onPress={() => navigation.goBack()}>
          <Text className="text-xl text-white">‹</Text>
        </Pressable>
        <Avatar name={title} uri={conversation?.otherUser?.avatar} size={36} />
        <View className="flex-1">
          <Text className="text-base font-semibold text-white" numberOfLines={1}>
            {title}
          </Text>
          {conversation?.otherUser?.isOnline === true && (
            <Text className="text-xs text-white/80">{t('chat.online')}</Text>
          )}
        </View>
      </View>

      {loadingMessages ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <FlashList
          data={inverted}
          inverted
          keyExtractor={(item) => item.clientMsgId ?? item.id}
          onEndReached={() => void loadMoreMessages()}
          onEndReachedThreshold={0.3}
          renderItem={({ item }) => (
            <MessageBubble
              message={item}
              fromMe={item.senderId === myId}
              onPress={() => handleBubblePress(item)}
              onLongPress={() => setActionTarget(item)}
            />
          )}
        />
      )}

      {typingUsers.length > 0 && (
        <Text className="px-4 pb-1 text-xs italic text-neutral-400">
          {t('chat.typing', { name: typingUsers[0]?.username ?? '' })}
        </Text>
      )}

      <View
        className="flex-row items-end gap-2 border-t border-neutral-200 px-3 py-2"
        style={{ paddingBottom: Math.max(insets.bottom, 8) }}
      >
        <TextInput
          className="max-h-24 flex-1 rounded-2xl bg-neutral-100 px-4 py-2 text-base text-neutral-900"
          placeholder={t('chat.messageInputPlaceholder')}
          placeholderTextColor="#9ca3af"
          multiline
          value={draft}
          onChangeText={(text) => {
            setDraft(text);
            notifyTyping();
          }}
        />
        <Pressable
          className="h-10 items-center justify-center rounded-full bg-ola-primary px-4 active:opacity-80"
          onPress={handleSend}
        >
          <Text className="font-semibold text-white">➤</Text>
        </Pressable>
      </View>

      <Modal
        transparent
        visible={actionTarget != null}
        animationType="fade"
        onRequestClose={() => setActionTarget(null)}
      >
        <Pressable
          className="flex-1 items-center justify-center bg-black/40"
          onPress={() => setActionTarget(null)}
        >
          <View className="w-72 rounded-2xl bg-white p-4">
            <View className="flex-row justify-between">
              {REACTIONS.map((reaction) => (
                <Pressable
                  key={reaction.type}
                  className="h-10 w-10 items-center justify-center rounded-full active:bg-neutral-100"
                  onPress={() => {
                    const target = actionTarget;
                    setActionTarget(null);
                    if (target != null) void reactToMessage(target.id, reaction.type);
                  }}
                >
                  <Text className="text-xl">{reaction.emoji}</Text>
                </Pressable>
              ))}
            </View>
            {actionTarget != null && actionTarget.senderId === myId && (
              <Pressable
                className="mt-3 h-10 items-center justify-center rounded-lg bg-neutral-100 active:bg-neutral-200"
                onPress={() => handleDelete(actionTarget)}
              >
                <Text className="text-sm font-semibold text-ola-error">{t('common.delete')}</Text>
              </Pressable>
            )}
          </View>
        </Pressable>
      </Modal>
    </KeyboardAvoidingView>
  );
}
