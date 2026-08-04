import { useCallback, useEffect, useLayoutEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  RefreshControl,
  Text,
  View,
} from 'react-native';
import ReanimatedSwipeable, {
  type SwipeableMethods,
} from 'react-native-gesture-handler/ReanimatedSwipeable';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { FlashList } from '@shopify/flash-list';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { formatOlaTime } from '@ola/shared/lib';
import { AuthService, SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { totalUnreadOf } from '@ola/shared/stores/chat/chatHelpers';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { Conversation } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { Avatar } from '@components/ui/Avatar';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { useAppTypography } from '@components/AppFontProvider';
import { kulImageForText } from '@lib/kul';
import { SmileyText } from '@lib/richText';
import { ListOptionDialog, type ListOption } from '@components/ui/ListOptionDialog';
import { BlockedListDialog } from './components/BlockedListDialog';
import { ComposeDialog } from './components/ComposeDialog';
import { ChangeAvatarDialog } from './components/ChangeAvatarDialog';
import { ChangeCoverDialog } from './components/ChangeCoverDialog';
import { ContactsPane } from './components/ContactsPane';
import { useConversationsWithPresence, usePresenceListPolling } from '@hooks/usePresence';
import { DIVIDER } from '@constants';
import { SWIPE_MAX, SWIPE_TRIGGER } from './constants';

const sentIcon = require('@assets/icons/chat/ic_message_sent.png');
const kulIcon = require('@assets/icons/chat/ic_kul.png');
const moreIcon = require('@assets/icons/chat/ic_more_white.png');
const composeIcon = require('@assets/icons/chat/ic_action_compose_message.png');

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
  smileyFontSize: number;
  now: number;
  onPress: () => void;
  onRequestDelete: (conversation: Conversation) => void;
  onSwipeableWillOpen: (swipeable: SwipeableMethods) => void;
  onSwipeableClose: (swipeable: SwipeableMethods) => void;
}

