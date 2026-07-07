import { useCallback, useEffect, useMemo, useState } from 'react';
import { useTranslation } from 'react-i18next';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import groupMessageIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';
import filterIcon from '@/assets/icons/room/ic_filter_unselected.png';
import { useRoomChatStore } from '@/store/roomChatStore';
import { useAuthStore } from '@/store/authStore';
import { useRoomFilterStore } from '../roomFilterStore';
import { ScreenHeader, FullScreenOverlay } from '@components';
import type { ReactionType, RoomMember } from '@app-types';
import { RoomTabBar, type RoomTabItem } from './RoomTabBar';
import { RoomMessagesTab } from './RoomMessagesTab';
import { RoomMembersTab } from './RoomMembersTab';
import { RoomFilterDialog } from './RoomFilterDialog';
import type { RoomFilters } from '../types';
import { UserProfileView } from '../../profile/UserProfileView';

interface ProfileTarget {
  username: string;
  color: string;
}

function memberMatchesFilter(member: RoomMember, filters: RoomFilters): boolean {
  if (filters.showAll) return true;
  const anyGender = filters.female || filters.male || filters.flexible;
  if (!anyGender) return true;
  if (filters.female && member.gender === 'female') return true;
  if (filters.male && member.gender === 'male') return true;
  if (filters.flexible && member.gender !== 'female' && member.gender !== 'male') return true;
  return false;
}

interface RoomChatViewProps {
  visible: boolean;
  onClose: () => void;
}

export function RoomChatView({ visible, onClose }: RoomChatViewProps) {
  const { t } = useTranslation();
  const name = useRoomChatStore((state) => state.activeRoom?.name ?? '');
  const status = useRoomChatStore((state) => state.status);
  const messages = useRoomChatStore((state) => state.messages);
  const members = useRoomChatStore((state) => state.members);
  const memberCount = useRoomChatStore((state) => state.memberCount);
  const activeTab = useRoomChatStore((state) => state.activeTab);
  const messagesUnread = useRoomChatStore((state) => state.messagesUnread);
  const setActiveTab = useRoomChatStore((state) => state.setActiveTab);
  const sendMessage = useRoomChatStore((state) => state.sendMessage);
  const setRoomForeground = useRoomChatStore((state) => state.setRoomForeground);
  const hasMore = useRoomChatStore((state) => state.hasMore);
  const loadingMore = useRoomChatStore((state) => state.loadingMore);
  const loadMoreMessages = useRoomChatStore((state) => state.loadMoreMessages);
  const replyTarget = useRoomChatStore((state) => state.replyTarget);
  const setReplyTarget = useRoomChatStore((state) => state.setReplyTarget);
  const clearReplyTarget = useRoomChatStore((state) => state.clearReplyTarget);
  const reactToRoomMessage = useRoomChatStore((state) => state.reactToRoomMessage);
  const deleteRoomMessage = useRoomChatStore((state) => state.deleteRoomMessage);
  const sendImage = useRoomChatStore((state) => state.sendImage);
  const resendRoomImage = useRoomChatStore((state) => state.resendRoomImage);
  const handleReact = useCallback(
    (messageId: string, type: ReactionType) => void reactToRoomMessage(messageId, type),
    [reactToRoomMessage]
  );
  const currentUserId = useAuthStore((state) => state.user?.id) ?? '';
  const [profileTarget, setProfileTarget] = useState<ProfileTarget | null>(null);
  const [filterOpen, setFilterOpen] = useState(false);
  const filters = useRoomFilterStore((state) => state.filters);
  const setFilters = useRoomFilterStore((state) => state.setFilters);
  const visibleMembers = useMemo(
    () => members.filter((member) => memberMatchesFilter(member, filters)),
    [members, filters]
  );

  useEffect(() => {
    setRoomForeground(visible);
    return () => setRoomForeground(false);
  }, [setRoomForeground, visible]);

  const openProfile = useCallback((username: string, color: string) => {
    setProfileTarget({ username, color });
  }, []);

  const tabs: RoomTabItem[] = [
    { key: 'members', icon: addFriendIcon, label: `${t('room.tabMembers')} (${memberCount})` },
    {
      key: 'messages',
      icon: groupMessageIcon,
      label: t('room.tabMessages'),
      indicator: messagesUnread && activeTab !== 'messages',
    },
  ];

  return (
    <FullScreenOverlay position="absolute">
      <ScreenHeader title={name} onBack={onClose} align="center">
        {activeTab === 'members' && (
          <button
            type="button"
            aria-label={t('room.filterTitle')}
            onClick={() => setFilterOpen(true)}
            className="flex h-9 w-9 items-center justify-center rounded-full hover:bg-white/15"
          >
            <img src={filterIcon} alt="" className="h-5 w-5 object-contain" />
          </button>
        )}
      </ScreenHeader>
      <div className="flex shrink-0 justify-center">
        <span className="h-px w-full bg-[repeating-linear-gradient(to_right,rgba(0,0,0,.3)_0_4px,transparent_4px_16px)]" />
      </div>
      <RoomTabBar tabs={tabs} activeTab={activeTab} onSelect={setActiveTab} />
      <RoomMessagesTab
        currentUserId={currentUserId}
        messages={messages}
        status={status}
        active={activeTab === 'messages'}
        visible={visible}
        hasMore={hasMore}
        loadingMore={loadingMore}
        replyTarget={replyTarget}
        onSend={sendMessage}
        onSendImage={sendImage}
        onResendImage={(id) => void resendRoomImage(id)}
        onLoadMore={loadMoreMessages}
        onOpenProfile={openProfile}
        onSetReplyTarget={setReplyTarget}
        onClearReplyTarget={clearReplyTarget}
        onReact={handleReact}
        onDeleteMessage={deleteRoomMessage}
      />
      <RoomMembersTab
        members={visibleMembers}
        active={activeTab === 'members'}
        onOpenProfile={openProfile}
      />

      {profileTarget != null && (
        <UserProfileView
          key={profileTarget.username}
          username={profileTarget.username}
          color={profileTarget.color}
          onClose={() => setProfileTarget(null)}
          onOpenFriend={(friend) => setProfileTarget({ username: friend.name, color: friend.color })}
        />
      )}

      <RoomFilterDialog
        key={filterOpen ? 'open' : 'closed'}
        open={filterOpen}
        value={filters}
        onApply={(value) => {
          setFilters(value);
          setFilterOpen(false);
        }}
        onClose={() => setFilterOpen(false)}
      />
    </FullScreenOverlay>
  );
}
