import { useCallback, useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, RefreshControl, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { createTimeFormatter, formatDateDMY, isSameDay } from '@ola/shared/lib';
import type { Conversation } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { Avatar } from '../../components/Avatar';

function conversationTitle(conversation: Conversation): string {
  return (
    conversation.otherUser?.fullName ??
    conversation.otherUser?.username ??
    conversation.name ??
    ''
  );
}

function ConversationRow({
  conversation,
  onPress,
  timeLabel,
}: {
  conversation: Conversation;
  onPress: () => void;
  timeLabel: string;
}) {
  const title = conversationTitle(conversation);
  const unread = conversation.unreadCount > 0;
  return (
    <Pressable
      className="flex-row items-center gap-3 bg-white px-4 py-3 active:bg-neutral-100"
      onPress={onPress}
    >
      <View>
        <Avatar name={title} uri={conversation.otherUser?.avatar ?? conversation.avatar} />
        {conversation.otherUser?.isOnline === true && (
          <View className="absolute bottom-0 right-0 h-3 w-3 rounded-full border-2 border-white bg-ola-primary" />
        )}
      </View>
      <View className="flex-1">
        <View className="flex-row items-center justify-between">
          <Text className="flex-1 text-base font-semibold text-neutral-900" numberOfLines={1}>
            {title}
          </Text>
          <Text className="ml-2 text-xs text-neutral-400">{timeLabel}</Text>
        </View>
        <View className="flex-row items-center justify-between">
          <Text
            className={`flex-1 text-sm ${unread ? 'font-semibold text-neutral-900' : 'text-neutral-500'}`}
            numberOfLines={1}
          >
            {conversation.lastMessageText ?? ''}
          </Text>
          {unread && (
            <View className="ml-2 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1.5 py-0.5">
              <Text className="text-xs font-semibold text-white">
                {conversation.unreadCount > 99 ? '99+' : conversation.unreadCount}
              </Text>
            </View>
          )}
        </View>
      </View>
    </Pressable>
  );
}

export function ChatListScreen() {
  const { t, i18n } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const conversations = useChatStore((s) => s.conversations);
  const loading = useChatStore((s) => s.loadingConversations);
  const loadConversations = useChatStore((s) => s.loadConversations);

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  const timeLabelOf = useCallback(
    (conversation: Conversation) => {
      const iso = conversation.lastMessageAt ?? conversation.updatedAt;
      if (iso == null || iso === '') return '';
      const now = new Date().toISOString();
      return isSameDay(iso, now) ? createTimeFormatter(i18n.language)(iso) : formatDateDMY(iso);
    },
    [i18n.language]
  );

  return (
    <View className="flex-1 bg-white">
      <View className="h-12 items-center justify-center border-b border-neutral-200 bg-ola-primary">
        <Text className="text-lg font-semibold text-white">{t('home.tabChat')}</Text>
      </View>
      {loading && conversations.length === 0 ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <FlashList
          data={conversations}
          keyExtractor={(item) => item.id}
          refreshControl={
            <RefreshControl refreshing={loading} onRefresh={() => void loadConversations()} />
          }
          ItemSeparatorComponent={() => <View className="ml-[76px] h-px bg-neutral-100" />}
          ListEmptyComponent={
            <View className="mt-24 items-center">
              <Text className="text-sm text-neutral-400">{t('home.contactsEmpty')}</Text>
            </View>
          }
          renderItem={({ item }) => (
            <ConversationRow
              conversation={item}
              timeLabel={timeLabelOf(item)}
              onPress={() => navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: item.id })}
            />
          )}
        />
      )}
    </View>
  );
}
