import { useCallback, useEffect, useRef } from 'react';
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

const sentIcon = require('../../assets/icons/chat/ic_message_sent.png');
const kulIcon = require('../../assets/icons/chat/ic_kul.png');

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
          className="flex-row items-center gap-3 px-4"
          style={{ minHeight: 72, backgroundColor: unread ? '#f1f8e9' : '#ffffff' }}
        >
          <View className="shrink-0">
            <Avatar name={name} uri={avatarUri} />
            {online && (
              <View className="absolute bottom-0 right-0 h-3.5 w-3.5 rounded-full bg-ola-primary" style={{ borderWidth: 2, borderColor: '#fff' }} />
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

export function ChatListScreen() {
  const { t } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const conversations = useChatStore((s) => s.conversations);
  const loading = useChatStore((s) => s.loadingConversations);
  const loadConversations = useChatStore((s) => s.loadConversations);
  const hideConversation = useChatStore((s) => s.hideConversation);

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  const openConversation = useCallback(
    (id: string) => navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: id }),
    [navigation]
  );

  return (
    <View className="flex-1 bg-white">
      <View className="h-12 items-center justify-center bg-ola-primary">
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
