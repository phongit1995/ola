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
import { formatClockHM } from '@ola/shared/lib';
import { AuthService, SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { totalUnreadOf } from '@ola/shared/stores/chat/chatHelpers';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { Conversation } from '@ola/shared/types';
import type { RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES } from '../../navigation/routes';
import { Avatar } from '../../components/Avatar';
import { ConfirmDialog } from '../../components/ConfirmDialog';
import { kulImageForText } from '../../lib/kul';
import { SmileyText } from '../../lib/richText';
import { ListOptionDialog, type ListOption } from '../../components/ListOptionDialog';
import { BlockedListDialog } from './BlockedListDialog';
import { ComposeDialog } from './ComposeDialog';
import { ChangeAvatarDialog } from './ChangeAvatarDialog';
import { ChangeCoverDialog } from './ChangeCoverDialog';
import { ContactsPane } from './ContactsPane';
import { useConversationsWithPresence, usePresenceListPolling } from '../../hooks/usePresence';

const sentIcon = require('../../assets/icons/chat/ic_message_sent.png');
const kulIcon = require('../../assets/icons/chat/ic_kul.png');
const moreIcon = require('../../assets/icons/chat/ic_more_white.png');
const composeIcon = require('../../assets/icons/chat/ic_action_compose_message.png');

const SWIPE_MAX = 88;
const SWIPE_TRIGGER = 56;
const DIVIDER = 'rgba(0,0,0,0.12)';

function ConversationSeparator() {
  return <View style={{ marginHorizontal: 16, height: 1, backgroundColor: DIVIDER }} />;
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
                {formatClockHM(conversation.lastMessageAt)}
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
                    <SmileyText text={lastText} fontSize={14} />
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
          className={`text-sm font-bold ${active ? 'text-white' : 'text-white/70'}`}
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
  const conversations = useConversationsWithPresence();
  const loading = useChatStore((s) => s.loadingConversations);
  const loadConversations = useChatStore((s) => s.loadConversations);
  const hideConversation = useChatStore((s) => s.hideConversation);
  const deleteAllConversations = useChatStore((s) => s.deleteAllConversations);
  const startDirect = useChatStore((s) => s.startDirect);
  const pushToast = useToastStore((s) => s.push);

  const [sub, setSub] = useState<ChatSub>('messages');
  const [menuOpen, setMenuOpen] = useState(false);
  const [composeOpen, setComposeOpen] = useState(false);
  const [deleteAllOpen, setDeleteAllOpen] = useState(false);
  const [blockedOpen, setBlockedOpen] = useState(false);
  const [showStrangers, setShowStrangers] = useState(true);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [avatarOpen, setAvatarOpen] = useState(false);
  const [coverOpen, setCoverOpen] = useState(false);
  const [logoutAll, setLogoutAll] = useState(false);

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  usePresenceListPolling();

  const openConversation = useCallback(
    (id: string) => navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: id }),
    [navigation]
  );

  const comingSoon = () => pushToast('info', t('chat.comingSoon'));

  async function startCompose(userId: string) {
    setComposeOpen(false);
    const conversation = await startDirect(userId);
    if (conversation != null && conversation.id !== '') {
      navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: conversation.id });
      return;
    }
    if (useChatStore.getState().draftRecipient != null) {
      navigation.navigate(ROOT_ROUTES.ChatDetail, {});
    } else {
      pushToast('error', t('chat.actionError'));
    }
  }

  async function confirmDeleteAll() {
    setDeleteAllOpen(false);
    await deleteAllConversations();
    pushToast('success', t('chat.deleteAllDone'));
  }

  async function confirmLogout() {
    setLogoutOpen(false);
    try {
      await AuthService.logout();
    } catch {
      pushToast('error', t('chat.logoutError'));
    } finally {
      SocketService.disconnect();
      useAuthStore.getState().clearUser();
    }
  }

  const messagesMenu: ListOption[] = [
    { key: 'delete-all', label: t('chat.menuDeleteAll'), danger: true, onSelect: () => setDeleteAllOpen(true) },
    {
      key: 'strangers',
      label: showStrangers ? t('chat.menuDeleteStrangers') : t('chat.menuShowStrangers'),
      onSelect: () => setShowStrangers((value) => !value),
    },
    { key: 'block-list', label: t('chat.menuBlockList'), onSelect: () => setBlockedOpen(true) },
  ];

  const contactsMenu: ListOption[] = [
    { key: 'buy-vip', label: t('chat.menuBuyVip'), onSelect: comingSoon },
    { key: 'change-avatar', label: t('chat.menuChangeAvatar'), onSelect: () => setAvatarOpen(true) },
    { key: 'change-cover', label: t('chat.menuChangeCover'), onSelect: () => setCoverOpen(true) },
    {
      key: 'logout',
      label: t('chat.menuLogout'),
      onSelect: () => {
        setLogoutAll(false);
        setLogoutOpen(true);
      },
    },
    {
      key: 'logout-all',
      label: t('chat.menuLogoutAll'),
      onSelect: () => {
        setLogoutAll(true);
        setLogoutOpen(true);
      },
    },
  ];

  const totalUnread = totalUnreadOf(conversations);

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
          <Pressable className="w-11 items-center justify-center" onPress={() => setMenuOpen(true)}>
            <Image source={moreIcon} style={{ width: 20, height: 20, tintColor: '#fff' }} resizeMode="contain" />
          </Pressable>
        </View>
      </View>

      {sub === 'contacts' ? (
        <ContactsPane onAccountMenu={() => setMenuOpen(true)} />
      ) : loading && conversations.length === 0 ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : (
        <View className="flex-1">
        <FlashList
          data={conversations}
          keyExtractor={(item) => item.id}
          refreshControl={
            <RefreshControl refreshing={loading} onRefresh={() => void loadConversations()} />
          }
          ItemSeparatorComponent={ConversationSeparator}
          ListEmptyComponent={
            <View className="gap-2 bg-white p-4">
              <Text className="text-base font-medium text-gray-900">
                {t('chat.emptyMessagesTitle')}
              </Text>
              <Text className="text-sm text-gray-500">{t('chat.emptyMessagesBody')}</Text>
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
        <Pressable
          onPress={() => setComposeOpen(true)}
          className="absolute h-14 w-14 items-center justify-center rounded-full bg-ola-primary"
          style={{
            right: 16,
            bottom: 16,
            elevation: 4,
            shadowColor: '#000',
            shadowOpacity: 0.3,
            shadowRadius: 4,
            shadowOffset: { width: 0, height: 2 },
          }}
        >
          <Image source={composeIcon} style={{ width: 24, height: 24, tintColor: '#fff' }} resizeMode="contain" />
        </Pressable>
        </View>
      )}

      <ListOptionDialog
        visible={menuOpen}
        title={sub === 'messages' ? t('home.subMessages') : t('home.subContacts')}
        options={sub === 'messages' ? messagesMenu : contactsMenu}
        onClose={() => setMenuOpen(false)}
      />

      {composeOpen && (
        <ComposeDialog onClose={() => setComposeOpen(false)} onStart={(id) => void startCompose(id)} />
      )}

      {blockedOpen && <BlockedListDialog onClose={() => setBlockedOpen(false)} />}

      <ChangeAvatarDialog visible={avatarOpen} onClose={() => setAvatarOpen(false)} />
      <ChangeCoverDialog visible={coverOpen} onClose={() => setCoverOpen(false)} />

      <ConfirmDialog
        visible={deleteAllOpen}
        danger
        title={t('chat.menuDeleteAll')}
        message={t('chat.menuDeleteAllConfirm')}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => void confirmDeleteAll()}
        onCancel={() => setDeleteAllOpen(false)}
      />

      <ConfirmDialog
        visible={logoutOpen}
        danger
        title={logoutAll ? t('chat.menuLogoutAll') : t('chat.menuLogout')}
        message={t('dialog.logoutMessage')}
        confirmLabel={t('dialog.logoutButton')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => void confirmLogout()}
        onCancel={() => setLogoutOpen(false)}
      />
    </View>
  );
}