function ConversationRow({
  conversation,
  smileyFontSize,
  now,
  onPress,
  onRequestDelete,
  onSwipeableWillOpen,
  onSwipeableClose,
}: RowProps) {
  const { t, i18n } = useTranslation();
  const swipeableRef = useRef<SwipeableMethods>(null);
  const openRef = useRef(false);

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

  useLayoutEffect(() => {
    const swipeable = swipeableRef.current;
    swipeable?.reset();
    swipeable?.close();
    openRef.current = false;
    if (swipeable != null) onSwipeableClose(swipeable);
    return () => {
      openRef.current = false;
      if (swipeable != null) onSwipeableClose(swipeable);
    };
  }, [conversation.id, onSwipeableClose]);

  function handlePress() {
    if (openRef.current) {
      swipeableRef.current?.close();
      return;
    }
    onPress();
  }

  return (
    <ReanimatedSwipeable
      ref={swipeableRef}
      rightThreshold={SWIPE_TRIGGER}
      overshootLeft={false}
      overshootRight={false}
      onSwipeableWillOpen={() => {
        const swipeable = swipeableRef.current;
        if (swipeable == null) return;
        openRef.current = true;
        onSwipeableWillOpen(swipeable);
      }}
      onSwipeableClose={() => {
        const swipeable = swipeableRef.current;
        openRef.current = false;
        if (swipeable != null) onSwipeableClose(swipeable);
      }}
      renderRightActions={(_progress, _translation, swipeable) => (
        <Pressable
          accessibilityRole="button"
          accessibilityLabel={t('dialog.deleteAria', { name })}
          onPress={() => {
            swipeable.close();
            openRef.current = false;
            onSwipeableClose(swipeable);
            onRequestDelete(conversation);
          }}
          className="h-full items-center justify-center"
          style={{ width: SWIPE_MAX, backgroundColor: '#dd4b39' }}
        >
          <Text className="text-sm font-medium text-white">{t('dialog.delete')}</Text>
        </Pressable>
      )}
    >
      <Pressable
        onPress={handlePress}
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
              className={`flex-1 text-base text-ola-ink ${unread ? 'font-bold' : ''}`}
              numberOfLines={1}
            >
              {title}
            </Text>
            <Text
              className={`text-xs ${unread ? 'font-bold' : ''}`}
              style={{ color: unread ? 'rgba(0,0,0,0.87)' : 'rgba(0,0,0,0.54)' }}
            >
              {formatOlaTime(conversation.lastMessageAt ?? '', i18n.language, now)}
            </Text>
          </View>
          <View className="mt-0.5 flex-row items-center gap-1">
            <View className="min-w-0 flex-1 flex-row items-center">
              {prefix !== '' && (
                <Text className="text-sm text-ola-ink" numberOfLines={1}>
                  {prefix}
                </Text>
              )}
              {isSticker ? (
                <View className="flex-row items-center gap-1">
                  <Image source={kulIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
                  <Text className="text-sm text-ola-ink">
                    {t('chat.stickerPreview')}
                  </Text>
                </View>
              ) : (
                <Text className="flex-1 text-sm text-ola-ink" numberOfLines={1}>
                  <SmileyText text={lastText} fontSize={smileyFontSize} />
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
    </ReanimatedSwipeable>
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
  const { multiplier: fontMultiplier, systemFontScale } = useAppTypography();
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
  const [deleteTarget, setDeleteTarget] = useState<Conversation | null>(null);
  const [deleteArchived, setDeleteArchived] = useState(false);
  const [blockedOpen, setBlockedOpen] = useState(false);
  const [showStrangers, setShowStrangers] = useState(true);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [avatarOpen, setAvatarOpen] = useState(false);
  const [coverOpen, setCoverOpen] = useState(false);
  const [logoutAll, setLogoutAll] = useState(false);
  const [now, setNow] = useState(() => Date.now());
  const openSwipeableRef = useRef<SwipeableMethods | null>(null);

  useEffect(() => {
    void loadConversations();
  }, [loadConversations]);

  useEffect(() => {
    const interval = setInterval(() => setNow(Date.now()), 60_000);
    return () => clearInterval(interval);
  }, []);

  usePresenceListPolling();

  const openConversation = useCallback(
    (id: string) => navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: id }),
    [navigation]
  );

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

  const requestDelete = useCallback((conversation: Conversation) => {
    setDeleteArchived(false);
    setDeleteTarget(conversation);
  }, []);

  const closeOpenSwipeable = useCallback(() => {
    openSwipeableRef.current?.close();
    openSwipeableRef.current = null;
  }, []);

  const handleSwipeableWillOpen = useCallback((swipeable: SwipeableMethods) => {
    if (openSwipeableRef.current !== swipeable) openSwipeableRef.current?.close();
    openSwipeableRef.current = swipeable;
  }, []);

  const handleSwipeableClose = useCallback((swipeable: SwipeableMethods) => {
    if (openSwipeableRef.current === swipeable) openSwipeableRef.current = null;
  }, []);

  async function confirmDeleteConversation() {
    const target = deleteTarget;
    if (target == null) return;
    setDeleteTarget(null);
    await hideConversation(target.id, { clearMessages: deleteArchived });
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
    { key: 'buy-vip', label: t('chat.menuBuyVip'), onSelect: () => navigation.navigate(ROOT_ROUTES.VipStore) },
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
  const smileyFontSize = 14 * fontMultiplier * systemFontScale;
  const listExtraData = useMemo(
    () => ({ now, smileyFontSize }),
    [now, smileyFontSize],
  );

  return (
    <View className="flex-1 bg-white">
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-stretch">
          <HeaderTab
            label={t('home.subMessages')}
            active={sub === 'messages'}
            badge={totalUnread}
            onPress={() => {
              closeOpenSwipeable();
              setSub('messages');
            }}
          />
          <HeaderTab
            label={t('home.subContacts')}
            active={sub === 'contacts'}
            onPress={() => {
              closeOpenSwipeable();
              setSub('contacts');
            }}
          />
          <Pressable
            className="w-11 items-center justify-center"
            onPress={() => {
              closeOpenSwipeable();
              setMenuOpen(true);
            }}
          >
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
          extraData={listExtraData}
          keyExtractor={(item) => item.id}
          onScrollBeginDrag={closeOpenSwipeable}
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
              smileyFontSize={smileyFontSize}
              now={now}
              onPress={() => openConversation(item.id)}
              onRequestDelete={requestDelete}
              onSwipeableWillOpen={handleSwipeableWillOpen}
              onSwipeableClose={handleSwipeableClose}
            />
          )}
        />
        <Pressable
          onPress={() => {
            closeOpenSwipeable();
            setComposeOpen(true);
          }}
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
        visible={deleteTarget != null}
        danger
        title={t('dialog.deleteConvTitle')}
        message={t('dialog.deleteConvMessage', {
          name: deleteTarget == null ? '' : displayName(deleteTarget),
        })}
        confirmLabel={t('dialog.delete')}
        cancelLabel={t('dialog.cancel')}
        checkboxLabel={t('dialog.deleteArchived')}
        checked={deleteArchived}
        onCheckedChange={setDeleteArchived}
        onConfirm={() => void confirmDeleteConversation()}
        onCancel={() => setDeleteTarget(null)}
      />

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
