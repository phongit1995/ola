import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import { KeyboardView } from '../../components/KeyboardView';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useIsFocused } from '@react-navigation/native';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import type { CompositeScreenProps, NavigationAction } from '@react-navigation/native';
import type { BottomTabScreenProps } from '@react-navigation/bottom-tabs';
import { useRoomChatStore, type RoomTab } from '@ola/shared/stores/roomChatStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { memberMatchesFilter, useRoomFilterStore } from '@ola/shared/stores/roomFilterStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { ReactionType } from '@ola/shared/types';
import type { MainTabParamList, RoomStackParamList, RootStackParamList } from '../../navigation/types';
import { ROOT_ROUTES, TAB_ROUTES } from '../../navigation/routes';
import { RoomMessagesTab } from './RoomMessagesTab';
import { RoomMembersTab } from './RoomMembersTab';
import { RoomFilterDialog } from './RoomFilterDialog';
import { ConfirmDialog } from '../../components/ConfirmDialog';

type Props = CompositeScreenProps<
  NativeStackScreenProps<RoomStackParamList, 'RoomChat'>,
  CompositeScreenProps<
    BottomTabScreenProps<MainTabParamList, typeof TAB_ROUTES.Room>,
    NativeStackScreenProps<RootStackParamList>
  >
>;

const membersIcon = require('../../assets/icons/room/ic_add_friend.png');
const messagesIcon = require('../../assets/icons/room/ic_notify_new_chat_group_message.png');
const backIcon = require('../../assets/icons/ic_back.png');
const filterIcon = require('../../assets/icons/room/ic_filter_unselected.png');

function DashedLine() {
  return (
    <View style={{ height: 1, flexDirection: 'row', overflow: 'hidden', backgroundColor: '#eceff1' }}>
      {Array.from({ length: 48 }).map((_, index) => (
        <View
          key={index}
          style={{ width: 4, height: 1, marginRight: 12, backgroundColor: 'rgba(0,0,0,0.3)' }}
        />
      ))}
    </View>
  );
}

function memberCountText(count: number): string {
  return count >= 200 ? '200+' : String(count);
}

function TabButton({
  label,
  count,
  icon,
  active,
  indicator,
  onPress,
}: {
  label: string;
  count?: number;
  icon: number;
  active: boolean;
  indicator?: boolean;
  onPress: () => void;
}) {
  return (
    <Pressable
      onPress={onPress}
      className="flex-1 flex-row items-center justify-center gap-1.5"
      style={{ opacity: active ? 1 : 0.6 }}
    >
      <Text className="text-sm font-medium text-white">
        {label}
        {count != null && <Text className="text-white"> ({memberCountText(count)})</Text>}
      </Text>
      <View>
        <Image source={icon} style={{ width: 20, height: 20, tintColor: '#ffffff' }} resizeMode="contain" />
        {indicator && (
          <View
            className="absolute h-2.5 w-2.5 rounded-full bg-ola-accent"
            style={{ top: -4, right: -4, borderWidth: 2, borderColor: '#7cb342' }}
          />
        )}
      </View>
      {active && <View className="absolute bottom-0 left-0 right-0 h-0.5 bg-white" />}
    </Pressable>
  );
}

