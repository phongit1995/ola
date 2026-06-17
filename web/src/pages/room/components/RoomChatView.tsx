import { useCallback, useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import groupMessageIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';
import { useRoomChatStore } from '@/store/roomChatStore';
import { useAuthStore } from '@/store/authStore';
import { ScreenHeader, FullScreenOverlay } from '@components';
import { RoomTabBar, type RoomTabItem } from './RoomTabBar';
import { RoomMessagesTab } from './RoomMessagesTab';
import { RoomMembersTab } from './RoomMembersTab';
import { UserProfileView } from '../../profile/UserProfileView';

interface ProfileTarget {
  username: string;
  color: string;
}

interface RoomChatViewProps {
  onClose: () => void;
}

export function RoomChatView({ onClose }: RoomChatViewProps) {
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
  const currentUserId = useAuthStore((state) => state.user?.id) ?? '';
  const [profileTarget, setProfileTarget] = useState<ProfileTarget | null>(null);

  useEffect(() => {
    setRoomForeground(true);
    return () => setRoomForeground(false);
  }, [setRoomForeground]);

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
      <ScreenHeader title={name} onBack={onClose} align="center" />
      <div className="flex shrink-0 justify-center">
        <span className="h-px w-full bg-[repeating-linear-gradient(to_right,rgba(0,0,0,.3)_0_4px,transparent_4px_16px)]" />
      </div>
      <RoomTabBar tabs={tabs} activeTab={activeTab} onSelect={setActiveTab} />
      <RoomMessagesTab
        currentUserId={currentUserId}
        messages={messages}
        status={status}
        active={activeTab === 'messages'}
        onSend={sendMessage}
        onOpenProfile={openProfile}
      />
      <RoomMembersTab
        members={members}
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
    </FullScreenOverlay>
  );
}
