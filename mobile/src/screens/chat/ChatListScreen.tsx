import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Alert,
  Animated,
  Image,
  PanResponder,
  Pressable,
  RefreshControl,
  Text,
  View,
} from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import type { Conversation } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { Avatar } from '../../components/Avatar';
import { kulImageForText } from '../../lib/kul';
import { renderRichText } from '../../lib/richText';
import { ContactsPane } from './ContactsPane';

const sentIcon = require('../../assets/icons/chat/ic_message_sent.png');
const kulIcon = require('../../assets/icons/chat/ic_kul.png');
const moreIcon = require('../../assets/icons/chat/ic_more_white.png');

const SWIPE_MAX = 88;
const SWIPE_TRIGGER = 56;
const DIVIDER = 'rgba(0,0,0,0.12)';

function formatClock(iso?: string): string {
  if (iso == null || iso === '') return '';
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return `${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;
}

function displayName(conversation: Conversation): string {
  return (
    conversation.otherUser?.fullName ||
    conversation.otherUser?.username ||
    conversation.name ||
    ''
  );
}

function headerTitle(conversation: Conversation): string {
  const username = conversation.otherUser?.username ?? '';
  const fullName = conversation.otherUser?.fullName ?? '';
  if (username !== '' && fullName !== '') return `${username} · ${fullName}`;
  return displayName(conversation);
}

interface RowProps {
  conversation: Conversation;
  onPress: () => void;
  onDelete: () => void;
}

function ConversationRow({ conversation, onPress, onDelete }: RowProps) {
  const { t } = useTranslation();
  const translateX = useRef(new Animated.Value(0)).current;

  const title = headerTitle(conversation);
  const name = displayName(conversation);
  const unread = conversation.unreadCount > 0;
  const lastText = conversation.lastMessageText ?? '';
  const isSticker = kulImageForText(lastText) != null;
  const hasPreview = lastText !== '' || isSticker;
  const fromMe = conversation.isLastMessageFromMe;
  const isGroup = conversation.type === 'group';
  const online =
    conversation.type === 'direct' ? (conversation.otherUser?.isOnline ?? false) : false;
  const avatarUri = conversation.otherUser?.avatar ?? conversation.avatar;

  const prefix = !hasPreview
    ? ''
    : fromMe
      ? `${t('chat.youPrefix')}: `
      : isGroup && conversation.lastMessageSenderName
        ? `${conversation.lastMessageSenderName}: `
        : '';

  const panResponder = useRef(
    PanResponder.create({
      onMoveShouldSetPanResponder: (_e, g) => Math.abs(g.dx) > 8 && Math.abs(g.dx) > Math.abs(g.dy),
      onPanResponderMove: (_e, g) => {
        translateX.setValue(Math.min(0, Math.max(g.dx, -SWIPE_MAX)));
      },
      onPanResponderRelease: (_e, g) => {
        if (g.dx <= -SWIPE_TRIGGER) {
          Animated.timing(translateX, { toValue: 0, duration: 150, useNativeDriver: true }).start();
          Alert.alert(
            t('dialog.deleteConvTitle'),
            t('dialog.deleteConvMessage', { name }),
            [
              { text: t('dialog.cancel'), style: 'cancel' },
              { text: t('dialog.delete'), style: 'destructive', onPress: onDelete },
            ]
          );
        } else {
          Animated.spring(translateX, { toValue: 0, useNativeDriver: true }).start();
        }
      },
    })
  ).current;

  return (
    <View className="relative overflow-hidden">
      <View className="absolute inset-y-0 right-0 w-[88px] items-center justify-center" style={{ backgroundColor: '#dd4b39' }}>
        <Text className="text-sm font-medium text-white">{t('dialog.delete')}</Text>
      </View>
      <Animated.View style={{ transform: [{ translateX }] }} {...panResponder.panHandlers}>
        <Pressable
          onPress={onPress}
          className="flex-row items-center gap-4 px-4"
          style={{ minHeight: 72, backgroundColor: unread ? '#f1f8e9' : '#ffffff' }}
        >
          <View className="shrink-0">
            <Avatar name={name} uri={avatarUri} />
            {online && (
              <View className="absolute bottom-0 right-0 h-3 w-3 rounded-full bg-ola-primary" style={{ borderWidth: 2, borderColor: '#fff' }} />
            )}
          </View>
          <View className="min-w-0 flex-1">
            <View className="flex-row items-center justify-between gap-2">
              <Text
                className={`flex-1 text-base ${unread ? 'font-bold' : ''}`}
                style={{ color: 'rgba(0,0,0,0.87)' }}
                numberOfLines={1}
              >
                {title}
              </Text>
              <Text
                className={`text-xs ${unread ? 'font-bold' : ''}`}
                style={{ color: unread ? 'rgba(0,0,0,0.87)' : 'rgba(0,0,0,0.54)' }}
              >
                {formatClock(conversation.lastMessageAt)}
              </Text>
            </View>
            <View className="mt-0.5 flex-row items-center gap-1">
              <View className="min-w-0 flex-1 flex-row items-center">
                {prefix !== '' && (
                  <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }} numberOfLines={1}>
                    {prefix}
                  </Text>
                )}
                {isSticker ? (
                  <View className="flex-row items-center gap-1">
                    <Image source={kulIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
                    <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.87)' }}>
                      {t('chat.stickerPreview')}
                    </Text>
                  </View>
                ) : (
                  <Text className="flex-1 text-sm" style={{ color: 'rgba(0,0,0,0.87)' }} numberOfLines={1}>
                    {renderRichText(lastText, { own: false, onMention: () => undefined })}
                  </Text>
                )}
              </View>
              {fromMe &&
                hasPreview &&
                (conversation.seen ? (
                  <Avatar name={name} uri={avatarUri} size={16} />
                ) : (
                  <Image source={sentIcon} style={{ width: 14, height: 14, opacity: 0.6 }} resizeMode="contain" />
                ))}
            </View>
          </View>
          {unread && (
            <View
              className="h-5 min-w-5 shrink-0 items-center justify-center rounded-full bg-ola-accent px-1.5"
              style={{ borderWidth: 2, borderColor: '#fff' }}
            >
              <Text className="text-xs font-bold text-white">
                {conversation.unreadCount > 99 ? '99+' : conversation.unreadCount}
              </Text>
            </View>
          )}
        </Pressable>
      </Animated.View>
    </View>
  );
}

type ChatSub = 'messages' | 'contacts';

function HeaderTab({
  label,
  active,
  badge = 0,
  onPress,
}: {
  label: string;
  active: boolean;
  badge?: number;
  onPress: () => void;
}) {
  return (
    <Pressable onPress={onPress} className="h-full flex-1 items-center justify-center">
      <View className="relative flex-row items-center">
        <Text
          className={`text-base font-medium ${active ? 'text-white' : 'text-white/70'}`}
        >
          {label}
        </Text>
        {badge > 0 && (
          <View
            className="absolute -right-5 -top-1 h-4 min-w-4 items-center justify-center rounded-full bg-ola-accent px-1"
            style={{ borderWidth: 2, borderColor: '#7cb342' }}
          >
            <Text className="text-[10px] font-bold text-white">{badge > 99 ? '99+' : badge}</Text>
          </View>
        )}
      </View>
      {active && <View className="absolute bottom-0 left-0 right-0 h-0.5 bg-white" />}
    </Pressable>
  );
}

export function ChatListScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const conversations = useChatStore((s) => s.conversations);
  const loading = useChatStore((s) => s.loadingConversations);
  const loadConversations = useChatStore((s) => s.loadConversations);
  const hideConversation = useChatStore((s) => s.hideConversation);

  const [sub, setSub] = useState<ChatSub>('messages');

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  const openConversation = useCallback(
    (id: string) => navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: id }),
    [navigation]
  );

  const totalUnread = conversations.reduce((sum, item) => sum + (item.unreadCount ?? 0), 0);

  return (
    <View className="flex-1 bg-white">
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-stretch">
          <HeaderTab
            label={t('home.subMessages')}
            active={sub === 'messages'}
            badge={totalUnread}
            onPress={() => setSub('messages')}
          />
          <HeaderTab
            label={t('home.subContacts')}
            active={sub === 'contacts'}
            onPress={() => setSub('contacts')}
          />
          <Pressable className="w-11 items-center justify-center" onPress={() => undefined}>
            <Image source={moreIcon} style={{ width: 20, height: 20, tintColor: '#fff' }} resizeMode="contain" />
          </Pressable>
        </View>
      </View>

      {sub === 'contacts' ? (
        <ContactsPane />
      ) : loading && conversations.length === 0 ? (
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
          ItemSeparatorComponent={() => (
            <View style={{ marginHorizontal: 16, height: 1, backgroundColor: DIVIDER }} />
          )}
          ListEmptyComponent={
            <View className="mt-24 items-center">
              <Text className="text-sm" style={{ color: 'rgba(0,0,0,0.4)' }}>
                {t('home.contactsEmpty')}
              </Text>
            </View>
          }
          renderItem={({ item }) => (
            <ConversationRow
              conversation={item}
              onPress={() => openConversation(item.id)}
              onDelete={() => void hideConversation(item.id)}
            />
          )}
        />
      )}
    </View>
  );
}
