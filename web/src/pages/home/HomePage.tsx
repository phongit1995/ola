import { Suspense, useEffect, useState } from 'react';
import { SocketService } from '@services';
import { BottomTabBar, type TabKey } from '@components/BottomTabBar';
import { KenBalanceBadge } from '@components';
import { useAuthStore } from '@/store/authStore';
import { useRoomChatStore } from '@/store/roomChatStore';
import { useChatStore } from '@/store/chat/chatStore';
import { useGameOverlayStore } from '@/store/gameOverlayStore';
import { useAppOverlayStore } from '@/store/appOverlayStore';
import { ActiveConversationOverlay } from '../chat/ActiveConversationOverlay';
import { GameOverlay } from '../games/GameOverlay';
import { RoomChatOverlay } from '../room/RoomChatOverlay';
import { AppOverlay } from '../apps/AppOverlay';
import { ACTIVE_TAB_KEY, PANELS } from './constants';

function readStoredTab(): TabKey {
  const stored = sessionStorage.getItem(ACTIVE_TAB_KEY);
  return stored != null && stored in PANELS ? (stored as TabKey) : 'chat';
}

export function HomePage() {
  const [tab, setTab] = useState<TabKey>(readStoredTab);
  const roomUnread = useRoomChatStore((state) => state.hasUnread);
  const chatUnread = useChatStore((state) =>
    state.conversations.reduce((sum, item) => sum + (item.unreadCount ?? 0), 0)
  );
  const ActivePanel = PANELS[tab];
  const authReady = useAuthStore((state) => state.authReady);
  const ken = useAuthStore((state) => state.user?.ken);
  const roomActive = useRoomChatStore((state) => state.activeRoom != null);
  const chatActive = useChatStore(
    (state) => state.currentConversationId != null || state.draftRecipient != null
  );
  const gameActive = useGameOverlayStore((state) => state.active != null);
  const appActive = useAppOverlayStore((state) => state.stack.length > 0);
  const overlayActive = (tab === 'room' && roomActive) || chatActive || gameActive || appActive;

  function changeTab(next: TabKey) {
    sessionStorage.setItem(ACTIVE_TAB_KEY, next);
    setTab(next);
  }

  useEffect(() => {
    void useChatStore.getState().loadConversations();
  }, []);

  useEffect(() => {
    if (!authReady) return;
    SocketService.connect();
    return () => SocketService.disconnect();
  }, [authReady]);

  return (
    <div className="flex h-dvh flex-col bg-white font-sans">
      <div className="relative flex min-h-0 flex-1 flex-col">
        {!overlayActive && <KenBalanceBadge ken={ken} />}
        <Suspense fallback={<div className="flex-1" />}>
          <ActivePanel />
        </Suspense>
        {tab === 'room' && <RoomChatOverlay />}
      </div>

      <BottomTabBar
        active={tab}
        onChange={changeTab}
        badges={{ chat: chatUnread }}
        dots={{ room: roomUnread && tab !== 'room' }}
      />

      <ActiveConversationOverlay />
      <GameOverlay />
      <AppOverlay />
    </div>
  );
}
