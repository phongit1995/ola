import { useTranslation } from 'react-i18next';
import addFriendIcon from '@/assets/icons/chat/ic_add_friend.png';
import groupMessageIcon from '@/assets/icons/room/ic_notify_new_chat_group_message.png';
import { useRoomChatStore } from '@/store/roomChatStore';
import { useAuthStore } from '@/store/authStore';
import { RoomHeader } from './RoomHeader';
import { RoomTabBar, type RoomTabItem } from './RoomTabBar';
import { RoomMessagesTab } from './RoomMessagesTab';
import { RoomMembersTab } from './RoomMembersTab';

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
  const setActiveTab = useRoomChatStore((state) => state.setActiveTab);
  const sendMessage = useRoomChatStore((state) => state.sendMessage);
  const currentUserId = useAuthStore((state) => state.user?.id) ?? '';

  const tabs: RoomTabItem[] = [
    { key: 'members', icon: addFriendIcon, label: `${t('room.tabMembers')} (${memberCount})` },
    { key: 'messages', icon: groupMessageIcon, label: t('room.tabMessages') },
  ];

  return (
    <div className="fixed inset-0 z-40 flex flex-col bg-[#eceff1]">
      <RoomHeader name={name} onBack={onClose} />
      <RoomTabBar tabs={tabs} activeTab={activeTab} onSelect={setActiveTab} />
      <RoomMessagesTab
        roomName={name}
        currentUserId={currentUserId}
        messages={messages}
        status={status}
        active={activeTab === 'messages'}
        onSend={sendMessage}
      />
      <RoomMembersTab members={members} active={activeTab === 'members'} />
    </div>
  );
}
