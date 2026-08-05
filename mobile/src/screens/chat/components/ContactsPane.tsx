import { useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import {
  ActivityIndicator,
  Image,
  Pressable,
  ScrollView,
  Text,
  TextInput,
  View,
} from 'react-native';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import { activeVipTypeId, colorForName, isVipActive } from '@ola/shared/lib';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { useMediaViewerStore } from '@store/mediaViewerStore';
import { VipAvatar } from '@components/ui/VipAvatar';
import { CachedImage } from '@components/ui/CachedImage';
import { MessageActionSheet, type MessageSheetAction } from '@screens/room/components/MessageActionSheet';
import { AddContactDialog } from './AddContactDialog';
import { BuddyRow } from './BuddyRow';
import { StatusEditDialog } from './StatusEditDialog';
import { mapFriendsToContacts, type Contact } from '../contacts';
import { SUGGESTED_FRIENDS } from '@screens/friends/constants';
import { useFriendsStore } from '@ola/shared/stores/friendsStore';
import { useFriendsWithPresence } from '@hooks/usePresence';
import { VipBadge } from '@components/ui/VipBadge';
import { BotAvatar } from '@screens/chat-bot/components/BotAvatar';
import { DIVIDER } from '@constants';

const snapPicIcon = require('@assets/icons/chat/icon_snap_pic.png');
const addFriendIcon = require('@assets/icons/room/ic_add_friend.png');
const searchIcon = require('@assets/icons/chat/ic_search_gray.png');
const peopleIcon = require('@assets/icons/chat/ic_people_gray.png');

function ActionRow({
  badge,
  title,
  subtitle,
  showChevron = false,
  onPress,
}: {
  badge: React.ReactNode;
  title: string;
  subtitle: string;
  showChevron?: boolean;
  onPress?: () => void;
}) {
  return (
    <Pressable
      onPress={onPress}
      className="flex-row items-center gap-3 bg-white px-4 py-3"
      style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
    >
      {badge}
      <View className="min-w-0 flex-1">
        <Text className="text-base text-ola-ink">{title}</Text>
        <Text className="text-xs text-ola-ink-soft">{subtitle}</Text>
      </View>
      {showChevron && <Text className="text-xl text-ola-ink-hint">›</Text>}
    </Pressable>
  );
}

function SectionHeader({ label }: { label: string }) {
  return (
    <View className="h-9 justify-center px-4" style={{ backgroundColor: '#d5d5d5' }}>
      <Text className="text-sm font-medium text-white" numberOfLines={1}>{label}</Text>
    </View>
  );
}

export function ContactsPane({ onAccountMenu }: { onAccountMenu?: () => void }) {
  const { t, i18n } = useTranslation();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const me = useAuthStore((s) => s.user);
  const startDirect = useChatStore((s) => s.startDirect);
  const openViewer = useMediaViewerStore((s) => s.openViewer);
  const push = useToastStore((s) => s.push);

  const friends = useFriendsWithPresence();
  const requests = useFriendsStore((s) => s.requests);
  const friendsLoading = useFriendsStore((s) => s.loading);
  const friendsLoaded = useFriendsStore((s) => s.loaded);
  const [query, setQuery] = useState('');
  const [menuContact, setMenuContact] = useState<Contact | null>(null);
  const [addOpen, setAddOpen] = useState(false);
  const [statusOpen, setStatusOpen] = useState(false);
  const [now, setNow] = useState(() => Date.now());

  useEffect(() => {
    const interval = setInterval(() => setNow(Date.now()), 60_000);
    return () => clearInterval(interval);
  }, []);

  useEffect(() => {
    const store = useFriendsStore.getState();
    if (!store.loaded && !store.loading) {
      void store.loadFriends().then((ok) => {
        if (!ok) push('error', t('chat.loadFriendsError'));
      });
    }
    store.loadRequests();
  }, [push, t]);

  const contacts = useMemo(
    () => mapFriendsToContacts(friends, i18n.language, now),
    [friends, i18n.language, now],
  );

  const filtered = useMemo(() => {
    const term = query.trim().toLowerCase();
    if (term === '') return contacts;
    return contacts.filter(
      (c) => c.name.toLowerCase().includes(term) || (c.fullName ?? '').toLowerCase().includes(term)
    );
  }, [contacts, query]);

  const sections = useMemo(() => {
    const pick = (predicate: (c: Contact) => boolean) => filtered.filter(predicate);
    return [
      { key: 'birthday', label: t('chat.sectionBirthday'), highlight: false, items: pick((c) => c.group === 'birthday') },
      { key: 'online', label: t('chat.sectionOnline'), highlight: false, items: pick((c) => c.group === 'friend' && c.online) },
      { key: 'friend', label: t('chat.sectionFriend'), highlight: false, items: pick((c) => c.group === 'friend' && !c.online) },
    ].filter((section) => section.items.length > 0);
  }, [filtered, t]);

  async function openContact(contact: Contact) {
    const conversation = await startDirect(contact.id);
    if (conversation != null && conversation.id !== '') {
      navigation.navigate(ROOT_ROUTES.ChatDetail, { conversationId: conversation.id });
      return;
    }
    if (useChatStore.getState().draftRecipient != null) {
      navigation.navigate(ROOT_ROUTES.ChatDetail, {});
    } else {
      push('error', t('chat.actionError'));
    }
  }

  const hasStatus = me?.bio != null && me.bio !== '';
  const hasVip = isVipActive(me?.vipEndTime);
  const meVipTypeId = activeVipTypeId(me?.vipUsed, me?.vipEndTime);
  const hasBioImage = me?.bioImage != null && me.bioImage !== '';

  const menuActions: MessageSheetAction[] = [
    { key: 'view', label: t('chat.menuViewMe'), onSelect: () => push('info', t('chat.comingSoon')) },
    { key: 'alias', label: t('chat.changeAlias'), onSelect: () => push('info', t('chat.comingSoon')) },
    { key: 'delete', label: t('dialog.delete'), destructive: true, onSelect: () => push('info', t('chat.comingSoon')) },
    { key: 'block', label: t('chat.menuBlock'), onSelect: () => push('info', t('chat.comingSoon')) },
  ];

  return (
    <View className="flex-1" style={{ backgroundColor: '#f3f3f3' }}>
      <View className="px-4 py-3" style={{ backgroundColor: '#d5d5d5', borderBottomWidth: 1, borderBottomColor: '#b2b2b2' }}>
        <View
          className="h-10 flex-row items-center gap-2 rounded bg-white px-3"
          style={{ borderWidth: 1, borderColor: '#b2b2b2' }}
        >
          <Image source={searchIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
          <TextInput
            value={query}
            onChangeText={setQuery}
            placeholder={t('chat.searchContacts')}
            placeholderTextColor="rgba(0,0,0,0.26)"
            className="flex-1 text-base"
            style={{ color: 'rgba(0,0,0,0.87)', paddingVertical: 0 }}
          />
        </View>
      </View>

      <ScrollView keyboardShouldPersistTaps="handled">
        {me != null && (
          <View style={{ backgroundColor: '#fff', borderBottomWidth: 1, borderBottomColor: DIVIDER }}>
            {!hasVip && (
              <View className="p-2">
                <Pressable
                  onPress={() => push('info', t('chat.comingSoon'))}
                  className="rounded bg-white px-3 py-2"
                  style={{ borderWidth: 1, borderColor: '#ff8f00' }}
                >
                  <Text className="text-sm font-medium text-ola-accent">{t('chat.vipBannerTitle')}</Text>
                  <Text className="text-xs text-ola-ink-soft">{t('chat.vipBannerSub')}</Text>
                </Pressable>
              </View>
            )}
            <View className="flex-row items-center gap-2 px-4 py-2" style={{ minHeight: 72 }}>
              <Pressable onPress={onAccountMenu}>
                <VipAvatar typeId={meVipTypeId} size={40} />
              </Pressable>
              <Pressable className="min-w-0 flex-1" onPress={() => setStatusOpen(true)}>
                <Text
                  className="text-base italic"
                  style={{ color: hasStatus ? 'rgba(0,0,0,0.87)' : 'rgba(0,0,0,0.26)' }}
                  numberOfLines={1}
                >
                  {hasStatus ? me.bio : t('chat.myStatusHint')}
                </Text>
              </Pressable>
              <Pressable
                onPress={() => {
                  if (hasBioImage) openViewer([me.bioImage!]);
                }}
              >
                <CachedImage
                  uri={hasBioImage ? me.bioImage! : undefined}
                  placeholder={snapPicIcon}
                  style={{ width: 36, height: 36 }}
                  resizeMode="cover"
                  placeholderResizeMode="contain"
                />
              </Pressable>
            </View>
          </View>
        )}

        {requests.length > 0 && (
          <Pressable
            onPress={() => navigation.navigate(ROOT_ROUTES.FriendRequests)}
            className="flex-row items-center gap-3 bg-white px-4 py-2"
            style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
          >
            <View className="h-10 w-10 items-center justify-center rounded-full bg-ola-primary">
              <Image source={addFriendIcon} style={{ width: 24, height: 24, tintColor: '#fff' }} resizeMode="contain" />
            </View>
            <View className="min-w-0 flex-1">
              <Text className="text-base text-ola-ink">{t('chat.friendRequests')}</Text>
              <View className="mt-1 flex-row items-center gap-2">
                {requests.slice(0, 3).map((rel) => {
                  const requester = rel.requester;
                  const name = requester?.fullName || requester?.username || '';
                  const vipTypeId = activeVipTypeId(requester?.vipUsed, requester?.vipEndTime);
                  return (
                    <View key={rel.id} className="relative">
                      {requester?.avatar ? (
                        <CachedImage uri={requester.avatar} style={{ width: 28, height: 28, borderRadius: 4 }} />
                      ) : (
                        <View
                          className="h-7 w-7 items-center justify-center rounded"
                          style={{ backgroundColor: colorForName(requester?.id ?? name) }}
                        >
                          <Text className="text-xs font-semibold text-white">
                            {name.trim().charAt(0).toUpperCase() || '?'}
                          </Text>
                        </View>
                      )}
                      {vipTypeId != null && (
                        <View className="absolute" style={{ right: -4, bottom: -4 }}>
                          <VipBadge typeId={vipTypeId} size={14} />
                        </View>
                      )}
                    </View>
                  );
                })}
              </View>
            </View>
            <View className="h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1">
              <Text className="text-[10px] font-bold text-white">{requests.length}</Text>
            </View>
            <Text className="text-xl text-ola-ink-hint">›</Text>
          </Pressable>
        )}

        <Pressable
          onPress={() => navigation.navigate(ROOT_ROUTES.SuggestedFriends)}
          className="flex-row items-center gap-3 bg-white px-4 py-2"
          style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}
        >
          <View className="h-10 w-10 items-center justify-center rounded-full" style={{ backgroundColor: '#e0e0e0' }}>
            <Image source={peopleIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </View>
          <View className="min-w-0 flex-1">
            <Text className="text-base text-ola-ink">{t('chat.suggestFriends')}</Text>
            <View className="mt-1 flex-row items-center gap-2">
              {SUGGESTED_FRIENDS.slice(0, 3).map((friend) => (
                <View
                  key={friend.name}
                  className="h-7 w-7 items-center justify-center rounded"
                  style={{ backgroundColor: friend.color }}
                >
                  <Text className="text-xs font-semibold text-white">{friend.name.charAt(0).toUpperCase()}</Text>
                </View>
              ))}
            </View>
          </View>
          <View className="h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1">
            <Text className="text-[10px] font-bold text-white">{SUGGESTED_FRIENDS.length}</Text>
          </View>
          <Text className="text-xl text-ola-ink-hint">›</Text>
        </Pressable>

        <SectionHeader label={t('chat.sectionApps')} />
        <ActionRow
          badge={<BotAvatar size={48} radius={8} />}
          title={t('chat.chatBot')}
          subtitle={t('chat.chatBotSub')}
          showChevron
          onPress={() => navigation.navigate(ROOT_ROUTES.ChatBot)}
        />

        {friendsLoading && !friendsLoaded ? (
          <View className="items-center py-8">
            <ActivityIndicator color="#7cb342" />
          </View>
        ) : (
          sections.map((section) => (
            <View key={section.key}>
              <SectionHeader label={section.label} />
              {section.items.map((contact) => (
                <BuddyRow
                  key={contact.id}
                  contact={contact}
                  highlight={section.highlight}
                  onSelect={() => void openContact(contact)}
                  onOpenProfile={() =>
                    navigation.navigate(ROOT_ROUTES.ProfileView, { userId: contact.id, color: contact.color })
                  }
                  onLongPress={() => setMenuContact(contact)}
                  onPreviewImage={(url) => openViewer([url])}
                />
              ))}
            </View>
          ))
        )}
      </ScrollView>

      <Pressable
        onPress={() => setAddOpen(true)}
        className="absolute h-14 w-14 items-center justify-center rounded-full bg-ola-primary"
        style={{
          right: 16,
          bottom: 16,
          elevation: 4,
          shadowColor: '#000',
          shadowOpacity: 0.3,
          shadowRadius: 6,
          shadowOffset: { width: 0, height: 3 },
        }}
      >
        <Image source={addFriendIcon} style={{ width: 24, height: 24, tintColor: '#fff' }} resizeMode="contain" />
      </Pressable>

      <MessageActionSheet
        visible={menuContact != null}
        actions={menuActions}
        showReactions={false}
        onReact={() => undefined}
        onClose={() => setMenuContact(null)}
      />

      {addOpen && (
        <AddContactDialog
          onClose={() => setAddOpen(false)}
          onOpenProfile={(username) => {
            setAddOpen(false);
            navigation.navigate(ROOT_ROUTES.ProfileView, { userId: username });
          }}
        />
      )}

      {statusOpen && <StatusEditDialog onClose={() => setStatusOpen(false)} />}
    </View>
  );
}