export function RoomChatScreen({ navigation, route }: Props) {
  const { roomId, roomName } = route.params;
  const { t, i18n } = useTranslation();
  const insets = useSafeAreaInsets();

  const status = useRoomChatStore((s) => s.status);
  const activeTab = useRoomChatStore((s) => s.activeTab);
  const messages = useRoomChatStore((s) => s.messages);
  const members = useRoomChatStore((s) => s.members);
  const memberCount = useRoomChatStore((s) => s.memberCount);
  const messagesUnread = useRoomChatStore((s) => s.messagesUnread);
  const hasMore = useRoomChatStore((s) => s.hasMore);
  const loadingMore = useRoomChatStore((s) => s.loadingMore);
  const replyTarget = useRoomChatStore((s) => s.replyTarget);
  const open = useRoomChatStore((s) => s.open);
  const close = useRoomChatStore((s) => s.close);
  const setActiveTab = useRoomChatStore((s) => s.setActiveTab);
  const setRoomForeground = useRoomChatStore((s) => s.setRoomForeground);
  const sendMessage = useRoomChatStore((s) => s.sendMessage);
  const sendImage = useRoomChatStore((s) => s.sendImage);
  const resendRoomImage = useRoomChatStore((s) => s.resendRoomImage);
  const loadMoreMessages = useRoomChatStore((s) => s.loadMoreMessages);
  const setReplyTarget = useRoomChatStore((s) => s.setReplyTarget);
  const clearReplyTarget = useRoomChatStore((s) => s.clearReplyTarget);
  const reactToRoomMessage = useRoomChatStore((s) => s.reactToRoomMessage);
  const deleteRoomMessage = useRoomChatStore((s) => s.deleteRoomMessage);
  const currentUserId = useAuthStore((s) => s.user?.id) ?? '';
  const filters = useRoomFilterStore((s) => s.filters);
  const setFilters = useRoomFilterStore((s) => s.setFilters);
  const pushToast = useToastStore((s) => s.push);
  const [filterOpen, setFilterOpen] = useState(false);
  const [pendingLeave, setPendingLeave] = useState<NavigationAction | null>(null);
  const confirmedLeaveRef = useRef(false);
  const visibleMembers = useMemo(
    () => members.filter((member) => memberMatchesFilter(member, filters)),
    [members, filters]
  );

  useEffect(() => {
    void open({ id: roomId, name: roomName });
    return () => close();
  }, [roomId, roomName, open, close]);

  const isFocused = useIsFocused();
  useEffect(() => {
    setRoomForeground(isFocused);
  }, [isFocused, setRoomForeground]);

  useEffect(() => {
    const unsubscribe = navigation.addListener('beforeRemove', (event) => {
      if (confirmedLeaveRef.current) return;
      event.preventDefault();
      setPendingLeave(event.data.action);
    });
    return unsubscribe;
  }, [navigation]);

  const onSelectTab = useCallback((tab: RoomTab) => setActiveTab(tab), [setActiveTab]);
  const handleReact = useCallback(
    (messageId: string, type: ReactionType) => void reactToRoomMessage(messageId, type),
    [reactToRoomMessage]
  );
  const openUser = useCallback(
    (userId: string) => navigation.navigate(ROOT_ROUTES.ProfileView, { userId }),
    [navigation]
  );
  const openProfileByNick = useCallback(
    (nick: string, color: string) => navigation.navigate(ROOT_ROUTES.ProfileView, { userId: nick, color }),
    [navigation]
  );

  return (
    <KeyboardView
      className="flex-1 bg-white"
    >
      <View className="bg-ola-primary px-2 pb-2" style={{ paddingTop: insets.top + 8 }}>
        <View className="h-9 flex-row items-center justify-center">
          <Pressable
            className="absolute left-0 h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
            onPress={() => navigation.goBack()}
          >
            <Image source={backIcon} style={{ width: 24, height: 24 }} resizeMode="contain" />
          </Pressable>
          <Text className="px-12 text-center text-lg font-medium text-white" numberOfLines={1}>
            {roomName}
          </Text>
          {activeTab === 'members' && (
            <Pressable
              className="absolute right-0 h-9 w-9 items-center justify-center rounded-full active:bg-white/15"
              onPress={() => setFilterOpen(true)}
            >
              <Image source={filterIcon} style={{ width: 20, height: 20, tintColor: '#ffffff' }} resizeMode="contain" />
            </Pressable>
          )}
        </View>
      </View>
      <DashedLine />
      <View className="h-11 flex-row items-stretch bg-ola-primary">
          <TabButton
            label={t('room.tabMembers')}
            count={memberCount}
            icon={membersIcon}
            active={activeTab === 'members'}
            onPress={() => onSelectTab('members')}
          />
          <TabButton
            label={t('room.tabMessages')}
            icon={messagesIcon}
            active={activeTab === 'messages'}
            indicator={messagesUnread && activeTab !== 'messages'}
            onPress={() => onSelectTab('messages')}
          />
      </View>

      {status === 'connecting' ? (
        <View className="flex-1 items-center justify-center">
          <ActivityIndicator color="#7cb342" size="large" />
        </View>
      ) : activeTab === 'members' ? (
        <RoomMembersTab members={visibleMembers} onOpenUser={openUser} />
      ) : (
        <RoomMessagesTab
          currentUserId={currentUserId}
          language={i18n.language}
          messages={messages}
          status={status}
          hasMore={hasMore}
          loadingMore={loadingMore}
          replyTarget={replyTarget}
          onSend={sendMessage}
          onSendImage={sendImage}
          onResendImage={(id) => void resendRoomImage(id)}
          onLoadMore={loadMoreMessages}
          onOpenUser={openUser}
          onOpenProfile={openProfileByNick}
          onSetReplyTarget={setReplyTarget}
          onClearReplyTarget={clearReplyTarget}
          onReact={handleReact}
          onDeleteMessage={deleteRoomMessage}
        />
      )}

      <RoomFilterDialog
        visible={filterOpen}
        value={filters}
        onApply={(value) => {
          setFilters(value);
          setFilterOpen(false);
        }}
        onClose={() => setFilterOpen(false)}
      />

      <ConfirmDialog
        visible={pendingLeave != null}
        danger
        title={t('room.quitTitle')}
        message={t('room.quitMessage', { name: roomName })}
        confirmLabel={t('dialog.yes')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => {
          const action = pendingLeave;
          setPendingLeave(null);
          confirmedLeaveRef.current = true;
          pushToast('success', t('room.quitSuccess'));
          if (action != null) navigation.dispatch(action);
        }}
        onCancel={() => setPendingLeave(null)}
      />
    </KeyboardView>
  );
}
